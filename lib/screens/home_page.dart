import 'package:flutter/material.dart';
import 'package:last_chance/screens/cart.dart';
import 'package:last_chance/screens/order_tracking.dart';
import 'package:last_chance/screens/product_creation.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Tracks the currently selected bottom nav item

  void _onItemTapped(int index) {
    if (index == 1) {
      // Navigate to CartPage when Cart tab is selected
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DeliveryTrackingPage(),
        ),
      );
    }
    if (index == 2) {
      // Navigate to CartPage when Cart tab is selected
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CartPage(),
        ),
      );
    }
    if (index == 3) {
      // Navigate to CartPage when Cart tab is selected
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProductCreationPage(),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index; // Update the selected index for other tabs
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            // Implement menu action
          },
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dirección",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Text(
              "4 Hermanos #12",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // Implement profile action
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              width: 36,
              height: 36,
              child: const Icon(
                Icons.account_circle,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: "Buscar productos",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Food Categories
              const Text(
                "¿Qué estas buscando?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    CategoryItem(label: "Supermercado"),
                    CategoryItem(label: "Bebidas"),
                    CategoryItem(label: "Hamburguesas"),
                    CategoryItem(label: "Pizza"),
                    CategoryItem(label: "Pollo"),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Featured Restaurants
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Lugares Patrocinados",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Ver Más",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 50, 113, 76),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 240,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    RestaurantCard(
                      title: "McDonald's",
                      description: "Free delivery · 10-15 mins",
                      image: 'assets/images/McDonalds_logo.png',
                    ),
                    RestaurantCard(
                      title: "Starbucks",
                      description: "Free delivery · 20-25 mins",
                      image: 'assets/images/Starbucks_Logo.png',
                    ),
                    RestaurantCard(
                      title: "Burger King",
                      description: "Free delivery · 25-30 mins",
                      image: 'assets/images/BurgerKing_logo.png',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Popular Items
              const Text(
                "Productos Populares",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4, // 4 specific items
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  final items = [
                    {
                      'title': 'Manzanas',
                      'description': '1kg de manzanas',
                      'image': 'assets/images/manzana.png',
                    },
                    {
                      'title': 'Pizza Margarita',
                      'description': 'Pizza clasica italiana',
                      'image': 'assets/images/pizza.png',
                    },
                    {
                      'title': 'Leche Pil',
                      'description': 'Bolsa de leche pil 946 ML',
                      'image': 'assets/images/leche_pil.png',
                    },
                    {
                      'title': 'Combo de hamburguesa',
                      'description': 'Hamburguesa con papas y soda',
                      'image': 'assets/images/combo_hamburguesa.png',
                    },
                  ];

                  final item = items[index];

                  return PopularItemCard(
                    title: item['title']!,
                    description: item['description']!,
                    image: item['image']!,
                  );
                },
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 50, 113, 76),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Ordenes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Carrito",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notificaciones",
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String label;

  const CategoryItem({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 50, 113, 76),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const RestaurantCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Subtle shadow color
              blurRadius: 10, // Softens the shadow
              offset: const Offset(0, 4), // Moves the shadow down and right
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopularItemCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const PopularItemCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // White background
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Subtle shadow color
            blurRadius: 10, // Softens the shadow
            offset: const Offset(0, 4), // Moves the shadow down
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
