import 'package:flutter/material.dart';

class CommonLoading extends StatelessWidget {
  bool bLoading;

  CommonLoading({Key? key, required this.bLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (bLoading) {
      return Container(
        color: Colors.grey.withOpacity(0.2),
        child: Center(
          child: CircularProgressIndicator(),
        ),

      ) ;
    } else {
      return Container();
    }
  }
}
