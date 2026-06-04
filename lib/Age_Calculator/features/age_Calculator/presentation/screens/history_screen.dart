import 'package:flutter/material.dart';
import 'package:flutter_w/Age_Calculator/features/age_Calculator/data/model/history_model.dart';
import '../../data/services/firebase_service.dart';


class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final firebase = FirebaseService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),

      body: FutureBuilder<List<HistoryModel>>(
        future: firebase.getHistory(),

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No History Found"),
            );
          }

          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,

            itemBuilder: (context, index) {

              final item = data[index];

              return Card(
                child: ListTile(
                  leading:
                      const Icon(Icons.history),

                  title: Text(item.dob),

                  subtitle: Text(
                    item.calculatedAge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  trailing: Text(
                    item.createdAt
                        .toString()
                        .substring(0, 10),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}