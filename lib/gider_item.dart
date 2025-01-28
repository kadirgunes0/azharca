import 'package:flutter/material.dart';
import 'package:ders3/gider.dart';

class GiderItem extends StatelessWidget {
  const GiderItem(this.gider, {super.key});

  final Gider gider;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              gider.isim,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('₺${gider.miktar.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(kategoriIcons[gider.kategori]),
                    const SizedBox(width: 8),
                    Text(gider.tarihBicimlendirme),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
