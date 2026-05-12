import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  // State for the toggle
  bool _isThisMonth = true;

  // --- DATA ---
  // Chart Data
  final List<String> _weekDays = ['MON 21', 'TUE 22', 'WED 23', 'THU 24', 'FRI 25', 'SAT 26', 'SUN 27'];

  // Random data simulation (Income, Expense)
  final List<double> _incomeData = [1.8, 2.0, 1.9, 2.1, 2.0, 1.8, 2.2];
  final List<double> _expenseData = [0.8, 0.9, 0.8, 0.9, 0.8, 0.9, 0.9];

  // --- UI BUILD ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F9), // Light background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Toggle Section
              _buildToggleHeader(),
              const SizedBox(height: 16),

              // 2. Weekly Profit Insight Card
              _buildInsightCard(),
              const SizedBox(height: 16),

              // 3. Category List (Scrollable)
              _buildCategoryList(),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET: Toggle Header ---
  Widget _buildToggleHeader() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E9EF), // Greyish container
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // "This Month" Toggle
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isThisMonth = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _isThisMonth ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: _isThisMonth
                      ? [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))]
                      : [],
                ),
                alignment: Alignment.center,
                child: Text(
                  "This Month",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _isThisMonth ? Colors.black : Colors.grey[500],
                  ),
                ),
              ),
            ),
          ),
          // "Last Month" Toggle
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isThisMonth = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: !_isThisMonth ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: !_isThisMonth
                      ? [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))]
                      : [],
                ),
                alignment: Alignment.center,
                child: Text(
                  "Last Month",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: !_isThisMonth ? Colors.black : Colors.grey[500],
                  ),
                ),
              ),
            ),
          ),
          // Calendar Icon Button
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))],
            ),
            child: SvgPicture.asset(
              'assets/icons/calendar.svg', // YOUR SVG HERE
              width: 20,
              height: 20,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET: Insight Card (Chart) ---
  Widget _buildInsightCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Text
          const Text(
            "WEEKLY PROFIT INSIGHT",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey, letterSpacing: 0.5),
          ),
          const SizedBox(height: 8),

          // Amounts Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "\$12,450.00",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _buildLegendDot(color: const Color(0xFF3B82F6)), // Blue
                      const Text(" Income", style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 12),
                      _buildLegendDot(color: const Color(0xFFF59E0B)), // Orange
                      const Text(" Expenses", style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
              // Growth Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.arrow_upward, size: 14, color: const Color(0xFF10B981)),
                    const SizedBox(width: 2),
                    const Text("+12.5%", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF10B981))),
                  ],
                ),
              )
            ],
          ),

          const SizedBox(height: 20),

          // CHART
          SizedBox(
            height: 160,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                maxY: 2.5,
                barTouchData: BarTouchData(enabled: false), // Disable touch if not needed
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        // Map x-axis values to days
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _weekDays[value.toInt()],
                            style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w500),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(7, (index) {
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      // Income Bar (Blue)
                      BarChartRodData(
                        toY: _incomeData[index],
                        color: const Color(0xFF3B82F6),
                        width: 6,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      // Expenses Bar (Orange)
                      BarChartRodData(
                        toY: _expenseData[index],
                        color: const Color(0xFFF59E0B),
                        width: 6,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                    barsSpace: 4, // Space between the two bars
                  );
                }),
              ),
            ),
          ),

          // Navigation Arrows (Optional, purely UI based on image)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_circle_left_outlined),
                Icon(Icons.arrow_circle_right_outlined),
                // SvgPicture.asset('assets/icons/arrow_left.svg', width: 18, color: Colors.grey), // YOUR SVG
                // SvgPicture.asset('assets/icons/arrow_right.svg', width: 18, color: Colors.grey), // YOUR SVG
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendDot({required Color color}) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  // --- WIDGET: Category List ---
  Widget _buildCategoryList() {
    return Column(
      children: [
        _buildCategoryCard(
          title: "Fuel",
          amount: "\$4,820.50",
          subtitle: "38% of total expenses",
          svgAsset: 'assets/icons/fuel.svg',
        ),
        const SizedBox(height: 12),
        _buildCategoryCard(
          title: "Maintenance",
          amount: "\$1,240.00",
          subtitle: "Scheduled & ad-hoc repairs",
          svgAsset: 'assets/icons/maintenance.svg',
        ),
        const SizedBox(height: 12),
        _buildCategoryCard(
          title: "Tolls",
          amount: "\$612.20",
          subtitle: "Electronic pass transponders",
          svgAsset: 'assets/icons/tolls.svg',
        ),
        const SizedBox(height: 12),
        _buildCategoryCard(
          title: "Others",
          amount: "\$850.00",
          subtitle: "Fleet & liability coverage",
          svgAsset: 'assets/icons/others.svg',
        ),
      ],
    );
  }

  // --- WIDGET: Single Category Card ---
  Widget _buildCategoryCard({
    required String title,
    required String amount,
    required String subtitle,
    required String svgAsset,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 5, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          // Icon Container
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              // color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: SvgPicture.asset(
                svgAsset,
                width: 35,
                height: 35,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                    Text(
                      amount,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}