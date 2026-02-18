import 'package:flutter/material.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import '../../cubits/explore_cubit/explore_state.dart';

/// Sort dropdown widget for explore page
class SortDropdown extends StatelessWidget {
  final SortOption selectedOption;
  final ValueChanged<SortOption> onChanged;

  const SortDropdown({
    super.key,
    required this.selectedOption,
    required this.onChanged,
  });

  String _getSortLabel(BuildContext context, SortOption option) {
    switch (option) {
      case SortOption.mostPopular:
        return S.of(context).mostPopular;
      case SortOption.topRated:
        return S.of(context).topRated;
      case SortOption.priceLowToHigh:
        return S.of(context).priceLowToHigh;
      case SortOption.priceHighToLow:
        return S.of(context).priceHighToLow;
    }
  }

  IconData _getSortIcon(SortOption option) {
    switch (option) {
      case SortOption.mostPopular:
        return Icons.trending_up;
      case SortOption.topRated:
        return Icons.star;
      case SortOption.priceLowToHigh:
        return Icons.arrow_upward;
      case SortOption.priceHighToLow:
        return Icons.arrow_downward;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${S.of(context).sortBy}:',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DropdownButton<SortOption>(
            value: selectedOption,
            isExpanded: true,
            onChanged: (value) {
              if (value != null) onChanged(value);
            },
            items: SortOption.values.map((option) {
              return DropdownMenuItem(
                value: option,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_getSortIcon(option), size: 18),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        _getSortLabel(context, option),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
