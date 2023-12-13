import 'package:flutter/material.dart';

class OwnerBiography extends StatelessWidget {
  final List<String> biographyItems = [
    "Bachelor of Arts (Betriebwirtschaftslehre)",
    "Life Awareness Breathwork Instructor (Michael Bijker)",
    "Ganzheitliche Atemtherapie (Isolde Richter Schule)",
    "Atemcoach (AHAB)",
    "Buteyko Weiterbildung (Isolde Richter Schule)",
    "Neuroathletisches-Atemtraining (Z-Health Academy)",
    "Atmung - Das Meta-System (MTMT)",
    "IHHT-Ausbildung (Cellgym, Dr. Egor Egorov, und weitere)",
    "Round-Table (Dr. Egor Egorov)",
    "Kooperationspartnerin von Sport Benefits (Patrick & Steve Breitkreuz)",
    "Autorin / Die Atem-Tool-Box für Sportler, Das Begleitbuch für dein Training",
  ];

  OwnerBiography({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: biographyItems.map((item) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('• ', style: TextStyle(fontSize: 20.0)), // Bullet point
            Expanded(
              child: Text(
                item,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
