import 'package:flutter/foundation.dart';


import 'package:flutter/material.dart';
import 'package:shared_preferences_use/main.dart';
import 'package:shared_preferences_use/my_models.dart';
import 'package:shared_preferences_use/services/shared_pref_services.dart';
import 'package:shared_preferences_use/services/stroge_service.dart';

class StorgePage extends StatefulWidget {
  const StorgePage({super.key});

  @override
  State<StorgePage> createState() => _StorgePageState();
}

class _StorgePageState extends State<StorgePage> {
  final StorgeServices _storgeService = storge<StorgeServices>();
  final TextEditingController _nameController = TextEditingController();
  var _secilenCinsiyet = Cinsiyet.KADIN;
  bool _ogrenciMI = false;
  List<String> _selectedColorList = [];
  @override
  void initState() {
    verileriOku();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("shared pref appbar"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "adinizi giriniz"),
            ),
          ),
          for (var item in Cinsiyet.values)
            _radioList(title: describeEnum(item), valuee: item),
          for (var item in Renkler.values) _bulidCheckBoxlist(renk: item),
          SwitchListTile(
            title: const Text("Öğrenci Mi"),
            value: _ogrenciMI,
            onChanged: (value) {
              setState(() {});
              _ogrenciMI = value;
            },
          ),
          TextButton(
            onPressed: () {
              UserInformation user = UserInformation(
                  isim: _nameController.text,
                  cinsiyet: _secilenCinsiyet,
                  renkler: _selectedColorList,
                  ogrenciMi: _ogrenciMI);
              _storgeService.verileriKaydet(user);
            },
            child: const Text("Kaydet"),
          )
        ],
      ),
    );
  }

  CheckboxListTile _bulidCheckBoxlist({required Renkler renk}) {
    return CheckboxListTile(
        title: Text(describeEnum(renk)),
        value: _selectedColorList
            .contains(describeEnum(renk)), // bu liste içerisinde varsa işaretle
        onChanged: (bool? checkedvalue) {
          if (checkedvalue == false) {
            _selectedColorList.remove(describeEnum(
                renk)); // seçimi kaldırdığı zaman listeden elemanı çıkarmak için
          } else {
            _selectedColorList.add(describeEnum(renk));
          }
          setState(() {});
        });
  }

  RadioListTile<Cinsiyet> _radioList(
      {required String title, required Cinsiyet valuee}) {
    return RadioListTile(
      title: Text(title),
      value: valuee,
      groupValue: _secilenCinsiyet,
      onChanged: (Cinsiyet? value) {
        setState(() {});
        _secilenCinsiyet = value!;
      },
    );
  }

  void verileriOku() async {
    var info = await _storgeService.verileriOku();
    _nameController.text = info.isim;
    _ogrenciMI = info.ogrenciMi;
    _secilenCinsiyet = info.cinsiyet;
    _selectedColorList = info.renkler;
    setState(() {});
  }
}
