import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:proyecto/controladores/transaction_controller.dart';

class PantallaGraficos extends StatelessWidget {
  final TransactionController transactionController = Get.find();

  PantallaGraficos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estadísticas')),
      body: Obx(() {
        final transacciones = transactionController.transacciones;
        if (transacciones.isEmpty) {
          return const Center(child: Text("No hay datos para mostrar."));
        }

        // Filtrar solo gastos para el pie chart
        final gastos = transacciones.where((t) => t['tipo'] == "Gasto").toList();

        // Agrupar gastos por categoría
        final Map<String, double> gastosPorCategoria = {};
        for (var t in gastos) {
          gastosPorCategoria[t['categoria']] =
              (gastosPorCategoria[t['categoria']] ?? 0) + t['monto'];
        }

        // Datos para gráfico circular
        final pieSections = gastosPorCategoria.entries.map((entry) {
          final color = Colors.primaries[
              gastosPorCategoria.keys.toList().indexOf(entry.key) %
                  Colors.primaries.length];
          return PieChartSectionData(
            color: color,
            value: entry.value,
            title: "${entry.key}\n${entry.value.toStringAsFixed(0)}",
            radius: 60,
            titleStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          );
        }).toList();

        // Agrupar ingresos y gastos por mes
        final Map<String, double> ingresosPorMes = {};
        final Map<String, double> egresosPorMes = {};
        for (var t in transacciones) {
          final mes = "${DateTime.parse(t['fecha']).month}/${t['fecha'].year}";
          if (t['tipo'] == "Ingreso") {
            ingresosPorMes[mes] = (ingresosPorMes[mes] ?? 0) + t['monto'];
          } else {
            egresosPorMes[mes] = (egresosPorMes[mes] ?? 0) + t['monto'];
          }
        }

        // Lista de meses ordenados
        final meses = {
          ...ingresosPorMes.keys,
          ...egresosPorMes.keys,
        }.toList()
          ..sort((a, b) {
            final am = int.parse(a.split("/")[0]);
            final ay = int.parse(a.split("/")[1]);
            final bm = int.parse(b.split("/")[0]);
            final by = int.parse(b.split("/")[1]);
            return ay == by ? am.compareTo(bm) : ay.compareTo(by);
          });

        final barGroups = meses.map((mes) {
          final ingreso = ingresosPorMes[mes] ?? 0;
          final gasto = egresosPorMes[mes] ?? 0;
          return BarChartGroupData(x: meses.indexOf(mes), barRods: [
            BarChartRodData(toY: ingreso, color: Colors.green, width: 8),
            BarChartRodData(toY: gasto, color: Colors.red, width: 8),
          ]);
        }).toList();

        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text("Distribución de Gastos por Categoría",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 250,
                child: PieChart(PieChartData(
                  sections: pieSections,
                  sectionsSpace: 2,
                  centerSpaceRadius: 30,
                )),
              ),
              const Divider(height: 40),
              const Text("Ingresos vs Gastos por Mes",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 250,
                child: BarChart(BarChartData(
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(meses[value.toInt()]);
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                  ),
                  barGroups: barGroups,
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                )),
              ),
            ],
          ),
        );
      }),
    );
  }
}
