import 'package:flutter/material.dart';

import 'package:ders3/grafik_bar.dart';
import 'package:ders3/gider.dart';

class Grafik extends StatelessWidget {
  const Grafik({super.key, required this.giderler});

  final List<Gider> giderler;

  List<HarcamaGraph> get buckets {
    return [
      HarcamaGraph.forCategory(giderler, Kategori.yemek),
      HarcamaGraph.forCategory(giderler, Kategori.eglence),
      HarcamaGraph.forCategory(giderler, Kategori.seyahat),
      HarcamaGraph.forCategory(giderler, Kategori.calisma),
    ];
  }

  double get maxTotalGider {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalGider > maxTotalExpense) {
        maxTotalExpense = bucket.totalGider;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets)
                  GrafikBar(
                    fill: bucket.totalGider == 0
                        ? 0
                        : bucket.totalGider / maxTotalGider,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        kategoriIcons[bucket.kategori],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
