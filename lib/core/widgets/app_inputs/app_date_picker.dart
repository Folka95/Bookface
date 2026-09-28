import 'package:flutter/material.dart';

String _dateFormater(DateTime? date) {
  if(date == null) {
    return "";
  }
  final Map<int, String> months = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December',
  };
  return date.day.toString() + ' ' + months[date.month]! + ' ' + date.year.toString();
}

class AppDatePicker extends StatefulWidget {
  final void Function(DateTime?) onBirthdateChanged;
  final String? Function(String?)? validator;

  DateTime? selectedDate;

  TextEditingController textController = TextEditingController();

  AppDatePicker({
    required this.onBirthdateChanged,
    required this.selectedDate,
    this.validator,
  }) {
    onBirthdateChanged(selectedDate);
    textController = TextEditingController(text: _dateFormater(selectedDate));
  }

  @override
  _AppDatePickerState createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  Future<void> _selectDate(BuildContext context) async {
    DateTime today = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
      widget.selectedDate,
      firstDate: DateTime(today.year - 100, today.month, today.day),
      lastDate: DateTime(today.year - 18, today.month, today.day),
    );
    if (picked != null) {
      widget.textController.text = _dateFormater(picked);
      widget.onBirthdateChanged(picked);
      setState(() {
        widget.selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
      validator: widget.validator,
      readOnly: true,
      maxLines: 1,
      onTap: () {
        _selectDate(context);
      },
      style: TextStyle(color: Color(0xFF201C18)),

      decoration: InputDecoration(
        hint: Text("pick your birthdate"),
        filled: true,
        fillColor: Color(0xFFFFFFFF),
        border: const OutlineInputBorder(),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),

        suffixIcon: Icon(Icons.calendar_today_outlined),
      ),
    );
  }
}