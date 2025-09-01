import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/menu_item.dart';
import 'sidebar_state.dart';

class SidebarCubit extends Cubit<SidebarState> {
  SidebarCubit() : super(SidebarInitial());

  void initializeSidebar(List<MenuItem> initialMenuItems) {
    emit(SidebarLoaded(
      menuItems: initialMenuItems,
      selectedMenuIndex: null,
      selectedSubItemIndex: null,
    ));
  }

  void toggleMenuExpansion(int menuIndex) {
    if (state is SidebarLoaded) {
      final currentState = state as SidebarLoaded;
      final updatedMenuItems = List<MenuItem>.from(currentState.menuItems);
      
      // Toggle the expansion state of the specified menu
      final menuItem = updatedMenuItems[menuIndex];
      updatedMenuItems[menuIndex] = menuItem.copyWith(
        isExpanded: !menuItem.isExpanded,
      );

      emit(currentState.copyWith(menuItems: updatedMenuItems));
    }
  }

  void selectSubMenuItem(int menuIndex, int subItemIndex) {
    if (state is SidebarLoaded) {
      final currentState = state as SidebarLoaded;
      
      emit(currentState.copyWith(
        selectedMenuIndex: menuIndex,
        selectedSubItemIndex: subItemIndex,
      ));
    }
  }
}
