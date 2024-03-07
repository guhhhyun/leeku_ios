import 'package:egu_industry/app/common/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Qr extends StatefulWidget {
  const Qr({super.key});

  @override
  State<Qr> createState() => _QrState();
}

class _QrState extends State<Qr> {
  bool _qr = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('qr'),),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _qr = true;
                  });
                },
                child: Text('클릭', style: AppTheme.a18700.copyWith(color: AppTheme.black),),
              ),
            ),
            Container(
              child: _qr ? QrImageView(
                data: 'https://www.youtube.com/watch?v=fkJvoYLJWb0',
                version: QrVersions.auto,
                size: 200.0,
              ) : Container()
            )
          ],
        ),
      )
    );
  }
}
