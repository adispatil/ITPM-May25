import 'package:flutter/material.dart';
import '../../widgets/sidebar/sidebar_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? selectedMenuItem;



  void _onMenuItemSelected(String title) {
    setState(() {
      selectedMenuItem = title;
    });
  }

  Widget _buildContent() {
    switch (selectedMenuItem) {
      case 'Overview':
        return _buildOverviewContent();
      case 'Custom Charts':
        return _buildCustomChartsContent();
      case 'Alert Log':
        return _buildAlertLogContent();
      case 'Alert Management':
        return _buildAlertManagementContent();
      case 'User Feedback':
        return _buildUserFeedbackContent();
      default:
        return _buildDefaultContent();
    }
  }

  Widget _buildDefaultContent() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.dashboard,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'Welcome to Dashboard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Select a menu item to get started',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewContent() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overview',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'All Apps',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'PM',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Crashes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Crash Rate',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: _buildBarChart(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    return CustomPaint(
      painter: BarChartPainter(),
      size: const Size(double.infinity, double.infinity),
    );
  }

  Widget _buildCustomChartsContent() {
    return const Center(
      child: Text(
        'Custom Charts Content',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Widget _buildAlertLogContent() {
    return const Center(
      child: Text(
        'Alert Log Content',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Widget _buildAlertManagementContent() {
    return const Center(
      child: Text(
        'Alert Management Content',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Widget _buildUserFeedbackContent() {
    return const Center(
      child: Text(
        'User Feedback Content',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SidebarWidget(
            selectedItem: selectedMenuItem,
            onItemSelected: _onMenuItemSelected,
          ),
          Expanded(
            child: Container(
              color: Colors.grey[50],
              child: _buildContent(),
            ),
          ),
        ],
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    final barWidth = size.width / 8;
    final maxHeight = size.height * 0.8;
    
    // Draw Y-axis labels
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    
    for (int i = 0; i <= 4; i++) {
      final y = size.height - (i * size.height / 4);
      final percentage = i * 50;
      
      textPainter.text = TextSpan(
        text: '$percentage%',
        style: const TextStyle(
          fontSize: 10,
          color: Colors.grey,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0, y - textPainter.height / 2));
    }

    // Draw bars
    final barHeights = [0.3, 0.6, 0.4, 0.8, 0.5, 0.7, 0.2];
    for (int i = 0; i < barHeights.length; i++) {
      final x = (i + 1) * barWidth;
      final height = barHeights[i] * maxHeight;
      final y = size.height - height;
      
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, barWidth * 0.6, height),
          const Radius.circular(2),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
