import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitas_clone/pages/welcome/widgets.dart';
import 'notifier/welcome_notifier.dart';

// final indexProvider = StateProvider<int>((ref) {
//   return 0;
// });

class Welcome extends ConsumerWidget {
  Welcome({super.key});

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexDotProvider);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            margin: EdgeInsets.only(top: 30.h),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // showing our three welcome pages
                PageView(
                  onPageChanged: (value){
                    ref.read(indexDotProvider.notifier).changeIndex(value);
                  },
                  controller: _controller,
                  children: [
                    appOnBoardingPage(
                        _controller,
                        imagePath: 'assets/images/reading.png',
                        title: 'VITAS HealthCare',
                        subTitle:
                            'When experience matters choose VITAS.',
                        index: 1,
                        context: context
                    ),
                    appOnBoardingPage(
                        _controller,
                        imagePath: 'assets/images/man.png',
                        title: 'VITAS Hospice & Palliative Care',
                        subTitle:
                            'Compassionate care when you need it most.',
                        index: 2,
                        context: context
                    ),
                    appOnBoardingPage(
                        _controller,
                        imagePath: 'assets/images/boy.png',
                        title: 'VITAS: A Legacy of Care',
                        subTitle:
                            'Bringing comfort, dignity, and support to every journey.',
                        index: 3,
                        context: context
                    ),
                  ],
                ),
                Positioned(
                  bottom: 50.h,
                  child: DotsIndicator(
                    position: index.toDouble(),
                    mainAxisAlignment: MainAxisAlignment.center,
                    dotsCount: 3,
                    decorator: DotsDecorator(
                      size: const Size.square(10.0),
                      activeSize: const Size(24, 8.0),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.w)
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
