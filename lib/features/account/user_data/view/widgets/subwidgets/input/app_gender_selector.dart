import 'package:blog_app/shared/data/gender_data.dart';
import 'package:flutter/material.dart';

class AppGenderSelector extends StatefulWidget {
  final void Function(GenderItem?) onGenderChanged;
  GenderItem? selectedGender;
  String error;

  AppGenderSelector({
    super.key,
    required this.onGenderChanged,
    required this.selectedGender,
    this.error = "",
  });

  @override
  State<AppGenderSelector> createState() => _AppGenderSelectorState();
}

class _AppGenderSelectorState extends State<AppGenderSelector> {
  void _selectItem(GenderItem? selected) {
    if (widget.selectedGender == selected) {
      selected = null;
    }

    widget.onGenderChanged(selected);

    setState(() {
      widget.selectedGender = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.error.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
          decoration: BoxDecoration(
            border: Border.all(
              color: hasError ? Colors.red : Colors.transparent,
            ),
            color: const Color(0xFFEFEAE3),
            borderRadius: BorderRadius.circular(20),
          ),
          width: double.infinity,
          child: _buildChoices(context),
        ),

        if (hasError)
          Padding(
            padding: const EdgeInsets.only(
              left: 12,
              top: 6,
            ),
            child: Text(
              widget.error,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildChoices(BuildContext context) {
    final List<Widget> row = [];
    final values = Genders.getAllItems();

    for (int i = 0; i < values.length; i++) {
      final isSelected =
          widget.selectedGender != null &&
              widget.selectedGender!.value == values[i].value;

      row.add(
        ElevatedButton(
          onPressed: () {
            _selectItem(values[i]);
          },
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            backgroundColor:
            isSelected
                ? const Color(0xFFFFFFFF)
                : Colors.transparent,
            foregroundColor:
            isSelected
                ? const Color(0xFF2F6F62)
                : const Color(0xFF6B6560),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(values[i].value),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: row,
    );
  }
}