import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'weekly_forecast_item_widget.dart';

class WeeklyForecastWidget extends StatefulWidget {
  const WeeklyForecastWidget({super.key});

  @override
  State<WeeklyForecastWidget> createState() => _WeeklyForecastWidgetState();
}

class _WeeklyForecastWidgetState extends State<WeeklyForecastWidget> {
  String _getDay(int additionDay) {
    DateTime date = DateTime.now();
    DateTime newDate = date.add(Duration(days: additionDay));
    String day = DateFormat('EEEE').format(newDate);

    return day;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      margin: EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Color(0xFF001026).withValues(alpha: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FIRST ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Next Forecast",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Icon(Icons.calendar_view_week, color: Colors.white, size: 24),
            ],
          ),
          SizedBox(height: 5),
          WeeklyForecastItemWidget(weekDay: _getDay(0)),
          WeeklyForecastItemWidget(weekDay: _getDay(1)),
          WeeklyForecastItemWidget(weekDay: _getDay(2)),
          WeeklyForecastItemWidget(weekDay: _getDay(3)),
          WeeklyForecastItemWidget(weekDay: _getDay(4)),
          WeeklyForecastItemWidget(weekDay: _getDay(5)),
          WeeklyForecastItemWidget(weekDay: _getDay(6)),
        ],
      ),
    );
  }
}
