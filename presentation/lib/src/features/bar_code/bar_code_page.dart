import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';

class BarCodePage extends StatefulWidget {
  const BarCodePage({Key? key}) : super(key: key);

  @override
  _BarCodePageState createState() => _BarCodePageState();
}

class _BarCodePageState extends State<BarCodePage> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanning...'),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: mq.size.height,
            width: mq.size.width,
            child: QRBarScannerCamera(
              qrCodeCallback: (value) => Navigator.of(context).pop(value),
            ),
          ),
        ],
      ),
    );
  }
}
