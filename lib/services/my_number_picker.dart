import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class MyNumberPicker extends StatefulWidget {

  final Function(int) onChanged;
   int initialValue;
   MyNumberPicker({super.key,required this.onChanged, required this.initialValue});

  @override
  State<MyNumberPicker> createState() => _MyNumberPickerState();
}


class _MyNumberPickerState extends State<MyNumberPicker> {
 late int currentValue;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentValue = widget.initialValue;
  }
  @override
  Widget build(BuildContext context) {
    return NumberPicker(
      infiniteLoop: true,
      minValue: 0,
      maxValue: 59,
      value:currentValue,
      //haptics: true,
      //axis: Axis.horizontal,
      step: 1,
      onChanged: (value) {
        setState(() {
          currentValue = value;
        });
        widget.onChanged(value);
      },
      decoration: const BoxDecoration(
          border:Border(
            top: BorderSide(
                width: 3,
                color: Colors.black
            ),
            bottom: BorderSide(
                width: 3,
                color: Colors.black
            ),
          )
      ),
      textStyle: const TextStyle(fontSize: 20),
      selectedTextStyle: const TextStyle(fontSize: 35, color: Colors.white),
    );

  }

}
