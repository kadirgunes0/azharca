import 'package:flutter/material.dart';
import 'package:ders3/gider.dart';

class YeniGider extends StatefulWidget {
  const YeniGider({super.key, required this.giderEkle});

  final void Function(Gider gider) giderEkle;

  @override
  State<YeniGider> createState() => _YeniGiderState();
}

class _YeniGiderState extends State<YeniGider> {
  final _isimKontrol = TextEditingController();
  final _girilenKontrol = TextEditingController();
  DateTime? _secilmisTarih;
  Kategori _secilmisKategori = Kategori.eglence;

  void _tarihSecme() async {
    final ilk = DateTime.now();
    final birYilOnceki = DateTime(DateTime.now().year - 1);
    final secilenTarih = await showDatePicker(
      context: context,
      firstDate: birYilOnceki,
      lastDate: ilk,
    );
    setState(() {
      _secilmisTarih = secilenTarih;
    });
  }

  void _giderGirdiData() {
    final girilenMiktar = double.tryParse(_girilenKontrol.text);
    final girdiBos = girilenMiktar == null || girilenMiktar <= 0;
    if (_isimKontrol.text.trim().isEmpty ||
        girdiBos ||
        _secilmisTarih == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Geçersiz karakterler'),
          content: Text('Lütfen geçerli bir karakter giriniz.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Tamam'),
            ),
          ],
        ),
      );
      return;
    }
    widget.giderEkle(
      Gider(
        kategori: _secilmisKategori,
        isim: _isimKontrol.text,
        miktar: girilenMiktar,
        tarih: _secilmisTarih!,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _isimKontrol.dispose();
    _girilenKontrol.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final klavyeGirdiGorme = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final genislik = constraints.maxWidth;
        return Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, klavyeGirdiGorme + 16),
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (genislik >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _isimKontrol,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text('Title'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: TextField(
                            controller: _girilenKontrol,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: '₺',
                              label: Text('Miktar'),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _isimKontrol,
                      maxLength: 50,
                      decoration: InputDecoration(
                        label: Text('Başlık'),
                      ),
                    ),
                  if (genislik >= 600)
                    Row(children: [
                      DropdownButton(
                        value: _secilmisKategori,
                        items: Kategori.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _secilmisKategori = value;
                          });
                        },
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _secilmisTarih == null
                                  ? 'Tarih Seçilmedi'
                                  : bicimlendirme.format(_secilmisTarih!),
                            ),
                            IconButton(
                              onPressed: _tarihSecme,
                              icon: const Icon(
                                Icons.calendar_month,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _girilenKontrol,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: '₺',
                              label: Text('Miktar'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _secilmisTarih == null
                                    ? 'Tarih Seçilmedi'
                                    : bicimlendirme.format(_secilmisTarih!),
                              ),
                              IconButton(
                                onPressed: _tarihSecme,
                                icon: Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  if (genislik >= 600)
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Çık'),
                        ),
                        ElevatedButton(
                          onPressed: _giderGirdiData,
                          child: const Text('Kaydet'),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                            value: _secilmisKategori,
                            items: Kategori.values
                                .map(
                                  (kategori) => DropdownMenuItem(
                                    value: kategori,
                                    child: Text(
                                      kategori.name.toUpperCase().toString(),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(
                                () {
                                  if (value == null) {
                                    return;
                                  }
                                  _secilmisKategori = value;
                                },
                              );
                            }),
                        const Spacer(),
                        
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Çık'),
                        ),
                        ElevatedButton(
                            onPressed: _giderGirdiData, child: Text('Kaydet'))
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
