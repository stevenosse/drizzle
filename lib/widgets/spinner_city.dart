import 'package:flutter/material.dart';
import './modal.dart';

class SpinnerCity extends StatefulWidget {
  final String text;
  final Modal modal;
  final Function(String city) onCitySelected;

  SpinnerCity({this.text = '', @required this.modal, this.onCitySelected});

  @override
  _SpinnerCityState createState() => new _SpinnerCityState();
}

class _SpinnerCityState extends State<SpinnerCity>
    with SingleTickerProviderStateMixin {
  String topText = "";
  var bottomText;
  AnimationController _spinTextAnimationController;
  Animation<double> _spinAnimation;

  @override
  void initState() {
    super.initState();

    bottomText = widget.modal.seletedItem.toString();

    _spinTextAnimationController = new AnimationController(
        duration: Duration(milliseconds: 750), vsync: this)
      ..addListener(() => setState(() {}))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            bottomText = topText;
            topText = "";
            _spinTextAnimationController.value = 0.0;
          });
        }
      });

    _spinAnimation = new CurvedAnimation(
        parent: _spinTextAnimationController, curve: Curves.elasticInOut);
  }

  @override
  void dispose() {
    _spinTextAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SpinnerCity oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.text != oldWidget.text) {
      topText = widget.text;
      _spinTextAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipper: RectClipper(),
      child: Stack(
        children: <Widget>[
          FractionalTranslation(
            translation: Offset(0.0, _spinAnimation.value - 1.0),
            child:  Text(
                bottomText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              )
          ),
          FractionalTranslation(
              translation: Offset(0.0, _spinAnimation.value),
              child: GestureDetector(
                child: Text(
                  bottomText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                ),
                onTap: () {
                  widget.modal.mainButtonSheet(context, widget.onCitySelected);
                },
              ))
        ],
      ),
    );
  }
}

class RectClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0.0, 0.0, size.width, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
