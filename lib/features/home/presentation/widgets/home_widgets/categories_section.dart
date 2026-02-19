import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import '../../cubits/home_cubit/home_state.dart';
import 'category_card.dart';

/// Resolves category nameKey to localized string
String _resolveCategoryName(BuildContext context, String nameKey) {
  final s = S.of(context);
  final map = {
    'categoryCleaning': s.categoryCleaning,
    'categoryPlumbing': s.categoryPlumbing,
    'categoryElectrical': s.categoryElectrical,
    'categoryCarpentry': s.categoryCarpentry,
    'categoryPainting': s.categoryPainting,
    'categoryAcRepair': s.categoryAcRepair,
  };
  return map[nameKey] ?? nameKey;
}

/// Categories Grid Section Widget
class CategoriesSection extends StatelessWidget {
  final List<CategoryData> categories;

  const CategoriesSection({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
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
          name: _resolveCategoryName(context, category.nameKey),
          serviceCount: category.serviceCount,
          gradientStartColor: Color(category.gradientStartColor),
          gradientEndColor: Color(category.gradientEndColor),
          onTap: () {
            // TODO: Navigate to category services (/category/${category.id})
          },
        );
      },
    );
  }
}
