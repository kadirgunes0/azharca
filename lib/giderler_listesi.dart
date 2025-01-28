import 'package:ders3/gider.dart';
import 'package:ders3/gider_item.dart';
import 'package:flutter/material.dart';

class GiderlerListesi extends StatelessWidget {
  const GiderlerListesi(
      {super.key, required this.giderler, required this.giderSilme});

  final List<Gider> giderler;
  final void Function(Gider gider) giderSilme;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: giderler.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direction) => giderSilme(giderler[index]),
        key: ValueKey(giderler[index]),
        child: GiderItem(
          giderler[index],
        ),
      ),
    );
  }
}
