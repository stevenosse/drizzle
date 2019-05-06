import 'package:flutter/material.dart';
import '../widgets/spinner_text.dart';
import '../widgets/spinner_city.dart';
import '../widgets/modal.dart';

class ForcastAppBar extends StatefulWidget {
  final Function onDrawerArrowTap;
  final String selectedDay;
  final String selectedCity;
  final Modal modal;
  final SpinnerCity spinnerCity;

  ForcastAppBar({
    this.onDrawerArrowTap,
    this.selectedDay,
    this.selectedCity,
    this.modal,
    this.spinnerCity
  });

  @override
  _ForcastAppBarState createState() => new _ForcastAppBarState();
}

class _ForcastAppBarState extends State<ForcastAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(ForcastAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SpinnerText(
            text: widget.selectedDay,
          ),
          widget.spinnerCity
        ],
      ),
      actions: <Widget>[
        new IconButton(
          icon: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 35.0),
          onPressed: () {
            widget.onDrawerArrowTap();
          },
        )
      ],
    );
  }
}
