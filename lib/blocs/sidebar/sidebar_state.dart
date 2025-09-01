import 'package:equatable/equatable.dart';
import '../../models/menu_item.dart';

abstract class SidebarState extends Equatable {
  const SidebarState();

  @override
  List<Object?> get props => [];
}

class SidebarInitial extends SidebarState {}

class SidebarLoading extends SidebarState {}

class SidebarLoaded extends SidebarState {
  final List<MenuItem> menuItems;
  final int? selectedMenuIndex;
  final int? selectedSubItemIndex;

  const SidebarLoaded({
    required this.menuItems,
    this.selectedMenuIndex,
    this.selectedSubItemIndex,
  });

  SidebarLoaded copyWith({
    List<MenuItem>? menuItems,
    int? selectedMenuIndex,
    int? selectedSubItemIndex,
  }) {
    return SidebarLoaded(
      menuItems: menuItems ?? this.menuItems,
      selectedMenuIndex: selectedMenuIndex ?? this.selectedMenuIndex,
      selectedSubItemIndex: selectedSubItemIndex ?? this.selectedSubItemIndex,
    );
  }

  @override
  List<Object?> get props => [menuItems, selectedMenuIndex, selectedSubItemIndex];
}

class SidebarError extends SidebarState {
  final String message;

  const SidebarError(this.message);

  @override
  List<Object?> get props => [message];
}
