import 'package:blog_app/core/helpers/safe_print.dart';
import 'package:blog_app/shared/data/gender_data.dart';
import 'package:flutter/material.dart';


class AppGenderSelector extends StatefulWidget {
  final void Function(GenderItem?) onGenderChanged;
  GenderItem? selectedGender;
  bool showError;


  AppGenderSelector({
    required this.onGenderChanged,
    required this.selectedGender,
    this.showError = false,
  });

  @override
  _AppGenderSelectorState createState() => _AppGenderSelectorState();
}

class _AppGenderSelectorState extends State<AppGenderSelector> {
  Future<void> _selectItem(BuildContext context, GenderItem? selected) async {
    if(widget.selectedGender == selected) {
      selected = null;
    }
    widget.onGenderChanged(selected);
    setState(() {
      widget.selectedGender = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
      decoration: BoxDecoration(
        border: widget.showError ?  Border.all(
          color: Colors.red
        ) : null,
        color: Color(0xFFEFEAE3),
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      child: _buildChoices(context),
    );
  }

  Widget _buildChoices(BuildContext context) {
    List<Widget> row = [];
    final values = Genders.getAllItems();
    for(int i = 0; i < values.length; i++) {
      row.add(
          ElevatedButton(
            onPressed: () {
              _selectItem(context, values[i]);
            },
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              backgroundColor: widget.selectedGender != null && widget.selectedGender!.value == values[i].value
                  ? Color(0xFFFFFFFF)
                  : Colors.transparent,
              foregroundColor: widget.selectedGender != null && widget.selectedGender!.value == values[i].value
                  ? Color(0xFF2F6F62)
                  : Color(0xFF6B6560),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(values[i].value),
          )
      );
    }
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: row,
    );
  }

}