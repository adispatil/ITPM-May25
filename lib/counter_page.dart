import 'package:flutter/material.dart';

// Main StatefulWidget for the Counter Page
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

// State class for CounterPage
class _CounterPageState extends State<CounterPage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;

  // Animation controller and animation for scaling effect
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a duration
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Define the scale animation from 1.0 to 1.2 with easeInOut curve
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    // Always dispose animation controllers to free up resources
    _animationController.dispose();
    super.dispose();
  }

  // Function to animate counter on change
  void _animateCounter() {
    _animationController.forward().then((_) => _animationController.reverse());
  }

  // Increments counter and triggers animation
  void _incrementCounter() {
    setState(() {
      _counter++;
      _animateCounter();
    });
  }

  // Decrements counter only if greater than 0
  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
        _animateCounter();
      }
    });
  }

  // Resets counter to 0
  void _resetCounter() {
    setState(() {
      _counter = 0;
      _animateCounter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with title, back button and reset button
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Stateful Counter',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed: _resetCounter,
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset Counter',
            key: const ValueKey('stateful_reset_button'),
          ),
        ],
      ),
      // Floating action button to increment the counter
      floatingActionButton: FloatingActionButton(
        heroTag: 'stateful_fab',
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      // Body with gradient background and counter display
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.withOpacity(0.2),
              Colors.grey.withOpacity(0.1),
              Colors.green.withOpacity(0.2),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Apply scale animation when counter changes
              ScaleTransition(
                scale: _scaleAnimation,
                child: Card(
                  elevation: 12,
                  shadowColor: Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(32.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFf7c0ec),
                          Color(0xFFa7bdea),
                          Color(0xFFf36364),
                        ],
                        stops: [0.1, 0.47, 1.0]
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Current Count',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          '$_counter',
                          style: TextStyle(
                            fontSize: 72,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                            shadows: [
                              Shadow(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.3),
                                offset: const Offset(2, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _CounterButton(
                    onPressed: _decrementCounter,
                    icon: Icons.remove,
                    tooltip: 'Decrement',
                  ),
                  const SizedBox(width: 24),
                  _CounterButton(
                    onPressed: _incrementCounter,
                    icon: Icons.add,
                    tooltip: 'Increment',
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

class _CounterButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String tooltip;

  const _CounterButton({
    required this.onPressed,
    required this.icon,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: FloatingActionButton(
        heroTag: 'stateful_${tooltip.toLowerCase()}_button',
        onPressed: onPressed,
        tooltip: tooltip,
        child: Icon(icon),
      ),
    );
  }
}
