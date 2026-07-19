import 'package:flutter/material.dart';
import '../../app_theme.dart';

/// Enumeration of the 3 different "main" page of the application.
enum NavItem { measure, history, profile }

/// Displays the navigation bar of the application.
class NavBar extends StatelessWidget {
  final NavItem current;

  const NavBar({
    super.key,
    required this.current,
  });

  void _onTap(BuildContext context, NavItem item) {

    switch (item) {
      case NavItem.measure:
        Navigator.pushReplacementNamed(context, '/measure');
        break;
      case NavItem.history:
        Navigator.pushReplacementNamed(context, '/history');
        break;
      case NavItem.profile:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavBarItem(
            icon: Icons.border_color,
            label: "Mesure",
            active: current == NavItem.measure,
            onTap: () => _onTap(context, NavItem.measure),
          ),
          _NavBarItem(
            icon: Icons.history,
            label: "Historique",
            active: current == NavItem.history,
            onTap: () => _onTap(context, NavItem.history),
          ),
          _NavBarItem(
            icon: Icons.person,
            label: "Profil",
            active: current == NavItem.profile,
            onTap: () => _onTap(context, NavItem.profile),
          ),
        ],
      ),
    );
  }
}

/// Display an item inside the navigation bar.
class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color =
    active ? AppColors.forestGreen : AppColors.greyBorder;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: color),
          ),
          if (active)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 40,
              color: color,
            ),
        ],
      ),
    );
  }
}