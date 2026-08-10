import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  final VoidCallback? onRefresh;
  final VoidCallback? onExport;
  final ValueChanged<String>? onSearch;
  final ValueChanged<String?>? onStatusChanged;
  final VoidCallback? onDateFilter;

  final int totalRecords;
  final bool isLoading;

  const ControlButtons({
    super.key,
    this.onRefresh,
    this.onExport,
    this.onSearch,
    this.onStatusChanged,
    this.onDateFilter,
    this.totalRecords = 0,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 15,
      runSpacing: 15,
      children: [
        /// Search
        SizedBox(
          width: 280,
          child: TextField(
            onChanged: onSearch,
            decoration: InputDecoration(
              hintText: "Search employee...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        /// Status Filter
        SizedBox(
          width: 170,
          child: DropdownButtonFormField<String>(
            value: "All",
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            items: const [
              DropdownMenuItem(value: "All", child: Text("All Status")),
              DropdownMenuItem(value: "Online", child: Text("🟢 Online")),
              DropdownMenuItem(value: "Offline", child: Text("🔴 Offline")),
            ],
            onChanged: onStatusChanged,
          ),
        ),

        /// Date Filter
        ElevatedButton.icon(
          onPressed: onDateFilter,
          icon: const Icon(Icons.calendar_month),
          label: const Text("Date"),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.orange.shade50,
            foregroundColor: Colors.orange.shade800,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        /// Refresh
        OutlinedButton.icon(
          onPressed: isLoading ? null : onRefresh,
          icon: isLoading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.refresh),
          label: const Text("Refresh"),
        ),

        /// Export
        ElevatedButton.icon(
          onPressed: onExport,
          icon: const Icon(Icons.download),
          label: const Text("Export"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff2563EB),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        /// Total Records
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.table_rows, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                "$totalRecords Records",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
