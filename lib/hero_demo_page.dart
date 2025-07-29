import 'package:flutter/material.dart';
import 'hero_card_widget.dart';
import 'hero_detail_page.dart';
import 'hero_explanation_widget.dart';

class HeroDemoPage extends StatelessWidget {
  const HeroDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hero Animation Demo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.withOpacity(0.1),
              Colors.purple.withOpacity(0.1),
              Colors.pink.withOpacity(0.1),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section with explanation
              const HeroExplanationWidget(),
              const SizedBox(height: 24),
              
              // Examples section
              Text(
                'Tap on any card to see the hero animation:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              
              // Grid of hero cards
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  HeroCardWidget(
                    title: 'Flutter Logo',
                    subtitle: 'Tap to animate',
                    heroTag: 'flutter_logo',
                    color: Colors.blue,
                    icon: Icons.flutter_dash,
                    onTap: () => _navigateToDetail(context, 'flutter_logo'),
                  ),
                  HeroCardWidget(
                    title: 'Heart Icon',
                    subtitle: 'Tap to animate',
                    heroTag: 'heart_icon',
                    color: Colors.red,
                    icon: Icons.favorite,
                    onTap: () => _navigateToDetail(context, 'heart_icon'),
                  ),
                  HeroCardWidget(
                    title: 'Star Icon',
                    subtitle: 'Tap to animate',
                    heroTag: 'star_icon',
                    color: Colors.amber,
                    icon: Icons.star,
                    onTap: () => _navigateToDetail(context, 'star_icon'),
                  ),
                  HeroCardWidget(
                    title: 'Diamond Icon',
                    subtitle: 'Tap to animate',
                    heroTag: 'diamond_icon',
                    color: Colors.purple,
                    icon: Icons.diamond,
                    onTap: () => _navigateToDetail(context, 'diamond_icon'),
                  ),
                ],
              ),
              const SizedBox(height: 24), // Add bottom padding
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, String heroTag) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => 
            HeroDetailPage(heroTag: heroTag),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
} 