import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/rate_controller.dart';

class RatePage extends StatelessWidget {
  final controller = Get.put(RateController());
  RatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NEC'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.rates.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: DataTable(
                    columnSpacing: 30,
                    columns: const [
                      DataColumn(
                          label: Text('Country',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Rate (per 1 Euro)',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                    ],
                    rows: controller.rates.map((item) {
                      return DataRow(cells: [
                        DataCell(Text(item['country'].toString(),
                            style: const TextStyle(fontSize: 16))),
                        DataCell(Text(item['rate'].toString(),
                            style: const TextStyle(fontSize: 16))),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          );
        });
      }),
    );
  }
}
