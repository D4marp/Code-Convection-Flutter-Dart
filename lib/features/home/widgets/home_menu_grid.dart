import 'package:flutter/material.dart';
import '../../../shared/widgets/enhanced_menu_card.dart';

/// Menu grid component untuk home screen
class HomeMenuGrid extends StatelessWidget {
  const HomeMenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.1,
      children: [
        EnhancedMenuCard(
          icon: Icons.person,
          title: 'Profile',
          subtitle: 'Kelola profil Anda',
          gradient: const LinearGradient(
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
          onTap: () => Navigator.pushNamed(context, '/profile'),
        ),
        EnhancedMenuCard(
          icon: Icons.settings,
          title: 'Settings',
          subtitle: 'Pengaturan aplikasi',
          gradient: const LinearGradient(
            colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
          ),
          onTap: () => Navigator.pushNamed(context, '/settings'),
        ),
        EnhancedMenuCard(
          icon: Icons.notifications,
          title: 'Notifications',
          subtitle: 'Lihat notifikasi',
          gradient: const LinearGradient(
            colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
          ),
          onTap: () => Navigator.pushNamed(context, '/notifications'),
        ),
        EnhancedMenuCard(
          icon: Icons.help,
          title: 'Help',
          subtitle: 'Bantuan & FAQ',
          gradient: const LinearGradient(
            colors: [Color(0xFFa8edea), Color(0xFFfed6e3)],
          ),
          onTap: () => Navigator.pushNamed(context, '/help'),
        ),
      ],
    );
  }
}