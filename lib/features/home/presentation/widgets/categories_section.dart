import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import '../widgets/category_card.dart';

/// Categories Grid Section Widget
class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock categories data
    final categories = [
      {
        'name': 'Cleaning',
        'icon': Icons.cleaning_services,
        'color1': const Color(0xFF2196F3),
        'color2': const Color(0xFF1976D2),
        'count': 15,
      },
      {
        'name': 'Plumbing',
        'icon': Icons.plumbing,
        'color1': const Color(0xFFFF9800),
        'color2': const Color(0xFFF57C00),
        'count': 12,
      },
      {
        'name': 'Electrical',
        'icon': Icons.electrical_services,
        'color1': const Color(0xFFFFC107),
        'color2': const Color(0xFFFFA000),
        'count': 18,
      },
      {
        'name': 'Carpentry',
        'icon': Icons.carpenter,
        'color1': const Color(0xFF795548),
        'color2': const Color(0xFF5D4037),
        'count': 10,
      },
      {
        'name': 'Painting',
        'icon': Icons.format_paint,
        'color1': const Color(0xFF9C27B0),
        'color2': const Color(0xFF7B1FA2),
        'count': 14,
      },
      {
        'name': 'AC Repair',
        'icon': Icons.ac_unit,
        'color1': const Color(0xFF00BCD4),
        'color2': const Color(0xFF0097A7),
        'count': 8,
      },
    ];

    // Adaptive column count using ResponsiveValue
    final crossAxisCount = context.responsive(mobile: 2, tablet: 4, desktop: 6);
    final spacing =
        context.responsive(mobile: 12.0, tablet: 14.0, desktop: 16.0);

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
        return CategoryCard(
          icon: category['icon'] as IconData,
          name: category['name'] as String,
          serviceCount: category['count'] as int,
          gradientStartColor: category['color1'] as Color,
          gradientEndColor: category['color2'] as Color,
          onTap: () {
            // TODO: Navigate to category services
          },
        );
      },
    );
  }
}
