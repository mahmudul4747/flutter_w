import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('wishlist');

    return Scaffold(
      appBar: AppBar(title: const Text("Wishlist")),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("No favorites yet"));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final item = box.getAt(index);
              return ListTile(
                leading: Image.asset(item['img'], width: 50),
                title: Text(item['name']),
                subtitle: Text("\$${item['price']}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => box.deleteAt(index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
