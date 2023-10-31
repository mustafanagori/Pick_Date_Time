import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDate extends StatefulWidget {
  const MyDate({Key? key}) : super(key: key);

  @override
  _MyDateState createState() => _MyDateState();
}

class _MyDateState extends State<MyDate> {
  DateTime selectedDateTime = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDateTime) {
      setState(() {
        selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          selectedDateTime?.hour ?? 0,
          selectedDateTime?.minute ?? 0,
        );
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime ?? DateTime.now()),
    );
    if (picked != null) {
      setState(() {
        selectedDateTime = DateTime(
          selectedDateTime?.year ?? DateTime.now().year,
          selectedDateTime?.month ?? DateTime.now().month,
          selectedDateTime?.day ?? DateTime.now().day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        centerTitle: true,
        title: const Text(
          "Select Date & Time",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Pick Date & Time",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text("Select Date"),
                ),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: Text("Select Time"),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Date: ${DateFormat('yyyy-MM-dd').format(selectedDateTime)}",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Time: ${DateFormat('HH:mm:ss').format(selectedDateTime)}",
                style: TextStyle(fontSize: 18),
              ),
            ],
          )
        ],
      ),
    );
  }
}
