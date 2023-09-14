import 'dart:ui';

import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final double height;
  final double width;
  final Color indicatorBackgroundColor;
  final Color indicatorDotColor;
  final Color indicatorDotBackgroundColor;
  final double indicatorSize;
  final List<Widget> items;

  const ImageSlider({
    super.key,
    this.width = double.infinity,
    this.height = 300,
    this.indicatorBackgroundColor = Colors.white,
    this.indicatorDotBackgroundColor = Colors.grey,
    this.indicatorDotColor = Colors.black,
    this.indicatorSize = 7,
    required this.items,
  });

  @override
  State<StatefulWidget> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  late final ValueNotifier<int> _currentPageNotifier;
  late final PageController _pageController;
  late final ScrollBehavior _scrollBehavior;

  void _onPageChanged(int index) {
    _currentPageNotifier.value = index;
  }

  @override
  void initState() {
    _scrollBehavior = const ScrollBehavior().copyWith(
      scrollbars: false,
      dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      },
    );
    _pageController = PageController(initialPage: 0);
    _currentPageNotifier = ValueNotifier(0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: PageView.builder(
              scrollBehavior: _scrollBehavior,
              onPageChanged: _onPageChanged,
              controller: _pageController,
              itemCount: widget.items.length,
              itemBuilder: (context, index) => widget.items.elementAt(index),
            ),
          ),
          Positioned.fill(
            child: ValueListenableBuilder<int>(
              valueListenable: _currentPageNotifier,
              builder: (context, value, child) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: widget.indicatorBackgroundColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: SizedBox(
                        height: 17,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.items.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                child: Container(
                                  width: widget.indicatorSize,
                                  height: widget.indicatorSize,
                                  decoration: BoxDecoration(
                                    color: _currentPageNotifier.value == index
                                        ? widget.indicatorDotColor
                                        : widget.indicatorDotBackgroundColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
