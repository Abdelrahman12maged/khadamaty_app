import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import '../cubit/mock_home_data.dart';
import 'category_card.dart';

/// Categories Grid Section Widget
class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Get categories from centralized mock data
    final categories = MockHomeData.getCategories();

    // Responsive values
    final crossAxisCount = context.responsive(mobile: 2, tablet: 4, desktop: 6);
    final spacing = AppSpacing.card(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: 1,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];

        // Map icon string to IconData
        final iconMap = {
          'cleaning_services': Icons.cleaning_services,
          'plumbing': Icons.plumbing,
          'electrical_services': Icons.electrical_services,
          'carpenter': Icons.carpenter,
          'format_paint': Icons.format_paint,
          'ac_unit': Icons.ac_unit,
        };

        return CategoryCard(
          icon: iconMap[category.icon] ?? Icons.category,
          name: category.name,
          serviceCount: category.serviceCount,
          gradientStartColor: Color(category.gradientStartColor),
          gradientEndColor: Color(category.gradientEndColor),
          onTap: () {
            // TODO: Navigate to category services (/category/${category.id})
            // Will implement when category detail page is created
          },
        );
      },
    );
  }
}
