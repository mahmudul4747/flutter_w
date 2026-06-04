import 'package:flutter/material.dart';

class BirthdayCountdown extends StatelessWidget {

  final String value;

  const BirthdayCountdown({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        leading: const Icon(Icons.cake),
        title: const Text("Next Birthday"),
        subtitle: Text(value),
      ),
    );
  }
}