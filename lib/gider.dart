import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final bicimlendirme = DateFormat.yMd();

final uuid = Uuid();

enum Kategori { yemek, seyahat, calisma, eglence }

const kategoriIcons = {
  Kategori.yemek: Icons.lunch_dining,
  Kategori.seyahat: Icons.flight_takeoff,
  Kategori.calisma: Icons.work,
  Kategori.eglence: Icons.videogame_asset_rounded,
};

class Gider {
  Gider({
    required this.kategori,
    required this.isim,
    required this.miktar,
    required this.tarih,
  }) : id = uuid.v4();

  final String id;
  final String isim;
  final double miktar;
  final DateTime tarih;
  final Kategori kategori;

  String get tarihBicimlendirme {
    return bicimlendirme.format(tarih);
  }
}

class HarcamaGraph {
  const HarcamaGraph({
    required this.kategori,
    required this.giderler,
  });

  HarcamaGraph.forCategory(List<Gider> tumGiderler, this.kategori)
      : giderler =
            tumGiderler.where((gider) => gider.kategori == kategori).toList();

  final Kategori kategori;
  final List<Gider> giderler;

  double get totalGider {
    double toplam = 0;

    for (final gider in giderler) {
      toplam += gider.miktar;
    }

    return toplam;
  }
}
