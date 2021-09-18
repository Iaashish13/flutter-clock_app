import 'package:flutter/material.dart';

class NewButtons extends StatelessWidget {
  final String name;
  final VoidCallback? onPressed;
  final Color primaryColor;
  NewButtons({
    Key? key,
    required this.name,
    required this.onPressed,
    required this.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        name,
        style: TextStyle(
          fontSize: 18.0,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w400,
        ),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: primaryColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        minimumSize: Size(100, 50),
      ),
    );
  }
}
