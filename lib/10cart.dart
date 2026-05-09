import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> cart = [];

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      cart = prefs.getStringList('cart') ?? [];
    });
  }

  int totalPrice() {
    return cart.fold(0, (sum, item) {
      final price = int.parse(item.split('|')[1]);
      return sum + price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final parts = cart[index].split('|');
                return ListTile(
                  leading: Image.asset(parts[2], width: 50),
                  title: Text(parts[0]),
                  subtitle: Text("\$${parts[1]}"),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Total: \$${totalPrice()}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Checkout"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
