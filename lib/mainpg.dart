import 'package:flutter/material.dart';
import 'package:flutter_w/10bredg.dart';
import 'package:flutter_w/project10.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  int index = 0;

  int cartCount = 0;
  int favCount = 0;
 


  final pages = const [
    Treeapps(),
    Center(child: Text("Cart Page")),
    Center(child: Text("Favorite Page")),
    Center(child: Text("Profile Page")),
  ];

  @override
  void initState() {
    super.initState();
    loadCounts();
  }

  Future<void> loadCounts() async {
    final prefs = await SharedPreferences.getInstance();
    final cart = prefs.getStringList('cart') ?? [];
    final favBox = Hive.box('wishlist');

    setState(() {
      cartCount = cart.length;
      favCount = favBox.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
bottomNavigationBar: BottomNavigationBar(
  currentIndex: index,
  onTap: (i) {
    setState(() => index = i);
    loadCounts(); // refresh badge
  },
  items: [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        color: Color.fromARGB(221, 33, 238, 6),
      ),
      label: 'Home',
    ),

    BottomNavigationBarItem(
      icon: BadgeIcon(
        icon: Icons.shopping_cart,
        Color: Colors.black87,
        count: cartCount,
      ),
      label: 'Cart',
    ),

    BottomNavigationBarItem(
      icon: BadgeIcon(
        icon: Icons.favorite,
        Color: const Color.fromARGB(221, 248, 58, 58),
        count: favCount,
      ),
      label: 'Favorite',
    ),

    const BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
        color: Color.fromARGB(221, 228, 13, 13),
      ),
      label: 'Profile',
    ),
  ],
),

    );
  }
}
