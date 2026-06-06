#!/usr/bin/env bash

BASE_DIR="./lib/l10n"

to_camel_case() {
  local input="$1"
  local result=""
  local part
  local lower
  local first
  local rest

  # Known acronyms (lowercase keys → uppercase output)
  local acronyms="
api oauth http https id url ui uuid json xml
"

  # Normalize separators
  input="${input//-/_}"

  IFS="_" read -a parts <<< "$input"

  for part in "${parts[@]}"; do
    # lowercase manually
    lower=$(printf '%s' "$part" | tr '[:upper:]' '[:lower:]')

    # acronym check
    if [[ " $acronyms " == *" $lower "* ]]; then
      result+=$(printf '%s' "$lower" | tr '[:lower:]' '[:upper:]')
      continue
    fi

    # Capitalize first letter manually
    first=${lower:0:1}
    rest=${lower:1}

    first=$(printf '%s' "$first" | tr '[:lower:]' '[:upper:]')
    result+="$first$rest"
  done

  echo "$result"
}

EXIT_CODE=0

for dir in "$BASE_DIR"/*/; do
  # Skip if not a directory
  [ -d "$dir" ] || continue

  folder_name=$(basename "$dir")
  camel_name=$(to_camel_case "$folder_name")
  class_name="${camel_name}Localizations"

  report_file="$(mktemp -t "${folder_name}_untranslated")"

  echo "Generating l10n for: $folder_name -> $class_name"

  flutter gen-l10n \
    --arb-dir "./lib/l10n/$folder_name" \
    --template-arb-file "${folder_name}_en.arb" \
    --output-localization-file "${folder_name}_localizations.dart" \
    --output-class "$class_name" \
    --untranslated-messages-file "$report_file"

  if jq -e 'length == 0' "$report_file" > /dev/null; then
    echo "✅ All translations for '$folder_name' have been generated successfully !"
  else
    echo "⚠️  Untranslated messages for '$folder_name':"
    echo "-------------------------------------------"
    jq -r '
    to_entries[]
    | .key + ":\n" +
      ( .value
        | sort
        | map(" - " + .)
        | join("\n")
      )
    + "\n"
  ' "$report_file"
    echo "-------------------------------------------"
    EXIT_CODE=1
  fi

  rm -f "$report_file"
  echo

done

echo "Formatting generated files"
dart format $BASE_DIR
echo "✅ All generated files have been formatted successfully !"

echo
  
exit $EXIT_CODE