import 'package:barbershop_app/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class HoursPanel extends StatelessWidget {
  final List<int>? enabledTimes;
  final int startTime;
  final int endTime;
  final ValueChanged<int> onPressedHour;

  const HoursPanel(
      {super.key,
      required this.startTime,
      required this.endTime,
      required this.onPressedHour,
      this.enabledTimes});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selecione os dias da semana',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 16,
          children: [
            for (int i = startTime; i <= endTime; i++)
              TimeButton(
                enabledTimes: enabledTimes,
                label: '${i.toString().padLeft(2, '0')}:00',
                value: i,
                onPressed: onPressedHour,
              )
          ],
        )
      ],
    );
  }
}

class TimeButton extends StatefulWidget {
  final List<int>? enabledTimes;
  final String label;
  final int value;
  final ValueChanged<int> onPressed;

  const TimeButton(
      {super.key,
      required this.label,
      required this.value,
      required this.onPressed,
      this.enabledTimes});

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  var selected = false;

  @override
  Widget build(BuildContext context) {
    final textColor = selected ? Colors.white : ColorsConstants.grey;
    var buttonColor = selected ? ColorsConstants.brown : Colors.white;
    final buttonBorderColor =
        selected ? ColorsConstants.brown : ColorsConstants.grey;
    final TimeButton(:value, :label, :enabledTimes, :onPressed) = widget;

    final disabledTime = enabledTimes != null && !enabledTimes.contains(value);
    if(disabledTime){
      buttonColor = Colors.grey[400]!;
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: disabledTime ? null : () {
          setState(() {
            selected = !selected;
            onPressed(value);
          });
        },
        child: Container(
          width: 64,
          height: 36,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: buttonColor,
              border: Border.all(color: buttonBorderColor)),
          child: Center(
              child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          )),
        ),
      ),
    );
  }
}
