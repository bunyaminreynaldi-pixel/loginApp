import 'package:flutter/material.dart';

class HotelPage extends StatefulWidget {
  const HotelPage({super.key});

  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  int selectedIndex = -1;

  final List<Map<String, String>> hotels = [
    {
      "image":
          "https://images.unsplash.com/photo-1551776235-dde6d4829808?w=800",
      "name": "The Grand Palace Hotel",
      "location": "Bali, Indonesia",
      "price": "\$120 / night",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800",
      "name": "Kyoto Zen Resort",
      "location": "Kyoto, Japan",
      "price": "\$150 / night",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1582719478141-9821a0a5bdfd?w=800",
      "name": "Swiss Alpine Lodge",
      "location": "Swiss Alps",
      "price": "\$180 / night",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1542317854-f9596ae570f9?w=800",
      "name": "Dubai Dream Suites",
      "location": "Dubai, UAE",
      "price": "\$220 / night",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800",
      "name": "Santorini View Hotel",
      "location": "Santorini, Greece",
      "price": "\$140 / night",
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildHotelCard(int index) {
    final item = hotels[index];
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => selectedIndex = index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        height: isSelected ? 250 : 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: item["image"]!,
                child: Image.network(item["image"]!, fit: BoxFit.cover),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["name"]!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item["location"]!,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        item["price"]!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Luxury Hotels"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ListView.builder(
          itemCount: hotels.length,
          itemBuilder: (context, index) => buildHotelCard(index),
        ),
      ),
    );
  }
}
