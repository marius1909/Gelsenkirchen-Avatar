import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeReader extends StatefulWidget {
  QRCodeReader({this.onQRCodeScanned});

  final Function(String) onQRCodeScanned;

  @override
  _QRViewState createState() => _QRViewState();
}

class _QRViewState extends State<QRCodeReader> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan QR Code"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: NotificationListener<SizeChangedLayoutNotification>(
              onNotification: (notification) {
                Future.microtask(() => controller?.updateDimensions(qrKey));
                return false;
              },
              child: SizeChangedLayoutNotifier(
                key: const Key('qr-size-notifier'),
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        controller.dispose();
        widget.onQRCodeScanned(scanData.code);
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
