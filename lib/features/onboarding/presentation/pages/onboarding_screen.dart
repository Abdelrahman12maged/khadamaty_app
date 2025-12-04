import 'package:flutter/material.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import '../../../auth/presentation/pages/login_screen.dart';
import '../widgets/onboarding_page_item.dart';
import '../widgets/onboarding_dots_indicator.dart';
import '../widgets/onboarding_navigation_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> onboardingData = [
      {
        "image": "assets/images/onboarding1.png",
        "title": S.of(context).onboardingTitle1,
        "desc": S.of(context).onboardingDesc1,
      },
      {
        "image": "assets/images/onboarding2.png",
        "title": S.of(context).onboardingTitle2,
        "desc": S.of(context).onboardingDesc2,
      },
      {
        "image": "assets/images/onboarding3.png",
        "title": S.of(context).onboardingTitle3,
        "desc": S.of(context).onboardingDesc3,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: Text(
              S.of(context).skip,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return OnboardingPageItem(
                    image: onboardingData[index]["image"]!,
                    title: onboardingData[index]["title"]!,
                    desc: onboardingData[index]["desc"]!,
                  );
                },
              ),
            ),
            OnboardingDotsIndicator(
              itemCount: onboardingData.length,
              currentIndex: _currentPage,
            ),
            const SizedBox(height: 32),
            OnboardingNavigationButton(
              isLastPage: _currentPage == onboardingData.length - 1,
              onPressed: () {
                if (_currentPage == onboardingData.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
