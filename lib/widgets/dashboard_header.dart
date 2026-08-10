import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardHeader extends StatelessWidget {
  final VoidCallback onRefresh;
  final VoidCallback onToggleTheme;
  final bool isDarkMode;
  final bool isLoading;

  const DashboardHeader({
    super.key,
    required this.onRefresh,
    required this.onToggleTheme,
    required this.isDarkMode,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateFormat('EEE, dd MMM yyyy • hh:mm a').format(DateTime.now());

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 2,
      shadowColor: isDark ? Colors.black54 : Colors.black12,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            // =====================================================
            // LOGO
            // =====================================================
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: const Color(0xff2563EB).withOpacity(.12),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.location_on,
                color: Color(0xff2563EB),
                size: 30,
              ),
            ),

            const SizedBox(width: 18),

            // =====================================================
            // TITLE
            // =====================================================
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Employee Live Tracker",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    now,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface.withOpacity(.6),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            // =====================================================
            // SEARCH
            // =====================================================
            SizedBox(
              width: 320,
              child: TextField(
                style: TextStyle(color: theme.colorScheme.onSurface),

                decoration: InputDecoration(
                  hintText: "Search employee...",

                  hintStyle: TextStyle(
                    color: theme.colorScheme.onSurface.withOpacity(.5),
                  ),

                  prefixIcon: Icon(
                    Icons.search,
                    color: theme.colorScheme.onSurface.withOpacity(.6),
                  ),

                  filled: true,

                  fillColor: isDark
                      ? const Color(0xff334155)
                      : Colors.grey.shade100,

                  contentPadding: const EdgeInsets.symmetric(vertical: 14),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 20),

            // =====================================================
            // NOTIFICATION
            // =====================================================
            Stack(
              children: [
                IconButton(
                  tooltip: "Notifications",

                  icon: Icon(
                    Icons.notifications_none,
                    color: theme.colorScheme.onSurface,
                  ),

                  iconSize: 28,

                  onPressed: () {},
                ),

                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),

            // =====================================================
            // REFRESH
            // =====================================================
            IconButton(
              tooltip: isLoading ? "Refreshing..." : "Refresh",

              onPressed: isLoading ? null : onRefresh,

              icon: isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.refresh),
            ),

            // =====================================================
            // DARK / LIGHT MODE
            // =====================================================
            IconButton(
              tooltip: isDarkMode
                  ? "Switch to Light Mode"
                  : "Switch to Dark Mode",

              onPressed: onToggleTheme,

              icon: Icon(
                isDarkMode ? Icons.light_mode : Icons.dark_mode_outlined,
              ),
            ),

            // =====================================================
            // SETTINGS
            // =====================================================
            IconButton(
              icon: const Icon(Icons.settings_outlined),

              tooltip: "Settings",

              onPressed: () {},
            ),

            const SizedBox(width: 15),

            // =====================================================
            // ADMIN PROFILE
            // =====================================================
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

              decoration: BoxDecoration(
                color: isDark ? const Color(0xff334155) : Colors.grey.shade100,

                borderRadius: BorderRadius.circular(14),
              ),

              child: Row(
                children: [
                  // Profile
                  const CircleAvatar(
                    radius: 22,

                    backgroundColor: Color(0xff2563EB),

                    child: Icon(Icons.person, color: Colors.white),
                  ),

                  const SizedBox(width: 12),

                  // Admin information
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        "Admin",

                        style: TextStyle(
                          fontWeight: FontWeight.bold,

                          fontSize: 15,

                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      Text(
                        "Administrator",

                        style: TextStyle(
                          color: theme.colorScheme.onSurface.withOpacity(.6),

                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 8),

                  Icon(
                    Icons.keyboard_arrow_down,

                    color: theme.colorScheme.onSurface.withOpacity(.6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
