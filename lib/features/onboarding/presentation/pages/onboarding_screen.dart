import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import '../../../auth/presentation/pages/login_screen.dart';
import '../widgets/onboarding_page_item.dart';
import '../widgets/onboarding_dots_indicator.dart';
import '../widgets/onboarding_navigation_button.dart';
import '../../domain/models/onboarding_model.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: const OnboardingView(),
    );
  }
}

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    final List<OnboardingModel> onboardingData = [
      OnboardingModel(
        image: "assets/images/onboarding1.png",
        title: S.of(context).onboardingTitle1,
        description: S.of(context).onboardingDesc1,
      ),
      OnboardingModel(
        image: "assets/images/onboarding2.png",
        title: S.of(context).onboardingTitle2,
        description: S.of(context).onboardingDesc2,
      ),
      OnboardingModel(
        image: "assets/images/onboarding3.png",
        title: S.of(context).onboardingTitle3,
        description: S.of(context).onboardingDesc3,
      ),
    ];

    return Scaffold(
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
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    onPageChanged: (index) {
                      context.read<OnboardingCubit>().changePage(index);
                    },
                    itemCount: onboardingData.length,
                    itemBuilder: (context, index) {
                      return OnboardingPageItem(
                        image: onboardingData[index].image,
                        title: onboardingData[index].title,
                        desc: onboardingData[index].description,
                      );
                    },
                  ),
                ),
                OnboardingDotsIndicator(
                  itemCount: onboardingData.length,
                  currentIndex: state.currentPage,
                ),
                const SizedBox(height: 32),
                OnboardingNavigationButton(
                  isLastPage: state.isLastPage,
                  onPressed: () {
                    if (state.isLastPage) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
