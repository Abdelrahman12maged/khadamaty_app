import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/localization/app_localizations.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          OnboardingPage(
            image: 'assets/images/onboarding1.png',
            title:"",
          ),
          OnboardingPage(
            image: 'assets/images/onboarding2.png',
            title: 'Quick Services',
          ),
          OnboardingPage(
            image: 'assets/images/onboarding3.png',
            title: 'Easy Booking',
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;

  const OnboardingPage({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(image),
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}