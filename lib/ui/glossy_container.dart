import 'dart:ui';
import 'package:flutter/material.dart';

class GlossyContainer extends StatelessWidget {
  const GlossyContainer({
    super.key,
    this.margin,
    this.padding,
    this.opacity,
    this.strengthX,
    this.strengthY,
    this.borderRadius,
    this.border,
    this.color,
    this.blendMode,
    this.gradient,
    this.child,
    this.boxShadow,
  });

  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final double? opacity;
  final Widget? child;
  final double? strengthX;
  final double? strengthY;
  final BoxBorder? border;
  final BlendMode? blendMode;
  final GlossyGradient? gradient;
  final List<BoxShadow>? boxShadow;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    late Gradient gradientToApply; // Gradient to apply based on the type

    // Check if the gradient is linear
    if (gradient is GlossyLinearGradient) {
      final GlossyLinearGradient glg = gradient as GlossyLinearGradient;
      gradientToApply = glg.getLinearGradient(); // Get the linear gradient
    }
    // Check if the gradient is radial
    if (gradient is GlossyRadialGradient) {
      final GlossyRadialGradient glg = gradient as GlossyRadialGradient;
      gradientToApply = glg.getRadialGradient(); // Get the radial gradient
    }

    return Container(
      decoration: BoxDecoration(
        boxShadow: boxShadow, // Apply box shadows
        borderRadius: borderRadius, // Apply border radius
      ),
      child: ClipRRect(
        borderRadius: borderRadius == null
            ? BorderRadius.circular(0)
            : borderRadius!,
        child: Container(
          margin: margin,
          padding: padding,
          color: Colors.transparent,
          child: Stack(
            children: [
              // Apply backdrop filter for blurring effect
              BackdropFilter(
                blendMode: blendMode != null ? blendMode! : BlendMode.srcOver,
                filter: ImageFilter.blur(
                  sigmaX: strengthX == null ? 15 : strengthX!,
                  sigmaY: strengthY == null ? 15 : strengthY!,
                ),
                child: Container(),
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: boxShadow,
                  borderRadius: borderRadius,
                  border:
                      border ?? Border.all(color: Colors.white54, width: 0.5),
                  gradient: gradient == null
                      ? LinearGradient(
                          tileMode: TileMode.mirror,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            color == null
                                ? const Color.fromARGB(
                                    255,
                                    138,
                                    137,
                                    137,
                                  ).withValues(alpha: opacity ?? 0.15)
                                : color!.withValues(alpha: opacity ?? 0.15),
                            color == null
                                ? const Color.fromARGB(
                                    255,
                                    121,
                                    120,
                                    120,
                                  ).withValues(alpha: opacity ?? 0.15)
                                : color!.withValues(alpha: opacity ?? 0.15),
                          ],
                        )
                      : gradientToApply,
                ),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Abstract class for defining glossy gradients
abstract class GlossyGradient {
  const GlossyGradient({required this.colors, required this.opacity});
  final List<Color> colors;
  final double opacity;
}

// Class for defining glossy linear gradients
class GlossyLinearGradient extends GlossyGradient {
  const GlossyLinearGradient({
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    required super.colors,
    this.tileMode = TileMode.clamp,
    required super.opacity,
  });

  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final TileMode tileMode;

  // Get linear gradient
  LinearGradient getLinearGradient() {
    return LinearGradient(
      colors: colors.map((e) => e.withValues(alpha: opacity)).toList(),
      begin: begin,
      end: end,
      tileMode: tileMode,
    );
  }
}

// Class for defining glossy radial gradients
class GlossyRadialGradient extends GlossyGradient {
  const GlossyRadialGradient({
    this.center = Alignment.center,
    this.radius = 0.5,
    required super.colors,
    required super.opacity,
    this.tileMode = TileMode.clamp,
    this.focal,
    this.focalRadius = 0.0,
  });
  final AlignmentGeometry center;
  final double radius;
  final TileMode tileMode;

  final AlignmentGeometry? focal;
  final double focalRadius;

  // Get radial gradient
  RadialGradient getRadialGradient() {
    return RadialGradient(
      colors: colors.map((e) => e.withValues(alpha: opacity)).toList(),
      center: center,
      focal: focal,
      focalRadius: focalRadius,
      radius: radius,
      tileMode: tileMode,
    );
  }
}
