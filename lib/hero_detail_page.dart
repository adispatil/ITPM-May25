import 'package:flutter/material.dart';

class HeroDetailPage extends StatelessWidget {
  final String heroTag;

  const HeroDetailPage({
    super.key,
    required this.heroTag,
  });

  // Helper method to get icon and color based on hero tag
  Map<String, dynamic> _getIconData() {
    switch (heroTag) {
      case 'flutter_logo':
        return {
          'icon': Icons.flutter_dash,
          'color': Colors.blue,
          'title': 'Flutter Logo',
          'description': 'The official Flutter mascot - Dash! This cute bird represents the Flutter framework and its community.',
        };
      case 'heart_icon':
        return {
          'icon': Icons.favorite,
          'color': Colors.red,
          'title': 'Heart Icon',
          'description': 'A symbol of love and affection. Perfect for like buttons and favorite features.',
        };
      case 'star_icon':
        return {
          'icon': Icons.star,
          'color': Colors.amber,
          'title': 'Star Icon',
          'description': 'A classic star symbol often used for ratings, favorites, and special features.',
        };
      case 'diamond_icon':
        return {
          'icon': Icons.diamond,
          'color': Colors.purple,
          'title': 'Diamond Icon',
          'description': 'A precious gem symbol representing premium features and high value.',
        };
      default:
        return {
          'icon': Icons.help,
          'color': Colors.grey,
          'title': 'Unknown Icon',
          'description': 'This is a placeholder for an unknown icon.',
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconData = _getIconData();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(iconData['title']),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              iconData['color'].withOpacity(0.1),
              Colors.white,
              iconData['color'].withOpacity(0.05),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Hero widget - same tag as the source
              Hero(
                tag: heroTag,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: iconData['color'].withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Icon(
                    iconData['icon'],
                    size: 80,
                    color: iconData['color'],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // Title
              Text(
                iconData['title'],
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: iconData['color'],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              
              // Description
              Text(
                iconData['description'],
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[700],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              
              // Additional information card
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Hero Animation Details',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: iconData['color'],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _InfoRow(
                        label: 'Hero Tag:',
                        value: heroTag,
                        color: iconData['color'],
                      ),
                      const SizedBox(height: 8),
                      _InfoRow(
                        label: 'Icon Name:',
                        value: iconData['icon'].toString(),
                        color: iconData['color'],
                      ),
                      const SizedBox(height: 8),
                      _InfoRow(
                        label: 'Color:',
                        value: iconData['color'].toString(),
                        color: iconData['color'],
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              
              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('You liked ${iconData['title']}!'),
                            backgroundColor: iconData['color'],
                          ),
                        );
                      },
                      icon: const Icon(Icons.thumb_up),
                      label: const Text('Like'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: iconData['color'],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Go Back'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: iconData['color'],
                        side: BorderSide(color: iconData['color']),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
} 