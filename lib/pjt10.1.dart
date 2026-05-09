import 'package:flutter/material.dart';
import 'package:flutter_w/pjt10.2.dart';
import 'package:flutter_w/project10.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // 🔥 Premium Gradient Background
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
            
                        'assets/aloe_vera.png',
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
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const Treeapps(),
                          ));
                        },
                      ),
                    ),
                  ),

                  // 🔥 Glassmorphism Name + Price Box
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.55),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Aloe Vera',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '\$99.99',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Description
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'This is a premium quality Aloe Vera plant. Perfect for indoor decoration and air purification. Easy to maintain and long-lasting.',
                  style: TextStyle(fontSize: 18, color:Colors.black87,fontStyle:  FontStyle.italic, height: 1.4),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 35),

              // 🔥 3 Premium Buttons Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // Add to Cart
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 145, 228, 149),
                          foregroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Favorite Icon Button
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.redAccent.withOpacity(0.3),
                            blurRadius: 8,
                          )
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.white, size: 28),
                        onPressed: () {},
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Buy Now
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                      Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutPage(),
                                  ),
                                );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple.shade400,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          'Buy Now',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
