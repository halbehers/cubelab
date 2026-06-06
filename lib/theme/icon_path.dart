enum IconPath {
  empty("empty"),
  add("assets/icons/add.svg"),
  arrowLeft("assets/icons/arrow_left.svg"),
  arrowRight("assets/icons/arrow_right.svg"),
  arrowTop("assets/icons/arrow_top.svg"),
  arrowBottom("assets/icons/arrow_bottom.svg"),
  calendar("assets/icons/calendar.svg"),
  today("assets/icons/today.svg"),
  columns("assets/icons/columns.svg"),
  cross("assets/icons/cross.svg"),
  gear("assets/icons/gear.svg"),
  grid("assets/icons/grid.svg"),
  largeGrid("assets/icons/large_grid.svg"),
  list("assets/icons/list.svg"),
  moonFirstQuarter("assets/icons/moon_first_quarter.svg"),
  moonFull("assets/icons/moon_full.svg"),
  moonLastQuarter("assets/icons/moon_last_quarter.svg"),
  moonNew("assets/icons/moon_new.svg"),
  moonWaningCrescent("assets/icons/moon_waning_crescent.svg"),
  moonWaningGibbous("assets/icons/moon_waning_gibbous.svg"),
  moonWaxingCrescent("assets/icons/moon_waxing_crescent.svg"),
  moonWaxingGibbous("assets/icons/moon_waxing_gibbous.svg"),
  rows("assets/icons/rows.svg"),
  search("assets/icons/search.svg"),
  zoomIn("assets/icons/zoom_in.svg"),
  zoomOut("assets/icons/zoom_out.svg"),
  check("assets/icons/check.svg");

  const IconPath(this.path);

  final String path;
}
