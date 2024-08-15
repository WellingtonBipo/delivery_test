import 'package:design_system/ds_theme.dart';
import 'package:flutter/material.dart';

class DSCarousel extends StatefulWidget {
  const DSCarousel({
    required this.children,
    this.shrinkExtentRatio = 1,
    this.height,
    this.padding,
    this.onTap,
    super.key,
  });

  final List<Widget> children;
  final double shrinkExtentRatio;
  final double? height;
  final EdgeInsets? padding;
  final void Function(int)? onTap;

  @override
  State<DSCarousel> createState() => _DSCarouselState();
}

class _DSCarouselState extends State<DSCarousel> {
  final controller = CarouselController();
  late var height = widget.height;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final carousel = height == null
            ? Builder(
                builder: (context) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() => height = context.size?.height);
                  });
                  return Padding(
                    padding: widget.padding ?? EdgeInsets.zero,
                    child: widget.children.first,
                  );
                },
              )
            : SizedBox(
                height: height,
                child: CarouselView(
                  itemSnapping: true,
                  shape: const Border(),
                  padding: widget.padding,
                  controller: controller,
                  itemExtent: constraints.maxWidth,
                  shrinkExtent: constraints.maxWidth * widget.shrinkExtentRatio,
                  onTap: widget.onTap,
                  children: widget.children,
                ),
              );
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            carousel,
            const SizedBox(height: 10),
            ListenableBuilder(
              listenable: controller,
              builder: (context, _) {
                final position = controller.hasClients
                    ? controller.offset / constraints.maxWidth
                    : 0.0;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.children.length,
                    (index) {
                      final relativePosition =
                          _positionRelativeToIndex(position, index);
                      return Container(
                        width: 6 + (relativePosition * 20),
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Color.lerp(
                            DSTheme.of(context).colors.contentSecondary,
                            DSTheme.of(context).colors.brandPrimary,
                            relativePosition,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

double _positionRelativeToIndex(double position, int index) {
  final lowerLimite = index - 1;
  final upperLimite = index + 1;
  if (position < lowerLimite || position > upperLimite) {
    return 0;
  } else if (position > index) {
    return 1 - (position - index);
  } else {
    return 1 - (index - position);
  }
}
