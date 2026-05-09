import 'package:flutter/material.dart';

// Home page template showing a watch image, price and simple animations.

class HomeWatchPage extends StatefulWidget {
  const HomeWatchPage({Key? key}) : super(key: key);

  @override
  State<HomeWatchPage> createState() => _HomeWatchPageState();
}

class _HomeWatchPageState extends State<HomeWatchPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotation;
  late final Animation<double> _scale;

  bool _liked = false;
  bool _inCart = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _rotation = Tween<double>(begin: 0, end: 0.08).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _scale = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapImage() async {
    await _controller.forward();
    await _controller.reverse();
  }

  void _toggleLike() {
    setState(() => _liked = !_liked);
  }

  void _addToCart() async {
    setState(() => _inCart = true);
    await Future.delayed(const Duration(milliseconds: 900));
    setState(() => _inCart = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    const watchImage = 'assets/17017.jpg';
    const watchTitle = 'Aero Classic — Men\'s Watch';
    const watchPrice = '৳ 4,250';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Watch Store'),
        backgroundColor: Colors.purpleAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _onTapImage,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotation.value,
                    child: Transform.scale(
                      scale: _scale.value,
                      child: child,
                    ),
                  );
                },
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Hero(
                          tag: 'watch-hero',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset('assets/17017.jpg',
                              
                              width: 140,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                watchTitle,
                                style: Theme.of(context).textTheme.titleMedium,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                watchPrice,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: _inCart ? null : _addToCart,
                                    icon: _inCart
                                        ? const SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      Colors.white),
                                            ),
                                          )
                                        : const Icon(Icons.shopping_cart),
                                    label: Text(_inCart ? 'Adding...' : 'Add'),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    onPressed: _toggleLike,
                                    icon: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      transitionBuilder: (child, anim) =>
                                          ScaleTransition(
                                              scale: anim, child: child),
                                      child: _liked
                                          ? const Icon(
                                              Icons.favorite,
                                              key: ValueKey('liked'),
                                              color: Colors.red,
                                            )
                                          : const Icon(
                                              Icons.favorite_border,
                                              key: ValueKey('unliked'),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final price = '৳ ${3500 + index * 450}';
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        watchImage,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text('Classic ${index + 1}'),
                    subtitle: Text(price),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_shopping_cart_outlined),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Added Classic ${index + 1}')),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
