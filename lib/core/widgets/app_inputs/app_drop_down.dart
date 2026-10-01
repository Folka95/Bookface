import 'package:flutter/material.dart';

class DropDownItem<T> {
  final Widget? prefixImg;
  final String name;
  final T value;

  const DropDownItem({
    this.prefixImg,
    required this.name,
    required this.value,
  });
}

class AppDropDown<T> extends StatefulWidget {
  final void Function(T) onSelectionChanged;
  final List<DropDownItem<T>> items;
  final String error;

  int? selectedIndex;

  AppDropDown({
    super.key,
    required this.onSelectionChanged,
    required this.items,
    required T? selectedItem,
    required this.error,
  }) {
    for (int i = 0; i < items.length; i++) {
      if (selectedItem == items[i].value) {
        selectedIndex = i;
        break;
      }
    }
  }

  @override
  State<AppDropDown<T>> createState() => _AppDropDownState<T>();
}

class _AppDropDownState<T> extends State<AppDropDown<T>> {
  void _selectItem(int idx) {
    if (widget.items.isEmpty) {
      return;
    }

    final T value = widget.items[idx].value;

    setState(() {
      widget.selectedIndex = idx;
    });

    widget.onSelectionChanged(value);
  }

  String _limitString(String text) {
    const int limit = 34;

    return text.length > limit
        ? '${text.substring(0, limit)}...'
        : text;
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.error.isNotEmpty;

    return DropdownButtonFormField<int>(
      value: widget.selectedIndex,

      dropdownColor: const Color(0xFFFFFFFF),

      style: const TextStyle(
        color: Color(0xFF201C18),
      ),

      decoration: InputDecoration(
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

        errorText: hasError ? widget.error : null,

        suffixIcon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
        ),
      ),

      items: List.generate(
        widget.items.length,
            (index) {
          final item = widget.items[index];

          return DropdownMenuItem<int>(
            value: index,
            child: Row(
              children: [
                if (item.prefixImg != null) ...[
                  item.prefixImg!,
                  const SizedBox(width: 10),
                ],
                Text(
                  _limitString(item.name),
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          );
        },
      ),

      onChanged: (value) {
        if (value == null) {
          return;
        }

        _selectItem(value);
      },
    );
  }
}