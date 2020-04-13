import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String text;

  Function onPressed;
  bool showprogress;

  AppButton(this.text, {this.onPressed, this.showprogress = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: RaisedButton(
        onPressed: onPressed,
        child: showprogress
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    Colors.white,
                  ),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
        color: Colors.blue,
      ),
    );
  }
}
