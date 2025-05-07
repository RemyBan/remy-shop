import 'package:flutter/material.dart';
import '../models/shop_item.dart';

class SearchPage extends StatefulWidget {
  final List<ShopItem> allItems;
  final void Function(ShopItem) onAddToCart;

  const SearchPage({
    super.key,
    required this.allItems,
    required this.onAddToCart,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ShopItem> filteredItems = [];
  String query = '';

  void updateSearch(String input) {
    setState(() {
      query = input.toLowerCase();
      filteredItems = widget.allItems
          .where((item) => item.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: updateSearch,
              decoration: const InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredItems.isEmpty && query.isNotEmpty
                  ? const Center(child: Text('No results found.'))
                  : ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return ListTile(
                    leading: Image.asset(item.image, width: 48, height: 48),
                    title: Text(item.name),
                    subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                    trailing: ElevatedButton(
                      onPressed: () => widget.onAddToCart(item),
                      child: const Text('Add'),
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

