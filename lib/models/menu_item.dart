
import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final List<MenuItem> subItems;
  final bool isExpanded;
  final VoidCallback? onTap;

  MenuItem({
    required this.title,
    required this.icon,
    this.subItems = const [],
    this.isExpanded = false,
    this.onTap,
  });

  MenuItem copyWith({
    String? title,
    IconData? icon,
    List<MenuItem>? subItems,
    bool? isExpanded,
    VoidCallback? onTap,
  }) {
    return MenuItem(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      subItems: subItems ?? this.subItems,
      isExpanded: isExpanded ?? this.isExpanded,
      onTap: onTap ?? this.onTap,
    );
  }
}
