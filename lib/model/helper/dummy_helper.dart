import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart' as pathProvider;

class DummyHelper {
  static getAppDocumentDirectory() async {
    var appDocumentDirectory = await pathProvider.getApplicationDocumentsDirectory();
    var path = appDocumentDirectory.path;

    return path;
  }

  static createDummyImage() async {
    var path = await getAppDocumentDirectory();

    ByteData dummyImageByteData = await rootBundle.load('assets/images/dummy.jpg');
    final file = await File('$path/dummy/dummy.jpg').create(recursive: true);

    await file.writeAsBytes(dummyImageByteData.buffer.asUint8List(dummyImageByteData.offsetInBytes, dummyImageByteData.lengthInBytes));
  }

  static getImageDummy() async {
    var path = await getAppDocumentDirectory();
    var imagePath = '$path/dummy/dummy.jpg';

    return imagePath;
  }
}
