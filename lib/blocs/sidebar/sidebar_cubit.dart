import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/menu_item.dart';
import 'sidebar_state.dart';

class SidebarCubit extends Cubit<SidebarState> {
  SidebarCubit() : super(SidebarInitial());

  void initializeSidebar() {
    final List<MenuItem> menuItems = [
      MenuItem(
        title: 'Dashboard',
        icon: Icons.dashboard,
        isExpanded: true,
        subItems: [
          MenuItem(title: 'Overview', icon: Icons.visibility),
          MenuItem(title: 'Custom Charts', icon: Icons.bar_chart),
          MenuItem(title: 'Alert Log', icon: Icons.warning),
          MenuItem(title: 'Alert Management', icon: Icons.settings),
          MenuItem(title: 'User Feedback', icon: Icons.feedback),
        ],
      ),
      MenuItem(
        title: 'Infrastructure',
        icon: Icons.storage,
        subItems: [
          MenuItem(title: 'Servers', icon: Icons.computer),
          MenuItem(title: 'Networks', icon: Icons.network_check),
          MenuItem(title: 'Storage', icon: Icons.storage),
          MenuItem(title: 'Monitoring', icon: Icons.monitor),
        ],
      ),
      MenuItem(
        title: 'Applications',
        icon: Icons.apps,
        subItems: [
          MenuItem(title: 'Web Apps', icon: Icons.web),
          MenuItem(title: 'Mobile Apps', icon: Icons.phone_android),
          MenuItem(title: 'Desktop Apps', icon: Icons.desktop_windows),
          MenuItem(title: 'APIs', icon: Icons.api),
        ],
      ),
      MenuItem(
        title: 'Security',
        icon: Icons.security,
        subItems: [
          MenuItem(title: 'Access Control', icon: Icons.lock),
          MenuItem(title: 'Audit Logs', icon: Icons.assignment),
          MenuItem(title: 'Threat Detection', icon: Icons.warning_amber),
          MenuItem(title: 'Compliance', icon: Icons.verified_user),
        ],
      ),
      MenuItem(
        title: 'Reports',
        icon: Icons.assessment,
        subItems: [
          MenuItem(title: 'Performance', icon: Icons.speed),
          MenuItem(title: 'Analytics', icon: Icons.analytics),
          MenuItem(title: 'Trends', icon: Icons.trending_up),
          MenuItem(title: 'Export', icon: Icons.file_download),
        ],
      ),
    ];

    emit(SidebarLoaded(
      menuItems: menuItems,
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
