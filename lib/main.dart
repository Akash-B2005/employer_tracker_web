import 'dart:async';

import 'package:flutter/material.dart';

import 'models/employee_model.dart';
import 'models/location_history.dart';
import 'services/api_service.dart';
import 'theme/app_theme.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/employee_card.dart';
import 'widgets/history_table.dart';
import 'widgets/map_widget.dart';
import 'widgets/statistics_cards.dart';

void main() {
  runApp(const MyApp());
}

// =====================================================
// APP
// =====================================================

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      themeMode = themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Live Tracker',

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      home: DashboardScreen(
        onToggleTheme: toggleTheme,
        isDarkMode: themeMode == ThemeMode.dark,
      ),
    );
  }
}

// =====================================================
// DASHBOARD
// =====================================================

class DashboardScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const DashboardScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ApiService apiService = ApiService();

  Employee? employee;

  bool isLoading = true;

  String? errorMessage;

  Timer? timer;

  final List<LocationHistory> history = [];

  // =====================================================
  // FETCH LOCATION
  // =====================================================

  Future<void> fetchLocation() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      final result = await apiService.fetchLocation();

      if (!mounted) return;

      setState(() {
        employee = result;

        isLoading = false;

        errorMessage = null;

        history.insert(
          0,
          LocationHistory(
            time: result.time,
            latitude: result.latitude,
            longitude: result.longitude,
            address: result.address,
          ),
        );

        if (history.length > 20) {
          history.removeLast();
        }
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });
    }
  }

  // =====================================================
  // INIT
  // =====================================================

  @override
  void initState() {
    super.initState();

    fetchLocation();

    timer = Timer.periodic(const Duration(seconds: 3), (_) => fetchLocation());
  }

  // =====================================================
  // DISPOSE
  // =====================================================

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    // ---------------------------------------------------
    // LOADING
    // ---------------------------------------------------

    if (isLoading && employee == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),

              SizedBox(height: 20),

              Text("Loading Live Location...", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      );
    }

    // ---------------------------------------------------
    // ERROR
    // ---------------------------------------------------

    if (errorMessage != null && employee == null) {
      return Scaffold(
        body: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(30),

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  const Icon(Icons.cloud_off, color: Colors.red, size: 70),

                  const SizedBox(height: 20),

                  Text(errorMessage!),

                  const SizedBox(height: 20),

                  ElevatedButton.icon(
                    onPressed: fetchLocation,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Retry"),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // ---------------------------------------------------
    // DASHBOARD
    // ---------------------------------------------------

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: fetchLocation,

        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),

          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              // =================================================
              // HEADER
              // =================================================
              DashboardHeader(
                onRefresh: fetchLocation,
                onToggleTheme: widget.onToggleTheme,
                isDarkMode: widget.isDarkMode,
                isLoading: isLoading,
              ),

              const SizedBox(height: 20),

              // =================================================
              // STATISTICS
              // =================================================
              const StatisticsCards(),

              const SizedBox(height: 20),

              // =================================================
              // MAIN CONTENT
              // =================================================
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // EMPLOYEE CARD
                  SizedBox(
                    width: 340,

                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),

                      child: EmployeeCard(
                        key: ValueKey(employee!.time),

                        employee: employee!,
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),

                  // MAP
                  Expanded(
                    child: SizedBox(
                      height: 600,

                      child: MapWidget(
                        latitude: employee!.latitude,

                        longitude: employee!.longitude,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // =================================================
              // HISTORY TABLE
              // =================================================
              SizedBox(
                width: double.infinity,

                child: HistoryTable(history: history),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
