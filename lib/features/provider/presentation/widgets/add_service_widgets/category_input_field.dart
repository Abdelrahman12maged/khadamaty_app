import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/generated/l10n.dart';

/// Category suggestions for autocomplete
const List<String> _categorySuggestions = [
  'Cleaning',
  'Plumbing',
  'Electrical',
  'Carpentry',
  'Painting',
  'AC Repair',
  'تنظيف',
  'سباكة',
  'كهرباء',
  'نجارة',
  'دهانات',
  'تكييف',
  'صيانة',
  'نقل أثاث',
  'حدائق',
];

/// Category input field with autocomplete suggestions
class CategoryInputField extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final bool showError;

  const CategoryInputField({
    super.key,
    required this.value,
    required this.onChanged,
    this.showError = false,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Autocomplete<String>(
      initialValue: TextEditingValue(text: value),
      optionsBuilder: (textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return _categorySuggestions.take(6);
        }
        return _categorySuggestions.where((category) => category
            .toLowerCase()
            .contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: onChanged,
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        // Sync controller with external value changes
        if (controller.text != value && !focusNode.hasFocus) {
          controller.text = value;
        }

        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: s.category,
            hintText: s.enterCategory,
            prefixIcon: Icon(
              Icons.category_outlined,
              color: AppColors.textSecondary(context),
            ),
            errorText:
                showError && value.isEmpty ? s.pleaseEnterCategory : null,
          ),
          textInputAction: TextInputAction.next,
          onChanged: onChanged,
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200, maxWidth: 300),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options.elementAt(index);
                  return ListTile(
                    dense: true,
                    title: Text(option),
                    onTap: () => onSelected(option),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
