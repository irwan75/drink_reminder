import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar(
      {Key? key, this.onTap, required this.currentIndex})
      : super(key: key);

  final Function(int)? onTap;
  final int currentIndex;

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double indicatorPosition = 38.2;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void moveBottomNavigationIndicator(int index) {
    final double screenWidth = MediaQuery.of(context).size.width;
    const double buttonSize = 80;

    switch (index) {
      case 0:
        indicatorPosition = ((screenWidth / (3 - index)) * (index)) +
            (screenWidth - buttonSize * 3) / 4;
        break;
      case 1:
        indicatorPosition = (screenWidth / (3 - index)) - buttonSize / 2;
        break;
      default:
        indicatorPosition = (screenWidth / (3 - index) - buttonSize) -
            (screenWidth - buttonSize * 3) / 4;
    }
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    moveBottomNavigationIndicator(widget.currentIndex);
    return Container(
      padding: const EdgeInsets.only(bottom: 24),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
            left: indicatorPosition,
            child: Container(
              height: 60,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  widget.onTap?.call(0);
                  moveBottomNavigationIndicator(0);
                },
                child: Container(
                  height: 60,
                  width: 80,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: AnimatedBuilder(
                    animation: ColorTween(
                            begin: Theme.of(context).colorScheme.secondary,
                            end: Theme.of(context).scaffoldBackgroundColor)
                        .animate(_animationController),
                    builder: (context, child) {
                      return Container(
                        height: 24,
                        width: 24,
                        padding: const EdgeInsets.all(6),
                        child: SvgPicture.asset(
                          'assets/icons/humidity.svg',
                          color: widget.currentIndex == 0
                              ? ColorTween(
                                      begin: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      end: Theme.of(context)
                                          .scaffoldBackgroundColor)
                                  .evaluate(_animationController)
                              : Theme.of(context).colorScheme.secondary,
                        ),
                      );
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  widget.onTap?.call(1);
                  moveBottomNavigationIndicator(1);
                },
                child: Container(
                  height: 60,
                  width: 80,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: AnimatedBuilder(
                      animation: ColorTween(
                              begin: Theme.of(context).colorScheme.secondary,
                              end: Theme.of(context).scaffoldBackgroundColor)
                          .animate(_animationController),
                      builder: (context, child) {
                        return Container(
                          height: 24,
                          width: 24,
                          padding: const EdgeInsets.all(6),
                          child: SvgPicture.asset(
                            'assets/icons/progress.svg',
                            color: widget.currentIndex == 1
                                ? ColorTween(
                                        begin: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        end: Theme.of(context)
                                            .scaffoldBackgroundColor)
                                    .evaluate(_animationController)
                                : Theme.of(context).colorScheme.secondary,
                          ),
                        );
                      }),
                ),
              ),
              InkWell(
                onTap: () {
                  widget.onTap?.call(2);
                  moveBottomNavigationIndicator(2);
                },
                child: Container(
                  height: 60,
                  width: 80,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: AnimatedBuilder(
                      animation: ColorTween(
                              begin: Theme.of(context).colorScheme.secondary,
                              end: Theme.of(context).scaffoldBackgroundColor)
                          .animate(_animationController),
                      builder: (context, child) {
                        return Container(
                          height: 24,
                          width: 24,
                          padding: const EdgeInsets.all(8),
                          child: SvgPicture.asset(
                            'assets/icons/menu.svg',
                            color: widget.currentIndex == 2
                                ? ColorTween(
                                        begin: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        end: Theme.of(context)
                                            .scaffoldBackgroundColor)
                                    .evaluate(_animationController)
                                : Theme.of(context).colorScheme.secondary,
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
