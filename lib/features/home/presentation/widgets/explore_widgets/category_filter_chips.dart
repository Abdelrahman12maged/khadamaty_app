import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/features/home/presentation/cubits/home_cubit/home_state.dart';
import 'package:khadamaty_app/generated/l10n.dart';

/// Category filter chips for explore page
class CategoryFilterChips extends StatelessWidget {
  final List<CategoryData> categories;
  final String? selectedCategoryId;
  final ValueChanged<String?> onCategorySelected;

  const CategoryFilterChips({
    super.key,
    required this.categories,
    this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final chipHeight =
        context.responsive(mobile: 36.0, tablet: 40.0, desktop: 44.0);
    final chipPadding =
        context.responsive(mobile: 12.0, tablet: 14.0, desktop: 16.0);

    return SizedBox(
      height: chipHeight + 8,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // "All" chip
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(S.of(context).all),
              selected: selectedCategoryId == null,
              onSelected: (_) => onCategorySelected(null),
              padding: EdgeInsets.symmetric(horizontal: chipPadding),
            ),
          ),

          // Category chips
          ...categories.map((category) {
            final isSelected = selectedCategoryId == category.id;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(category.name),
                selected: isSelected,
                onSelected: (_) => onCategorySelected(
                  isSelected ? null : category.id,
                ),
                padding: EdgeInsets.symmetric(horizontal: chipPadding),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
