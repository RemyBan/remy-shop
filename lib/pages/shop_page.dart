import 'package:flutter/material.dart';
import '../models/shop_item.dart';
import 'cart_page.dart';
import 'search_page.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final List<ShopItem> items = [
    ShopItem('AirPods Pro (2nd Gen)', 249.00, 'assets/AirPods Pro (2nd Gen).png'),
    ShopItem('Apple Watch Ultra 2', 799.00, 'assets/Apple Watch Ultra 2.png'),
    ShopItem('iPad Pro 12.9 M2', 1099.00, 'assets/iPad Pro 12.9 M2.png'),
    ShopItem('iPhone 15 Pro Max', 1199.00, 'assets/iPhone 15 Pro Max.png'),
    ShopItem('MacBook Air M3', 1099.00, 'assets/MacBook Air M3.png'),
  ];

  final List<ShopItem> cart = [];
  int currentIndex = 0;

  void addToCart(ShopItem item) {
    setState(() {
      cart.add(item);
    });
  }

  void removeFromCart(int index) {
    setState(() {
      cart.removeAt(index);
    });
  }

  double get totalPrice => cart.fold(0, (sum, item) => sum + item.price);

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildShopPage(),
      CartPage(
        cart: cart,
        totalGetter: () => totalPrice,
        onRemove: removeFromCart,
      ),
      SearchPage(
        allItems: items,
        onAddToCart: addToCart,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }

  Widget _buildShopPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remy Shop'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(child: Text('Total: \$${totalPrice.toStringAsFixed(2)}')),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Image.asset(item.image, width: 48, height: 48, fit: BoxFit.cover),
              title: Text(item.name),
              subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
              trailing: ElevatedButton(
                onPressed: () => addToCart(item),
                child: const Text('Add to Cart'),
              ),
            ),
          );
        },
      ),
    );
  }
}
