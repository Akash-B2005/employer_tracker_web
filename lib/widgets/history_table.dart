import 'package:flutter/material.dart';
import '../models/location_history.dart';

class HistoryTable extends StatelessWidget {
  final List<LocationHistory> history;

  const HistoryTable({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              children: [
                const Text(
                  "Location History",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const Spacer(),

                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.refresh),
                  label: const Text("Refresh"),
                ),

                const SizedBox(width: 10),

                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download),
                  label: const Text("Export"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: SingleChildScrollView(
                  child: DataTable(
                    columnSpacing: 50,
                    horizontalMargin: 24,
                    headingRowHeight: 60,
                    dataRowMinHeight: 60,
                    dataRowMaxHeight: 65,
                    dividerThickness: 1,

                    headingRowColor: WidgetStateProperty.all(
                      const Color(0xffEEF4FF),
                    ),

                    columns: const [
                      DataColumn(
                        label: Text(
                          "Time",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      DataColumn(
                        label: Text(
                          "Location",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      DataColumn(
                        label: Text(
                          "Latitude",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      DataColumn(
                        label: Text(
                          "Longitude",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      DataColumn(
                        label: Text(
                          "Status",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],

                    rows: List.generate(history.length, (index) {
                      final item = history[index];

                      return DataRow(
                        color: WidgetStateProperty.resolveWith((states) {
                          if (index.isEven) {
                            return Colors.grey.shade50;
                          }
                          return Colors.white;
                        }),
                        cells: [
                          DataCell(Text(item.time)),

                          DataCell(
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 18,
                                ),

                                const SizedBox(width: 8),

                                Text(item.address),
                              ],
                            ),
                          ),

                          DataCell(Text(item.latitude.toStringAsFixed(6))),

                          DataCell(Text(item.longitude.toStringAsFixed(6))),

                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                "Online",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
