import 'package:flutter/material.dart';

class WeekDrawer extends StatelessWidget {
  final week = [];
  final List days = new List();

  final Function(String title) onDaySelected;

  WeekDrawer({
    this.onDaySelected,
  });

  _initWeek(){
    days.add("Lundi");
    days.add("Mardi");
    days.add("Mercredi");
    days.add("Jeudi");
    days.add("Vendredi");
    days.add("Samedi");
    days.add("Dimanche");
    for (var i = 0; i < 7; i++) {
      week.add(DateTime.now().add(new Duration(days: i)));
    }
  }

  List<Widget> _buildDayButtons() {  
    return week.map((date) {
      String title = days[date.weekday-1]+"\n"+date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
      return Expanded(
        child: GestureDetector(
          onTap: () {
            onDaySelected(title);
          },
          child: Text(
              title,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              )),
        ),
      );
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    this._initWeek();
    return  Container(
        width: 125.0,
        height: double.infinity,
        color: const Color(0xAA234860),
        child: Column(
          children: <Widget>[
            Expanded(
              child: new Icon(Icons.refresh, color: Colors.white, size: 40.0),
            ),
          ]
          ..addAll(_buildDayButtons())
        ),
      );
  }
}