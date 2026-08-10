import 'package:flutter/material.dart';

class StatisticsCards extends StatelessWidget {
  const StatisticsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: StatCard(
            title: "Online",
            value: "24",
            icon: Icons.people,
            color: Colors.green,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: StatCard(
            title: "Battery",
            value: "86%",
            icon: Icons.battery_full,
            color: Colors.orange,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: StatCard(
            title: "Speed",
            value: "34 km/h",
            icon: Icons.speed,
            color: Colors.blue,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: StatCard(
            title: "Distance",
            value: "125 km",
            icon: Icons.route,
            color: Colors.purple,
          ),
        ),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(title, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
