import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:proyecto/controladores/transaction_controller.dart';

class PantallaGraficos extends StatefulWidget {
  const PantallaGraficos({super.key});

  @override
  State<PantallaGraficos> createState() => _PantallaGraficosState();
}

class _PantallaGraficosState extends State<PantallaGraficos> {
  final TransactionController transactionController = Get.find();
  String? mesSeleccionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estadísticas')),
      body: Obx(() {
        final transacciones = transactionController.transacciones;

        if (transacciones.isEmpty) {
          return const Center(child: Text("No hay datos para mostrar."));
        }

       
        final meses = transacciones
            .map((t) => DateFormat('MM/yyyy').format(DateTime.parse(t['fecha'])))
            .toSet()
            .toList()
          ..sort((a, b) => DateFormat('MM/yyyy').parse(a)
              .compareTo(DateFormat('MM/yyyy').parse(b)));

        
        mesSeleccionado ??= meses.isNotEmpty ? meses.last : null;

       
        final ingresosPorMesYCategoria = <String, Map<String, double>>{};
        final gastosPorMesYCategoria = <String, Map<String, double>>{};

        for (var t in transacciones) {
          final fecha = DateTime.parse(t['fecha']);
          final mesKey = DateFormat('MM/yyyy').format(fecha);
          final categoria = t['categoria'] ?? 'Otro';
          final monto = t['monto'] as double;

          if (t['tipo'] == "Ingreso") {
            ingresosPorMesYCategoria[mesKey] ??= {};
            ingresosPorMesYCategoria[mesKey]![categoria] =
                (ingresosPorMesYCategoria[mesKey]![categoria] ?? 0) + monto;
          } else {
            gastosPorMesYCategoria[mesKey] ??= {};
            gastosPorMesYCategoria[mesKey]![categoria] =
                (gastosPorMesYCategoria[mesKey]![categoria] ?? 0) + monto;
          }
        }

        
        final pieData = <String, double>{
          ...ingresosPorMesYCategoria[mesSeleccionado] ?? {},
          ...gastosPorMesYCategoria[mesSeleccionado] ?? {},
        };

        final pieSections = pieData.entries.map((entry) {
          final color = Colors.primaries[
              pieData.keys.toList().indexOf(entry.key) % Colors.primaries.length];
          return PieChartSectionData(
            color: color,
            value: entry.value,
            title: "${entry.key}\n${entry.value.toStringAsFixed(0)}",
            radius: 60,
            titleStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          );
        }).toList();

       
        final ingresosPorMesTotal = <String, double>{};
        final egresosPorMesTotal = <String, double>{};

        for (var t in transacciones) {
          final fecha = DateTime.parse(t['fecha']);
          final mesKey = DateFormat('MM/yyyy').format(fecha);
          final monto = t['monto'] as double;

          if (t['tipo'] == "Ingreso") {
            ingresosPorMesTotal[mesKey] = (ingresosPorMesTotal[mesKey] ?? 0) + monto;
          } else {
            egresosPorMesTotal[mesKey] = (egresosPorMesTotal[mesKey] ?? 0) + monto;
          }
        }

        final barGroups = meses.map((mes) {
          final ingreso = ingresosPorMesTotal[mes] ?? 0;
          final gasto = egresosPorMesTotal[mes] ?? 0;
          return BarChartGroupData(x: meses.indexOf(mes), barRods: [
            BarChartRodData(toY: ingreso, color: Colors.green, width: 8),
            BarChartRodData(toY: gasto, color: Colors.red, width: 8),
          ]);
        }).toList();

        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Mes: ", style: TextStyle(fontSize: 16)),
                  DropdownButton<String>(
                    value: mesSeleccionado,
                    items: meses
                        .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                        .toList(),
                    onChanged: (valor) {
                      setState(() {
                        mesSeleccionado = valor;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              const Text("Distribución por Categoría",
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
                height: 300,
                child: BarChart(
                  BarChartData(
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 && value.toInt() < meses.length) {
                            return Text(meses[value.toInt()]);
                          }
                          return const Text('');
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