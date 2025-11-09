import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HorizontalImageCarousel extends StatefulWidget {
  final bool darkMode;
  const HorizontalImageCarousel({super.key,required this.darkMode});

  @override
  State<HorizontalImageCarousel> createState() => _HorizontalImageCarouselState();
}

class _HorizontalImageCarouselState extends State<HorizontalImageCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> images = [
    'assets/offer.png',
    'assets/offer_2.png',
    'assets/offer_3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(images.length, (index) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 0.8.w),
              width: _currentPage == index ? 2.5.w : 1.5.w,
              height: 1.5.w,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? (widget.darkMode ? Colors.white : Colors.black)
                    : Colors.grey[400],
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }),
        ),
      ],
    );
  }
}