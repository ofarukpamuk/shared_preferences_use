import 'dart:convert';


import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences_use/my_models.dart';
import 'package:shared_preferences_use/services/stroge_service.dart';

class SecureStorgeService extends StorgeServices {
  final  storge = const FlutterSecureStorage();
  @override
  Future<void> verileriKaydet(UserInformation user) async {
    //kaydetme işlemleri uzun sürdüğü için bu yapıyı kullanmalıyoz
    await storge.write(key: "isim", value: user.isim);
    await storge.write(key: "cinsiyet", value: user.cinsiyet.index.toString());
    await storge.write(key: "ogrenci_Mi", value: user.ogrenciMi.toString());
    await storge.write(key: "secilen_renkler", value: user.renkler.toString());
  }

  @override
  Future<UserInformation> verileriOku() async {
    var isim = await storge.read(key: "isim");
    var ogrenciMI =
        await storge.read(key: "ogrenci_Mi") == "false" ? false : true;

    String cinsiyet0 = await storge.read(key: "cinsiyet") ?? "0";
    Cinsiyet cinsiyet = Cinsiyet.values[int.parse(cinsiyet0)];

    var renkler0 = await storge.read(key: "secilen_renkler");
    var renkler =
        renkler0 == null ? <String>[] : List<String>.from(jsonDecode(renkler0));

    return UserInformation(
        isim: isim.toString(),
        cinsiyet: cinsiyet,
        renkler: renkler,
        ogrenciMi: ogrenciMI);
  }
}
