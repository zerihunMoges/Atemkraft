import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/shared_widgets/custom_button.dart';
import '../../../core/shared_widgets/custom_button_two.dart';
import '../../../core/theme/colors.dart';
import '../widgets/onboarding_item.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0; // To track the current page index
  late PageController _pageController;

  List<Map<String, dynamic>> onboardingData = [
    {
      'image': 'assets/images/onboarding_image_one.png',
      'text': 'Give your Health That productive opportunity',
    },
    {
      'image': 'assets/images/onboarding_image_two.png',
      'text': 'Get to measure your BOLT value or either manually input them',
    },
    {
      'image': 'assets/images/onboarding_image_three.png',
      'text': 'While you work-out, you feel that taste of greatness',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: 0); // Initialize PageController
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose of PageController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              primaryColor,
              Color.fromRGBO(162, 178, 197, 1),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.60,
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (int page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return buildOnboardingItem(
                    onboardingData[index]['image'],
                    onboardingData[index]['text'],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingData.length,
                      (index) => buildPageIndicator(index),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  CustomButtonTwo(
                      onPressed: () {
                        // Handle Weiter (Next) button action
                        if (currentPage < onboardingData.length - 1) {
                        } else {
                          // Handle navigation to next screen or action
                        }
                        if (currentPage < onboardingData.length - 1) {
                          _pageController.animateToPage(
                            currentPage + 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          setState(() {
                            currentPage++;
                          });
                        } else {
                          // Handle navigation to next screen or action
                          context.go(AppRoutes.login);
                        }
                      },
                      buttonText: "Weiter"),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'Überspringen',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: greyTextColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPageIndicator(int index) {
    return Container(
      width: currentPage == index ? 30.0 : 10.0,
      height: 10.0,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: currentPage == index
            ? const Color(0xFFA2B2C5)
            : const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
