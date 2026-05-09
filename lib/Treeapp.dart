import 'package:flutter/material.dart';
import 'package:flutter_w/Colors.dart';

class Treeapp extends StatelessWidget {
  const Treeapp({super.key});

  final List<Map<String, dynamic>> plants = const [
    {"name": "Aloe Vera", "price": 15, "img": "assets/image_1.png"},
    {"name": "Snake Plant", "price": 20, "img": "assets/plant9.jpg"},
    {"name": "Money Plant", "price": 12, "img": "assets/img.png"},
  ];

  final List<Map<String, dynamic>> plant = const [
    {"name": "Sacus Plant", "price": 15, "img": "assets/image_1.png"},
    {"name": "Valby Plant", "price": 20, "img": "assets/plant9.jpg"},
    {"name": "Giore Plant", "price": 12, "img": "assets/img.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                      height: 300,
                      width: double.infinity,
                      color: MainColor,
                    ),
                  ),

                  // Menu Button
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

                  // Header Text + Logo
                  Padding(
                    padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
                    child: Row(
                      children: [
                        const Text(
                          'Hi Ushipy',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.only(top: 260, left: 20, right: 20),
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: MainColor,
                            spreadRadius: 2,
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
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

              // Recommended Title + Button
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
                        'See All',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // First Horizontal Scroll
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

              // Second Horizontal Scroll
              SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 20),
                  itemCount: plant.length, // FIXED HERE 🔥
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
          ),
        ),
      ),
    );
  }

  // Reusable Card Widget
  Widget buildPlantCard(
      BuildContext context, String name, int price, String img) {
    return Container(
      height: 300,
      width: 180,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 159, 215, 223),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              img,
              width: 180,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),

          // Name + Price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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

          // Cart + Favorite
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add_shopping_cart_outlined),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Added $name to cart"),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
                const Spacer(),
                const Icon(Icons.favorite_border, color: Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
