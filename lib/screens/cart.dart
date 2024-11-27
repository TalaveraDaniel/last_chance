import 'package:flutter/material.dart';
import 'package:last_chance/screens/checkout.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Sample cart items
  final List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Leche Pil',
      'description': 'Bolsa de leche pil 946 ML',
      'price': 15.30,
      'quantity': 1,
      'image': 'assets/images/leche_pil.png',
    },
    {
      'name': 'Manzanas',
      'description': '1kg de manzanas',
      'price': 12.00,
      'quantity': 1,
      'image': 'assets/images/manzana.png',
    },
  ];

  // Cart totals
  double get subtotal => cartItems.fold(
        0,
        (total, item) => total + (item['price'] * item['quantity']),
      );

  double get deliveryFee => 7.00; // Flat delivery fee
  double get total => subtotal + deliveryFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Cart Items List
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return CartItemCard(
                    name: item['name'],
                    description: item['description'],
                    price: item['price'],
                    quantity: item['quantity'],
                    image: item['image'],
                    onIncrease: () {
                      setState(() {
                        item['quantity']++;
                      });
                    },
                    onDecrease: () {
                      setState(() {
                        if (item['quantity'] > 1) {
                          item['quantity']--;
                        }
                      });
                    },
                    onRemove: () {
                      setState(() {
                        cartItems.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                SummaryRow(
                  label: 'Subtotal',
                  value: '${subtotal.toStringAsFixed(2)} Bs',
                ),
                SummaryRow(
                  label: 'Delivery',
                  value: '${deliveryFee.toStringAsFixed(2)} Bs',
                ),
                const SizedBox(height: 8),
                SummaryRow(
                  label: 'Total',
                  value: '${total.toStringAsFixed(2)} Bs',
                  isBold: true,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Checkout Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutPage(
                      deliveryFee: deliveryFee,
                      subtotal: subtotal,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 50, 113, 76), // Brand color
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Center(
                child: Text(
                  "CHECKOUT",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Cart Item Card
class CartItemCard extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String image;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.image,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Placeholder for item image
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 12),
            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${price.toStringAsFixed(2)} Bs',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 50, 113, 76),
                    ),
                  ),
                ],
              ),
            ),
            // Quantity Controls
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.black),
                  onPressed: onIncrease,
                ),
                Text(
                  '$quantity',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle, color: Colors.black),
                  onPressed: onDecrease,
                ),
              ],
            ),
            // Remove Button
            IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}

// Summary Row
class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
