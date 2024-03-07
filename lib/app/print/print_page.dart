/*

import 'dart:convert';
import 'dart:typed_data';

import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdfx/pdfx.dart' as px;
import 'package:printing/printing.dart';



class PrintPage extends StatelessWidget {
  const PrintPage(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              ),
              onPressed: () {
                Get.back();
              },
              child: SvgPicture.asset('assets/app/arrow2Left.svg', color: AppTheme.black,),
            ),
            title: Text('프린트', style: AppTheme.a18700.copyWith(color: Colors.black),)
        ),
        body: PdfPreview(
          build: (format) => _generatePdf(format, title),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    const kMaxBytes = 8;
    final pdf = pw.Document();
    Map map = await HomeApi.to.REPORT_PDF("SCRAP_LBL", {"SCRAP_NO":"2306220002"});
    final document = await px.PdfDocument.openData(map["FILE"]);
    final page = await document.getPage(1);
    final pdfPageImage =
    await page.render(width: page.width, height: page.height);
    await page.close();
    var aa = pdfPageImage?.bytes;
  //  String base64Image = base64Encode(aa!);
    final image = pw.MemoryImage(aa!);
    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Center(child: pw.Image(image));
        },
      ),
    );
    await Printing.layoutPdf(onLayout: (_) => aa, format: format);

    return pdf.save();
  }
}*/
