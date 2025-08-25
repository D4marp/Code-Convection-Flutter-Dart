import 'package:flutter/material.dart';
import '../../../shared/widgets/stat_card.dart';

/// Stats section component untuk home screen
class HomeStatsSection extends StatelessWidget {
  const HomeStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            icon: Icons.task_alt,
            title: 'Tasks',
            value: '12',
            color: const Color(0xFF4CAF50),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: StatCard(
            icon: Icons.notifications_active,
            title: 'Notifications',
            value: '5',
            color: const Color(0xFFFF9800),
          ),
        ),
      ],
    );
  }
}