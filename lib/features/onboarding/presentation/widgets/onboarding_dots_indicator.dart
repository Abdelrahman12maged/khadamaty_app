import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class OnboardingDotsIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const OnboardingDotsIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: currentIndex == index ? 24 : 8,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).brightness == Brightness.dark
                    ? AppColors.textSecondaryDark.withOpacity(0.3)
                    : AppColors.textSecondaryLight.withOpacity(0.5),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
