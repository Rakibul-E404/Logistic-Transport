/**
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_style.dart';

class MainBottomNav extends StatefulWidget {
  const MainBottomNav({super.key});

  @override
  State<MainBottomNav> createState() => _MainBottomNavState();
}

class _MainBottomNavState extends State<MainBottomNav> {
  int _selectedIndex = 0;

  // Screens list using AppRoute
  late final List<Widget> _screens = [
    AppRoutes.routes[AppRoutes.home]!(context),      // HomeScreen
    AppRoutes.routes[AppRoutes.load]!(context),      // LoadScreen
    AppRoutes.routes[AppRoutes.report]!(context),    // ReportScreen
    AppRoutes.routes[AppRoutes.profile]!(context),   // ProfileScreen
  ];

  // Custom navigation items data
  final List<Map<String, dynamic>> _navItems = [
    {
      'icon': 'assets/icons/home.svg',
      'activeIcon': 'assets/icons/home_select.svg',
      'label': 'Home',
      'route': AppRoutes.home,
    },
    {
      'icon': 'assets/icons/load_light.svg',
      'activeIcon': 'assets/icons/load_light_fill.svg',
      'label': 'Load',
      'route': AppRoutes.load,
    },
    {
      'icon': 'assets/icons/report_light.svg',
      'activeIcon': 'assets/icons/report_light_fill.svg',
      'label': 'Report',
      'route': AppRoutes.report,
    },
    {
      'icon': 'assets/icons/profile_light.svg',
      'activeIcon': 'assets/icons/profile_light_fill.svg',
      'label': 'Profile',
      'route': AppRoutes.profile,
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
        child: Container(
          height: 100.0,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: List.generate(_navItems.length, (index) {
              final item = _navItems[index];
              final isSelected = _selectedIndex == index;

              return Expanded(
                child: GestureDetector(
                  onTap: () => _onItemTapped(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    // decoration: BoxDecoration(
                    //   color: isSelected ? AppColors.redColor : Colors.transparent,
                    //   borderRadius: BorderRadius.circular(6),
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            isSelected ? item['activeIcon'] : item['icon'],
                            width: 23,
                            height: 23,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item['label'],
                            style: AppTextStyle.SFProDisplay_Regular
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}*/







// File: lib/shared/widget/bottom_nav.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tag/feature/home/view/home_screen.dart';
import 'package:tag/feature/load/view/load_screen.dart';
import 'package:tag/feature/report/view/report_screen.dart';
import 'package:tag/feature/profile/view/profile_screen.dart';

import '../../core/constants/app_routes.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0; // Default to Load screen

  // final List<Widget> _screens = [
  //   const HomeScreen(),
  //   const LoadScreen(),
  //   const ReportScreen(),
  //   const ProfileScreen(),
  // ];


  late final List<Widget> _screens = [
    AppRoutes.routes[AppRoutes.home]!(context),      // HomeScreen
    AppRoutes.routes[AppRoutes.load]!(context),      // LoadScreen
    AppRoutes.routes[AppRoutes.report]!(context),    // ReportScreen
    AppRoutes.routes[AppRoutes.profile]!(context),   // ProfileScreen
  ];


  // Navigation items configuration
  final List<NavItem> _navItems = [
    NavItem(
      label: 'Home',
      iconOutline: 'assets/icons/home.svg',
      iconFilled: 'assets/icons/home_select.svg',
    ),
    NavItem(
      label: 'Load',
      iconOutline: 'assets/icons/load.svg',
      iconFilled: 'assets/icons/load_select.svg',
    ),
    NavItem(
      label: 'Report',
      iconOutline: 'assets/icons/report.svg',
      iconFilled: 'assets/icons/report_select.svg',
    ),
    NavItem(
      label: 'Profile',
      iconOutline: 'assets/icons/profile.svg',
      iconFilled: 'assets/icons/profile_select.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_navItems.length, (index) {
          return _buildNavItem(index, _navItems[index]);
        }),
      ),
    );
  }

  Widget _buildNavItem(int index, NavItem item) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E3A5F) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SVG Icon with color change based on selection
            SvgPicture.asset(
              isSelected ? item.iconFilled : item.iconOutline,
              width: 24,
              height: 24,
            ),
            const SizedBox(height: 2),
            Text(
              item.label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF1E3A5F),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Navigation item model
class NavItem {
  final String label;
  final String iconOutline;
  final String iconFilled;

  NavItem({
    required this.label,
    required this.iconOutline,
    required this.iconFilled,
  });
}