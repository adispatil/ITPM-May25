import 'package:flutter/material.dart';

class ThemeShowcaseWidget extends StatelessWidget {
  const ThemeShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme Showcase',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 16),
            
            // Text styles showcase
            Text(
              'Display Large Text',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Display Medium Text',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Body Large Text',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Body Medium Text',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            
            // Button showcase
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Primary Button'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Secondary Button'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Text Button'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite),
                    tooltip: 'Like',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Color showcase
            Text(
              'Color Palette',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildColorChip(context, 'Primary', Theme.of(context).colorScheme.primary),
                _buildColorChip(context, 'Secondary', Theme.of(context).colorScheme.secondary),
                _buildColorChip(context, 'Surface', Theme.of(context).colorScheme.surface),
                _buildColorChip(context, 'Background', Theme.of(context).colorScheme.background),
                _buildColorChip(context, 'Error', Theme.of(context).colorScheme.error),
              ],
            ),
            const SizedBox(height: 24),
            
            // Icon showcase
            Text(
              'Icons',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.home,
                  color: Theme.of(context).colorScheme.primary,
                  size: 32,
                ),
                Icon(
                  Icons.favorite,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 32,
                ),
                Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 32,
                ),
                Icon(
                  Icons.notifications,
                  color: Theme.of(context).colorScheme.error,
                  size: 32,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildColorChip(BuildContext context, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
} 