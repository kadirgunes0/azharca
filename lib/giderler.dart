import 'package:ders3/giderler_listesi.dart';
import 'package:ders3/yeni_gider.dart';
import 'package:flutter/material.dart';
import 'package:ders3/gider.dart';
import 'package:ders3/grafik.dart';

class Giderler extends StatefulWidget {
  const Giderler({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GiderlerState();
  }
}

class _GiderlerState extends State<Giderler> {
  final List<Gider> _registeredGiderler = [
    Gider(
      kategori: Kategori.yemek,
      isim: 'kadir',
      miktar: 30.5,
      tarih: DateTime.now(),
    ),
    Gider(
      kategori: Kategori.eglence,
      isim: 'Bayro',
      miktar: 40.5,
      tarih: DateTime.now(),
    )
  ];

  void _giderEklemeArayuzu() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => YeniGider(giderEkle: _giderEkle),
    );
  }

  void _giderEkle(Gider gider) {
    setState(() {
      _registeredGiderler.add(gider);
    });
  }

  void _giderKaldir(Gider gider) {
    final giderIndex = _registeredGiderler.indexOf(gider);
    setState(() {
      _registeredGiderler.remove(gider);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text('Harcama silindi'),
        action: SnackBarAction(
          label: 'Geri al!',
          onPressed: () {
            setState(
              () {
                _registeredGiderler.insert(giderIndex, gider);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ekranDuzeni = MediaQuery.of(context).size.width;

    Widget bosKisim = const Center(
      child: Text('Herhangi bir harcama yok, hadi ekleyelim'),
    );
    if (_registeredGiderler.isNotEmpty) {
      bosKisim = GiderlerListesi(
          giderler: _registeredGiderler, giderSilme: _giderKaldir);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Az Harca'),
        actions: [
          IconButton(
            onPressed: _giderEklemeArayuzu,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ekranDuzeni < 600
          ? Column(
              children: [
                Grafik(giderler: _registeredGiderler),
                Expanded(
                  child: bosKisim,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Grafik(giderler: _registeredGiderler),
                ),
                Expanded(
                  child: bosKisim,
                ),
              ],
            ),
    );
  }
}
