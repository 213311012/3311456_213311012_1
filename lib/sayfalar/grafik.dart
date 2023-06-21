// ignore_for_file: sized_box_for_whitespace, use_key_in_widget_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class grafik extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grafikler'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Line Chart',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Container(
                height: 300,
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          const FlSpot(0, 4),
                          const FlSpot(1, 3.5),
                          const FlSpot(2, 4.5),
                          const FlSpot(3, 1),
                          const FlSpot(4, 3),
                          const FlSpot(5, 4),
                          const FlSpot(6, 5),
                        ],
                        isCurved: true,
                      //  colors: [Colors.blue],
                        barWidth: 4,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Bar Chart',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Container(
                height: 300,
                child: BarChart(
                  BarChartData(
                    barGroups: [
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(toY: 8,  color: Colors.blue),
                          BarChartRodData(toY: 10, color: Colors.red),
                          BarChartRodData(toY: 14, color: Colors.green),
                        ],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                    BarChartRodData(toY: 8,  color: Colors.blue),
                          BarChartRodData(toY: 10, color: Colors.red),
                          BarChartRodData(toY: 14, color: Colors.green),
                        ],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                           BarChartRodData(toY: 8,  color: Colors.blue),
                          BarChartRodData(toY: 10, color: Colors.red),
                          BarChartRodData(toY: 14, color: Colors.green),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Pie Chart',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Container(
                height: 300,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: 30,
                        color: Colors.blue,
                      ),
                      PieChartSectionData(
                        value: 20,
                        color: Colors.red,
                      ),
                      PieChartSectionData(
                        value: 50,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
