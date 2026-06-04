import 'package:flutter/material.dart';

class AgeCard extends StatelessWidget {

  final String title;
  final String value;
  final IconData icon;

  const AgeCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [

              Icon(icon, size: 28),

              const SizedBox(height: 10),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}