import 'package:flutter/material.dart';

class sheLoadingPage extends StatelessWidget {
  bool bLoading;

  sheLoadingPage({super.key, required this.bLoading});

  @override
  Widget build(BuildContext context) {
    if (bLoading) {
      return Container(
        color: Colors.grey.withOpacity(0.2),
        child: Center(child: CircularProgressIndicator()),
      );
    } else {
      return const SizedBox();
    }
  }
}
