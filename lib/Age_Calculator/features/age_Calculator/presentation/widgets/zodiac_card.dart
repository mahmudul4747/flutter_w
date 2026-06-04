import 'package:flutter/material.dart';

class ZodiacCard extends StatelessWidget {

  final String zodiac;

  const ZodiacCard({
    super.key,
    required this.zodiac,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      color: Colors.blue.shade50,
      child: ListTile(
        leading: const Icon(Icons.star),
        title: const Text("Zodiac Sign"),
        trailing: Text(
          zodiac,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}