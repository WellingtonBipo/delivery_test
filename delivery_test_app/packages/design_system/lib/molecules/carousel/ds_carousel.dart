import 'package:design_system/ds_theme.dart';
import 'package:flutter/material.dart';

class DSCarousel extends StatefulWidget {
  const DSCarousel({
    required this.children,
    this.shrinkExtentRatio = 1,
    this.height,
    this.width,
    this.padding,
    this.onTap,
    super.key,
  });

  final List<Widget> children;
  final double shrinkExtentRatio;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final void Function(int)? onTap;

  @override
  State<DSCarousel> createState() => _DSCarouselState();
}

class _DSCarouselState extends State<DSCarousel> {
  static const controllerSize = (space: 10.0, height: 6.0);
  final _controller = CarouselController();
  late var _height = widget.height;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DSCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.height != oldWidget.height) {
      _height = widget.height;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildCarousel(double width) {
      final carousel = _height == null
          ? Builder(
              builder: (context) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    final height = context.size?.height;
                    if (height == null) return;
                    _height =
                        height + controllerSize.space + controllerSize.height;
                  });
                });
                return Padding(
                  padding: widget.padding ?? EdgeInsets.zero,
                  child: widget.children.first,
                );
              },
            )
          : SizedBox(
              height: _height! - controllerSize.space - controllerSize.height,
              child: CarouselView(
                itemSnapping: true,
                backgroundColor: Colors.transparent,
                shape: const Border(),
                padding: widget.padding,
                controller: _controller,
                itemExtent: width,
                shrinkExtent: width * widget.shrinkExtentRatio,
                onTap: widget.onTap,
                children: widget.children,
              ),
            );
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          carousel,
          SizedBox(height: controllerSize.height),
          ListenableBuilder(
            listenable: _controller,
            builder: (context, _) {
              final position =
                  _controller.hasClients ? _controller.offset / width : 0.0;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.children.length,
                  (index) {
                    final relativePosition =
                        _positionRelativeToIndex(position, index);
                    return Container(
                      width: controllerSize.height + (relativePosition * 20),
                      height: controllerSize.height,
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
    }

    if (widget.width != null) return _buildCarousel(widget.width!);

    return LayoutBuilder(
      builder: (context, constraints) => _buildCarousel(constraints.maxWidth),
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
