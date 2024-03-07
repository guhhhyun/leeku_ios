/*
import 'dart:async';
import 'dart:convert';

import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/pages/scrapLabel/scrap_label_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';
import 'package:image/image.dart' as im;

class BluetoothPrinter extends StatefulWidget {

  @override
  _BluetoothPrinterState createState() => _BluetoothPrinterState();
}

class _BluetoothPrinterState extends State<BluetoothPrinter> {

  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  ScrapLabelController controller = Get.find();

  bool _connected = false;
  BluetoothDevice? _device;
  String tips = '연결된 기기가 없습니다';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: const Duration(seconds: 4));

    bool isConnected=await bluetoothPrint.isConnected??false;

    bluetoothPrint.state.listen((state) {
      print('******************* cur device status: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = '연결 성공';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = '연결해제 성공';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if(isConnected) {
      setState(() {
        _connected=true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          leading: TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
            ),
            onPressed: () {
              Get.back();
            },
            child: SvgPicture.asset('assets/app/arrow2Left.svg', color: AppTheme.black,),
          ),
          centerTitle: false,
          title: Text(
                '프린트',
                style: AppTheme.a18700.copyWith(color: Colors.black),
              ),
          backgroundColor: Colors.white,

        ),
        body: RefreshIndicator(
          onRefresh: () =>
              bluetoothPrint.startScan(timeout: const Duration(seconds: 4)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Text(tips),
                    ),
                  ],
                ),
                const Divider(),
                StreamBuilder<List<BluetoothDevice>>(
                  stream: bluetoothPrint.scanResults,
                  initialData: [],
                  builder: (c, snapshot) => Column(
                    children: snapshot.data!.map((d) => ListTile(
                      title: Text(d.name??''),
                      subtitle: Text(d.address??''),
                      onTap: () async {
                        setState(() {
                          _device = d;
                        });
                      },
                      trailing: _device!=null && _device!.address == d.address? const Icon(
                        Icons.check,
                        color: Colors.green,
                      ):null,
                    )).toList(),
                  ),
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          OutlinedButton(
                            onPressed:  _connected?null:() async {
                              if(_device!=null && _device!.address !=null){
                                setState(() {
                                  tips = '연결중입니다...';
                                });
                                await bluetoothPrint.connect(_device!);
                              }else{
                                setState(() {
                                  tips = '기기를 선택해주세요';
                                });
                              }
                            },
                            child: const Text('연결'),
                          ),
                          const SizedBox(width: 10.0),
                          OutlinedButton(
                            onPressed:  _connected?() async {
                              setState(() {
                                tips = '연결해제 중입니다...';
                              });
                              await bluetoothPrint.disconnect();
                            }:null,
                            child: const Text('연결해제'),
                          ),
                        ],
                      ),
                      const Divider(),
                      OutlinedButton(
                        onPressed: () async {

                          im.Image? imImage;
                          const kMaxBytes = 8;
                          Map map = await HomeApi.to.REPORT_PDF("SCRAP_LBL", {"SCRAP_NO":"2306220002"});

                          final document = await PdfDocument.openData(map["FILE"]);

                          final page = await document.getPage(1);
                          final pdfPageImage =
                          await page.render(width: page.width, height: page.height);
                          imImage = im.decodeImage(pdfPageImage!.bytes); // First issue in this line
                          await page.close();
                          var aa = pdfPageImage.bytes;
                          String base64Image = base64Encode(aa!);

                          Map<String, dynamic> config = Map();
                          config['width'] = 40;
                          config['height'] = 70;
                          config['gap'] = 2;

                    //      String base64Image = base64Encode(imageBytes);

                         List<LineText> list1 = [];
                        */
/*  var a = pageImage?.bytes;
                          List<int>? imageBytes = a?.sublist(0, kMaxBytes).toList();

                          String base64Image = base64Encode(imageBytes!);*//*

                          list1.add(LineText(type: LineText.TYPE_IMAGE, x:10, y:10, content: base64Image,));

                          await bluetoothPrint.printLabel(config, list1);
                         // await bluetoothPrint.printLabel(config, list1);
                        },
                        child: const Text('프린트 하기'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: StreamBuilder<bool>(
          stream: bluetoothPrint.isScanning,
          initialData: false,
          builder: (c, snapshot) {
            if (snapshot.data == true) {
              return FloatingActionButton(
                onPressed: () => bluetoothPrint.stopScan(),
                backgroundColor: Colors.red,
                child: const Icon(Icons.stop),
              );
            } else {
              return  FloatingActionButton(
                  child:*/
/* controller.isScaning.value ? const Icon(Icons.stop) : *//*
const Icon(Icons.search),
                  onPressed: () {
                    */
/*if(controller.isScaning.value) {
                      controller.isScaning.value = false;
                    }else {
                      controller.isScaning.value = true;
                    }*//*

                    bluetoothPrint.startScan(timeout: const Duration(seconds: 4));
                    */
/*Future.delayed(const Duration(seconds: 4), () {
                      controller.isScaning.value = false;
                    });*//*


                  }
              );
            }
          },
        ),
      ),
    );
  }

}*/
