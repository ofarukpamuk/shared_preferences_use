import 'dart:io';


import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences_use/my_models.dart';
import 'package:shared_preferences_use/services/stroge_service.dart';

class FileStorgeService extends StorgeServices{
  late final UserInformation userInformation;
  FileStorgeService() {
    _createFile();
  }
  Future<String> _getFilePath() async {
    var filePath =
        await getApplicationDocumentsDirectory(); // uygulama dosya yolunu ver
    return filePath.path;
  }

  _createFile() async {
    var file = File("${await _getFilePath()}/info.json");
    return file;
  }
  @override
  Future<void> verileriKaydet(UserInformation userInformation) async {
    File file = await _createFile();
    await file.writeAsString(userInformation.toJson());
  }
@override
  Future<UserInformation> verileriOku() async {
    try {
      File file = await _createFile();
      return UserInformation.fromJson(await file.readAsString());
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return UserInformation(
        isim: "", cinsiyet: Cinsiyet.KADIN, renkler: [], ogrenciMi: false);
  }
}
