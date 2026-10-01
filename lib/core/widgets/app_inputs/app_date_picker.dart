import 'package:flutter/material.dart';

String _dateFormater(DateTime? date) {
  if (date == null) {
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

  return '${date.day} ${months[date.month]!} ${date.year}';
}

class AppDatePicker extends StatefulWidget {
  final void Function(DateTime?) onBirthdateChanged;

  final String error;

  DateTime? selectedDate;

  TextEditingController textController = TextEditingController();

  AppDatePicker({
    super.key,
    required this.onBirthdateChanged,
    required this.error,
    required this.selectedDate,
  }) {
    onBirthdateChanged(selectedDate);
    textController = TextEditingController(
      text: _dateFormater(selectedDate),
    );
  }

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  Future<void> _selectDate(BuildContext context) async {
    final today = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate ??
          DateTime(
            today.year - 18,
            today.month,
            today.day,
          ),
      firstDate: DateTime(
        today.year - 100,
        today.month,
        today.day,
      ),
      lastDate: DateTime(
        today.year - 18,
        today.month,
        today.day,
      ),
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
    final hasError = widget.error.isNotEmpty;

    return TextFormField(
      controller: widget.textController,
      readOnly: true,
      maxLines: 1,
      onTap: () {
        _selectDate(context);
      },
      style: const TextStyle(
        color: Color(0xFF201C18),
      ),
      decoration: InputDecoration(
        hintText: "pick your birthdate",

        filled: true,
        fillColor: const Color(0xFFFFFFFF),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: hasError ? Colors.red : Colors.grey,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: hasError ? Colors.red : Colors.black,
            width: 2,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),

        // Flutter displays this below the field.
        errorText: hasError ? widget.error : null,

        suffixIcon: const Icon(
          Icons.calendar_today_outlined,
        ),
      ),
    );
  }
}