import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_w/pjt10.2.dart'; // CheckoutPage
import 'package:flutter_w/project10.dart'; // Treeapps

class ProductDetailsPage extends StatelessWidget {
  final String name;
  final int price;
  final String img;

  const ProductDetailsPage({
    super.key,
    required this.name,
    required this.price,
    required this.img,
  });

  // -----------------------------
  // Add to Cart (SharedPreferences)
  Future<void> addToCart(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList('cart') ?? [];

    cart.add('$name|$price|$img');
    await prefs.setStringList('cart', cart);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$name added to cart')),
    );
  }

  // -----------------------------
  // Favorite Toggle (Hive)
  void toggleFavorite(BuildContext context) {
    final box = Hive.box('wishlist');

    int index =
        box.values.toList().indexWhere((item) => item['name'] == name);

    if (index == -1) {
      box.add({'name': name, 'price': price, 'img': img});
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Added to wishlist')));
    } else {
      box.deleteAt(index);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Removed from wishlist')));
    }
  }

  bool isFavorite() {
    final box = Hive.box('wishlist');
    return box.values.any((item) => item['name'] == name);
  }

  // -----------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================== IMAGE + HEADER ==================
            Stack(
              children: [
                Container(
                  height: 420,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.purple.shade300,
                        Colors.green.shade200,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      img,
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // 🔙 Modern Back Button
                  Positioned(
                    top: 20,
                    left: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                          )
                        ],
                      ),
                      
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.black87,
                        onPressed: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const Treeapps()),
                        );
                        },
                      ),
                    ),
                  ),

                // Name + Price
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$$price',
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),const SizedBox(height: 20),

              // Description
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'This is a premium quality its plant.'
                   'Perfect for indoor decoration and air purification. '
                  'Easy to maintain and long-lasting.'

                  'Plant Details:'
                  'hight is 12 to 15 inches.'
                  'width is 6 to 8 inches.'
                  'Age: 6 months to 1 year.'
                  "and it's a natural plant."
                  "It is very useful for health."

                  "last is ask your qustion in comment box.",
                  style: TextStyle(fontSize: 18, color:Colors.black87,fontStyle:  FontStyle.italic, height: 1.4),
                  textAlign: TextAlign.center,
                ),
              ),

            const SizedBox(height: 25),

            // ================== BUTTONS ==================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Add to Cart
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => addToCart(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Favorite Button
                  ValueListenableBuilder(
                    valueListenable: Hive.box('wishlist').listenable(),
                    builder: (context, box, _) {
                      return Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: IconButton(
                          icon: Icon(
                            isFavorite()
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.white,
                          ),
                          onPressed: () => toggleFavorite(context),
                        ),
                      );
                    },
                  ),

                  const SizedBox(width: 12),

                  // Buy Now
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        addToCart(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CheckoutPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 205, 122, 219),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}