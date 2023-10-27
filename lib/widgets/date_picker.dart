import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/app_colors.dart';
import 'package:wallet_kit/styles/text/texts.dart';

class DateSelectionRow extends StatefulWidget {
  const DateSelectionRow({super.key, required this.serDateValue});
  final Function serDateValue;
  @override
  State<DateSelectionRow> createState() => _DateSelectionRowState();
}

class _DateSelectionRowState extends State<DateSelectionRow> {
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: Text(
            'When did it happen?',
            style: basic_form_title,
          ),
        ),
        TextField(
            controller: dateController,
            style: const TextStyle(color: primaryVariant),
            decoration: const InputDecoration(
                labelStyle: TextStyle(color: primaryVariant),
                hintStyle: TextStyle(color: primaryColor),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryVariant)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: errorColor)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor)),
                suffixIcon: Icon(Icons.calendar_today, color: primaryVariant),
                labelText: "Enter Date"),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101));
              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                setState(() {
                  dateController.text = formattedDate;
                });
                widget.serDateValue('date', formattedDate);
              }
            }),
      ],
    );
  }
}
