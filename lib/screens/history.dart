import 'package:flutter/material.dart';
import 'package:last_chance/screens/history_details.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> orderHistory = [
      {
        'title': 'Orden #12345',
        'date': '28 Nov 2024',
        'items': '2 productos',
        'total': 15.30,
      },
      {
        'title': 'Orden #12346',
        'date': '25 Nov 2024',
        'items': '5 productos',
        'total': 42.00,
      },
      {
        'title': 'Orden #12347',
        'date': '20 Nov 2024',
        'items': '1 productos',
        'total': 8.00,
      },
    ];

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
          'Historial de ordenes',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: orderHistory.length,
          itemBuilder: (context, index) {
            final order = orderHistory[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailsPage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: OrderCard(
                  title: order['title'] as String,
                  date: order['date'] as String,
                  items: order['items'] as String,
                  total: order['total'] as double,
                  onRepeat: () {
                    // Handle repeat order logic
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String title;
  final String date;
  final String items;
  final double total;
  final VoidCallback onRepeat;

  const OrderCard({
    super.key,
    required this.title,
    required this.date,
    required this.items,
    required this.total,
    required this.onRepeat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Title and Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Items and Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                items,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Divider(height: 20),

          // Repeat Order Button
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onRepeat,
              icon: const Icon(
                Icons.refresh,
                color: Color.fromARGB(255, 50, 113, 76), // Brand color
              ),
              label: const Text(
                'Repetir orden',
                style: TextStyle(
                  color: Color.fromARGB(255, 50, 113, 76), // Brand color
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
