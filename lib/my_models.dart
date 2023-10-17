import 'dart:convert';


import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: constant_identifier_names

enum Cinsiyet { 
  KADIN, ERKEK, DIGER 
  }

enum Renkler { SARI, KIRMIZI, MAVI, YESIL, PEMBE }

class UserInformation {
  final String isim;
  final Cinsiyet cinsiyet;
  final List<String> renkler;
  final bool ogrenciMi;

  UserInformation({
    required this.isim,
    required this.cinsiyet,
    required this.renkler,
    required this.ogrenciMi,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isim': isim,
      'cinsiyet': describeEnum(Cinsiyet),
      'renkler': renkler,
      'ogrenciMi': ogrenciMi,
    };
  }

  factory UserInformation.fromMap(Map<String, dynamic> map) {
    return UserInformation(
      isim: map['isim'],
      cinsiyet: Cinsiyet.values.firstWhere((element) => describeEnum(element).toString() == map['cinsiyet']),// şart yazdık yani gezdiği ilk eleman  map tekine eşitse onu oraya ata 
      renkler: List<String>.from((map['renkler'])),
      ogrenciMi: map['ogrenciMi'],
      )
    ;
  }

  String toJson() => json.encode(toMap());

  factory UserInformation.fromJson(String source) => UserInformation.fromMap(json.decode(source) as Map<String, dynamic>);
}
