import 'package:blog_app/shared/data/interests_data.dart';
import 'package:flutter/material.dart';

class AppInterestsSelector extends StatefulWidget {
  List<InterestItem> selectedInterests;
  final String? Function(List<InterestItem>?)? validator;
  final List<InterestItem> items;

  AppInterestsSelector({
    super.key,
    required this.selectedInterests,
    required this.items,
    this.validator,
  });

  @override
  State<AppInterestsSelector> createState() => _AppInterestsSelectorState();
}

class _AppInterestsSelectorState extends State<AppInterestsSelector> {
  void _selectItem(InterestItem item) {
    setState(() {
      if (_selected(item) != null) {
        widget.selectedInterests.removeAt(_selected(item)!);
      }
      else {
          widget.selectedInterests.add(item);
      }
    });
  }

  int? _selected(InterestItem item) {
    for (int i = 0; i < widget.selectedInterests.length; i++) {
      if (widget.selectedInterests[i].value == item.value) {
        return i;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
        widget.items.length,
            (i) {
          final isSelected = _selected(widget.items[i]) != null;
          
          return InkWell(
            onTap: (){
              _selectItem(widget.items[i]);
            },
            child: Container(
              padding:EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 8
              ),
              decoration: BoxDecoration(
                border:
                Border.all(
                  color: isSelected ? Colors.transparent :Colors.grey
                ) ,
              borderRadius: BorderRadius.circular(20),
                color: isSelected
                    ? Color(0xFF2F6F62)
                    : Color(0xFFFFFFFF)
              ),
              child: Text(widget.items[i].value,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Color(0xFF201C18)
              ),
              ),

            ),
          );
        },
      ),
    );
  }
}