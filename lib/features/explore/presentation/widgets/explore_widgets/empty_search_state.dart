import 'package:flutter/material.dart';
import 'package:khadamaty_app/generated/l10n.dart';

/// Empty state widget when no search results found
class EmptySearchState extends StatelessWidget {
  final String query;
  final VoidCallback? onClearFilters;

  const EmptySearchState({
    super.key,
    required this.query,
    this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24),
            Text(
              '${S.of(context).noResultsFor} "$query"',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              S.of(context).tryDifferentKeywords,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (onClearFilters != null) ...[
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: onClearFilters,
                icon: const Icon(Icons.clear_all),
                label: Text(S.of(context).clearFilters),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
