import 'package:flutter/material.dart';

class HeroExplanationWidget extends StatelessWidget {
  const HeroExplanationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
              child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How Hero Animation Works',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),
            
            // Step 1
            _ExplanationStep(
              step: '1',
              title: 'Wrap your widget with Hero',
              description: 'Use the Hero widget and provide a unique tag',
              codeExample: 'Hero(tag: \'my_tag\', child: Icon(Icons.star))',
            ),
            
            const SizedBox(height: 12),
            
            // Step 2
            _ExplanationStep(
              step: '2',
              title: 'Use the same tag on both screens',
              description: 'The Hero widget with the same tag on the destination screen will animate',
              codeExample: 'Hero(tag: \'my_tag\', child: Icon(Icons.star, size: 80))',
            ),
            
            const SizedBox(height: 12),
            
            // Step 3
            _ExplanationStep(
              step: '3',
              title: 'Navigate between screens',
              description: 'Flutter automatically handles the smooth transition animation',
              codeExample: 'Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage()));',
            ),
            
            const SizedBox(height: 12),
            
            // Key points
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Key Points:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _BulletPoint('Hero tags must be unique'),
                  _BulletPoint('Same tag on both screens'),
                  _BulletPoint('Widgets must be similar in structure'),
                  _BulletPoint('Automatic animation handling'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExplanationStep extends StatelessWidget {
  final String step;
  final String title;
  final String description;
  final String codeExample;

  const _ExplanationStep({
    required this.step,
    required this.title,
    required this.description,
    required this.codeExample,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  step,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Text(
            codeExample,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;

  const _BulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
} 