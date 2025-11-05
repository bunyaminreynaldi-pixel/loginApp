import 'package:flutter/material.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  int selectedIndex = -1;

  final List<Map<String, String>> travels = [
    {
      "image":
          "https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800",
      "title": "Explore Bali Paradise",
      "location": "Bali, Indonesia",
      "price": "\$299 / 3D2N",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1508264165352-258859e62245?w=800",
      "title": "Tokyo City Lights",
      "location": "Tokyo, Japan",
      "price": "\$499 / 4D3N",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1524499982521-1ffd58dd89ea?w=800",
      "title": "Romantic Paris Getaway",
      "location": "Paris, France",
      "price": "\$799 / 5D4N",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1505761671935-60b3a7427bad?w=800",
      "title": "Desert Safari Experience",
      "location": "Dubai, UAE",
      "price": "\$399 / 3D2N",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1543349689-9a4d426bee8e?w=800",
      "title": "Swiss Mountain Trails",
      "location": "Swiss Alps",
      "price": "\$599 / 4D3N",
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

  Widget buildTravelCard(int index) {
    final item = travels[index];
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
                      item["title"]!,
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
        title: const Text("Travel Packages"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ListView.builder(
          itemCount: travels.length,
          itemBuilder: (context, index) => buildTravelCard(index),
        ),
      ),
    );
  }
}
