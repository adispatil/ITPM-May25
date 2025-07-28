import 'package:flutter/material.dart';

class TodayHourlyWidget extends StatelessWidget {
  const TodayHourlyWidget({
    super.key,
    required this.isSelected,
    required this.currentHour,
    required this.temp,
  });

  final bool isSelected;
  final String currentHour;
  final String temp;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5.0),
      decoration: BoxDecoration(
        color: isSelected ? Color(0x332566A3) : Colors.transparent,
        border: Border.all(
          width: isSelected ? 1 : 0.0,
          color: isSelected ? Color(0xFF5096FF) : Colors.transparent,
          strokeAlign: BorderSide.strokeAlignCenter,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text("$tempºC", style: TextStyle(fontSize: 18, color: Colors.white)),
          SizedBox(height: 5.0),
          Image.asset(
            "assets/images/daily_day.png",
            height: 50,
            width: 60,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 5.0),
          Text(
            currentHour,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
