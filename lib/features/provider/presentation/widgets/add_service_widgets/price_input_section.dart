import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/generated/l10n.dart';

/// Price input section with price field and unit dropdown
class PriceInputSection extends StatelessWidget {
  final double? price;
  final String priceUnit;
  final ValueChanged<double?> onPriceChanged;
  final ValueChanged<String> onUnitChanged;
  final bool showError;

  const PriceInputSection({
    super.key,
    required this.price,
    required this.priceUnit,
    required this.onPriceChanged,
    required this.onUnitChanged,
    this.showError = false,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isMobile = context.isMobile;

    // On mobile, stack vertically; on tablet/desktop use row
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPriceField(context, s),
          SizedBox(height: AppSpacing.md(context)),
          _buildUnitDropdown(context, s),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildPriceField(context, s),
        ),
        SizedBox(width: AppSpacing.md(context)),
        Expanded(
          flex: 1,
          child: _buildUnitDropdown(context, s),
        ),
      ],
    );
  }

  Widget _buildPriceField(BuildContext context, S s) {
    return TextFormField(
      initialValue: price?.toString() ?? '',
      decoration: InputDecoration(
        labelText: s.price,
        hintText: s.enterPrice,
        prefixIcon: Icon(
          Icons.attach_money,
          color: AppColors.textSecondary(context),
        ),
        suffixText: s.currency,
        errorText: showError && (price == null || price! <= 0)
            ? s.pleaseEnterPrice
            : null,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      onChanged: (value) {
        final parsed = double.tryParse(value);
        onPriceChanged(parsed);
      },
    );
  }

  Widget _buildUnitDropdown(BuildContext context, S s) {
    return DropdownButtonFormField<String>(
      value: priceUnit,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: s.priceUnit,
      ),
      items: [
        DropdownMenuItem(
          value: 'per visit',
          child: Text(s.perVisit),
        ),
        DropdownMenuItem(
          value: 'per hour',
          child: Text(s.perHour),
        ),
      ],
      onChanged: (value) {
        if (value != null) {
          onUnitChanged(value);
        }
      },
    );
  }
}
