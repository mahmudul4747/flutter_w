import 'package:flutter/material.dart';
import 'package:flutter_w/Colors.dart';
import 'package:flutter_w/pjt10.0.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';


class CartService {
  static Future<void> addToCart(String itemName) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList('cart') ?? [];
    cart.add(itemName);
    await prefs.setStringList('cart', cart);
  }
}

class Treeapps extends StatefulWidget {
  const Treeapps({super.key});

  @override
  State<Treeapps> createState() => _TreeappsState();
}

class _TreeappsState extends State<Treeapps> {
  // Original lists
  final List<Map<String, dynamic>> plants = [
    {"name": "Aloe Vera", "price": 15, "img": "assets/image_1.png"},
    {"name": "Snake Plant", "price": 20, "img": "assets/plant9.jpg"},
    {"name": "Momdela Plant", "price": 12, "img": "assets/img.png"},
  ];

  final List<Map<String, dynamic>> plant = [
    {"name": "Sacus Plant", "price": 15, "img": "assets/plant8.jpg"},
    {"name": "Valby Plant", "price": 20, "img": "assets/plant15.png"},
    {"name": "Giore Plant", "price": 12, "img": "assets/plant14.png"},
  ];

  // Search related variables
  String searchText = "";
  List<Map<String, dynamic>> searchResult = [];

  // SEARCH FUNCTION
  void searchItem(String value) {
    searchText = value.toLowerCase();

    List<Map<String, dynamic>> all = [...plants, ...plant];

    setState(() {
      searchResult = all
          .where((item) => item["name"].toLowerCase().contains(searchText))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    child: Container(
                      height: 270,
                      width: double.infinity,
                      color: MainColor,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: IconButton(
                      icon: const Icon(Icons.menu),
                      color: Colors.black,
                      iconSize: 30,
                      splashRadius: 25,
                      onPressed: () {},
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(top: 65, left: 20, right: 20),
                    child: Row(
                      children: [
                        const Text(
                          'Hi Ushipy',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/logo2.png',
                            width: 80,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Search bar
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 235, left: 20, right: 20),
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: const Offset(0, 8),
                            blurRadius: 20,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: searchItem,
                              decoration: const InputDecoration(
                                hintText: "Search",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            width: 70,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 228, 224, 224),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            child: const Icon(
                              Icons.search_rounded,
                              size: 30,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 60),

              // ---------------------
              // SEARCH RESULT SECTION
              // ---------------------
              if (searchText.isNotEmpty) ...[
                const Text(
                  "Search Result",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                if (searchResult.isEmpty)
                  const Text(
                    "❌ No Result Found",
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  )
                else
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 20),
                      itemCount: searchResult.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            buildPlantCard(
                              context,
                              searchResult[index]["name"],
                              searchResult[index]["price"],
                              searchResult[index]["img"],
                            ),
                            const SizedBox(width: 20),
                          ],
                        );
                      },
                    ),
                  ),

                const SizedBox(height: 40),
              ],

              // ---------------------
              // NORMAL UI (Recommended)
              // ---------------------
              if (searchText.isEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recommended',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'more',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 20),
                    itemCount: plants.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          buildPlantCard(
                            context,
                            plants[index]["name"],
                            plants[index]["price"],
                            plants[index]["img"],
                          ),
                          const SizedBox(width: 20),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 20),
                    itemCount: plant.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          buildPlantCard(
                            context,
                            plant[index]["name"],
                            plant[index]["price"],
                            plant[index]["img"],
                          ),
                          const SizedBox(width: 20),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
    );    
    
  }

  // ---------- CARD WIDGET ----------
 Widget buildPlantCard(
    BuildContext context, String name, int price, String img) {
  return GestureDetector(
    onTap: () {
      // ✅ Product Details Page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductDetailsPage(
            name: name,
            price: price,
            img: img,
          ),
        ),
      );
    },
    child: Container(
      height: 300,
      width: 180,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 159, 215, 223),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              img,
              width: 180,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  "\$$price",
                  style:
                      const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                // ✅ Add to Cart
                IconButton(
                  icon: const Icon(Icons.add_shopping_cart_outlined),
                  onPressed: () async {
                    await CartService.addToCart(name);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("$name added to cart"),
                      ),
                    );
                  },
                ),

                const Spacer(),

                // ✅ Favorite (Hive)
               IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.red),
                  onPressed: () {
                    final box = Hive.box('wishlist');

                    box.add({
                      'name': name,
                      'price': price,
                      'img': img,
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$name added to wishlist')),
                    );
                  },
                ),

              ],
            ),
          ),
        ],
      ),
    ),
  );
}

}
