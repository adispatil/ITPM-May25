import 'package:flutter/material.dart';
import '../../models/menu_item.dart';

class SidebarWidget extends StatefulWidget {
  final List<MenuItem> menuItems;
  final String? selectedItem;
  final Function(String)? onItemSelected;

  const SidebarWidget({
    super.key,
    required this.menuItems,
    this.selectedItem,
    this.onItemSelected,
  });

  @override
  State<SidebarWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  late List<MenuItem> _menuItems;

  @override
  void initState() {
    super.initState();
    _menuItems = List.from(widget.menuItems);
  }

  void _toggleExpansion(int index) {
    setState(() {
      _menuItems[index] = _menuItems[index].copyWith(
        isExpanded: !_menuItems[index].isExpanded,
      );
    });
  }

  void _selectItem(String title) {
    widget.onItemSelected?.call(title);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: Colors.white,
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text(
                      'S',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Persistent',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Menu Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                return _buildMenuItem(_menuItems[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(MenuItem item, int index) {
    final isSelected = widget.selectedItem == item.title;
    final hasSubItems = item.subItems.isNotEmpty;

    return Column(
      children: [
        // Main menu item
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                if (hasSubItems) {
                  _toggleExpansion(index);
                } else {
                  _selectItem(item.title);
                  item.onTap?.call();
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.orange.withValues(alpha: 0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: isSelected
                      ? Border.all(color: Colors.orange, width: 1)
                      : null,
                ),
                child: Row(
                  children: [
                    Icon(
                      item.icon,
                      size: 20,
                      color: isSelected ? Colors.orange : Colors.grey[600],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected ? Colors.orange : Colors.grey[800],
                        ),
                      ),
                    ),
                    if (hasSubItems)
                      Icon(
                        item.isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        size: 20,
                        color: Colors.grey[600],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Submenu items with tree view structure
        if (hasSubItems && item.isExpanded)
          Container(
            margin: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF5F1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFFFEADE), width: 1),
            ),
            child: Stack(
              children: [
                // Continuous vertical line for the entire tree
                Positioned(
                  left: 26,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 0.6,
                    color: Color(0xFFFD7F39),
                  ),
                ),
                Column(
                  children: item.subItems.asMap().entries.map((entry) {
                    final subIndex = entry.key;
                    final subItem = entry.value;
                    final isSubSelected = widget.selectedItem == subItem.title;
                    final isLast = subIndex == item.subItems.length - 1;
                    
                    return Column(
                      children: [
                        // Submenu item
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(6),
                              onTap: () {
                                _selectItem(subItem.title);
                                subItem.onTap?.call();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: null,
                                child: Row(
                                  children: [
                                    // Tree line indicator
                                    SizedBox(
                                      width: 12,
                                      height: 12,
                                      child: CustomPaint(
                                        painter: TreeIndicatorPainter(isLast: isLast),
                                        size: const Size(12, 12),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        subItem.title,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: isSubSelected ? FontWeight.bold : FontWeight.normal,
                                          color: isSubSelected ? const Color(0xFFFD7F39) : const Color(0xFF757575),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
      ],
    );
  }
}



class TreeIndicatorPainter extends CustomPainter {
  final bool isLast;

  TreeIndicatorPainter({required this.isLast});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFFD7F39)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Create a simple L-shaped path with rounded corners
    // final path = Path();

    final path = Path()
      ..moveTo(-0.4, 0) // start at the top
      ..arcToPoint(
        Offset(size.width - 4, size.height - 4), // land near the label baseline
        radius: Radius.circular(6), // smooth quarter-round
        clockwise: false,
      )
      ..lineTo(size.width - 4, size.height - 4); // tiny tail into the label

    // Draw the path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
