import 'package:flutter/material.dart';
import '../models/employee_model.dart';

class EmployeeCard extends StatefulWidget {
  final Employee employee;

  const EmployeeCard({super.key, required this.employee});

  @override
  State<EmployeeCard> createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard> {
  @override
  Widget build(BuildContext context) {
    final employee = widget.employee;

    final bool isOnline = employee.status.toLowerCase() == "online";

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Employee
            Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.blue.shade100,
                  child: const Icon(Icons.person, color: Colors.blue, size: 34),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        employee.name,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // ONLINE / OFFLINE
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),

                        decoration: BoxDecoration(
                          color: isOnline
                              ? Colors.green.shade100
                              : Colors.red.shade100,

                          borderRadius: BorderRadius.circular(20),
                        ),

                        child: Text(
                          isOnline ? "Online" : "Offline",

                          style: TextStyle(
                            color: isOnline
                                ? Colors.green.shade700
                                : Colors.red.shade700,

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ACTIVE / INACTIVE
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(15),

              decoration: BoxDecoration(
                color: isOnline
                    ? Colors.green.withOpacity(.10)
                    : Colors.red.withOpacity(.10),

                borderRadius: BorderRadius.circular(14),
              ),

              child: Row(
                children: [
                  Icon(
                    isOnline ? Icons.check_circle : Icons.cancel,

                    color: isOnline ? Colors.green : Colors.red,
                  ),

                  const SizedBox(width: 10),

                  Text(
                    isOnline ? "Employee Active" : "Employee Inactive",

                    style: TextStyle(
                      fontWeight: FontWeight.bold,

                      color: isOnline
                          ? Colors.green.shade700
                          : Colors.red.shade700,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Other information
            buildInfoTile(
              context,
              Icons.access_time,
              "Last Updated",
              employee.time,
            ),

            const SizedBox(height: 15),

            buildInfoTile(
              context,
              Icons.location_on,
              "Current Address",
              employee.address,
            ),

            const SizedBox(height: 15),

            buildInfoTile(
              context,
              Icons.speed,
              "Speed",
              "${employee.speed} km/h",
            ),

            const SizedBox(height: 20),

            // CHECK IN / CHECK OUT
            Row(
              children: [
                // CHECK IN
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isOnline ? null : _checkIn,

                    icon: const Icon(Icons.login),

                    label: const Text("Check In"),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,

                      foregroundColor: Colors.white,

                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // CHECK OUT
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isOnline ? _checkOut : null,

                    icon: const Icon(Icons.logout),

                    label: const Text("Check Out"),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,

                      foregroundColor: Colors.white,

                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // CHECK IN
  // =====================================================

  void _checkIn() {
    setState(() {
      widget.employee.status = "Online";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Employee checked in"),
        backgroundColor: Colors.green,
      ),
    );
  }

  // =====================================================
  // CHECK OUT
  // =====================================================

  void _checkOut() {
    setState(() {
      widget.employee.status = "Offline";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Employee checked out"),
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget buildInfoTile(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? const Color(0xff334155)
            : Colors.grey.shade100,

        borderRadius: BorderRadius.circular(14),
      ),

      child: Row(
        children: [
          Icon(icon, color: Colors.blue),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface.withOpacity(.6),
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
