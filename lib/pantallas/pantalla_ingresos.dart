import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import 'package:proyecto/controladores/transaction_controller.dart';
import 'package:intl/intl.dart';

class PantallaIngresos extends StatefulWidget {
  const PantallaIngresos({super.key});

  @override
  State<PantallaIngresos> createState() => _PantallaIngresosState();
}

class _PantallaIngresosState extends State<PantallaIngresos> {
  final TransactionController transactionController = Get.find();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController montoController = TextEditingController();

  DateTime? selectedDate;
  String tipoTransaccion = "Ingreso";

  final Map<String, List<String>> categoriasPorTipo = {
    "Ingreso": ["Salario", "Venta", "Regalo", "Otro"],
    "Egreso": ["Alimentos", "Transporte", "Entretenimiento", 
                "Servicios","Vivienda", "Mascotas","Otro"],
  };

  String? categoriaSeleccionada;

  void _elegirFecha() async {
    DateTime now = DateTime.now();
    DateTime? fechaTomada = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (fechaTomada != null) {
      setState(() {
        selectedDate = fechaTomada;
      });
    }
  }

  void _guardarTransaccion() {
    if (_formKey.currentState!.validate() && selectedDate != null && categoriaSeleccionada != null) {
      transactionController.agregarTransaccion(
        monto: double.parse(montoController.text), 
        categoria: categoriaSeleccionada!, 
        fecha: selectedDate!, 
        tipo: tipoTransaccion,
      );

      Get.snackbar(
        "${tipoTransaccion} agregado",
        "Tu ${tipoTransaccion.toLowerCase()} se registró correctamente",
        snackPosition: SnackPosition.BOTTOM,
      );

      _formKey.currentState!.reset();
      setState(() {
        selectedDate = null;
        tipoTransaccion = "Ingreso"; 
        categoriaSeleccionada = categoriasPorTipo[tipoTransaccion]!.first;
      
      });
    } else {
      Get.snackbar(
        "Error",
        "Por favor llena todos los campos",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    categoriaSeleccionada = categoriasPorTipo[tipoTransaccion]!.first;
  }

  @override
  Widget build(BuildContext context) {
    final titulo = tipoTransaccion == "Ingreso" ? "Registrar Ingreso" : "Registrar Gasto";

    if (!categoriasPorTipo[tipoTransaccion]!.contains(categoriaSeleccionada)) {
  categoriaSeleccionada = categoriasPorTipo[tipoTransaccion]!.first;
      }   

    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        backgroundColor: const Color.fromARGB(255, 245, 231, 105),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: const Text("Ingreso",style: TextStyle(fontSize: 18.0)),
                    selected: tipoTransaccion == "Ingreso",
                    onSelected: (seleccionado) {
                      if (seleccionado) {
                        setState(() {
                          tipoTransaccion = "Ingreso";
                          categoriaSeleccionada = categoriasPorTipo[tipoTransaccion]!.first;
                        });
                      }
                    },
                    selectedColor: Colors.green,
                    labelStyle: TextStyle(
                      color: tipoTransaccion == "Ingreso" ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 15),
                  ChoiceChip(
                    label: const Text("Gasto",style: TextStyle(fontSize: 18.0),),
                    selected: tipoTransaccion == "Egreso",
                    onSelected: (seleccionado) {
                      if (seleccionado) {
                        setState(() {
                          tipoTransaccion = "Egreso";
                          categoriaSeleccionada = categoriasPorTipo[tipoTransaccion]!.first;
                        });
                      }
                    },
                    selectedColor: Colors.red,
                    labelStyle: TextStyle(
                      color: tipoTransaccion == "Egreso" ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              TextFormField(
                controller: montoController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: "Monto",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingresa el monto";
                  }
                  if (double.tryParse(value) == null) {
                    return "Monto inválido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: categoriaSeleccionada,
                items: (categoriasPorTipo[tipoTransaccion]??[])
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
                onChanged: (valor) {
                  setState(() {
                    categoriaSeleccionada = valor;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Categoría",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? "Selecciona una categoría" : null,
              ),
              const SizedBox(height: 50),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedDate == null
                          ? "No hay fecha seleccionada"
                          : "Fecha: ${DateFormat('dd/MM/yyyy').format(selectedDate!)}",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _elegirFecha,
                    child: const Text("Seleccionar fecha"),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _guardarTransaccion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: tipoTransaccion == "Ingreso" ? Colors.green : Colors.red,
                  minimumSize: const Size(69, 50),
                ),
                child: Text(tipoTransaccion == "Ingreso" ? "Guardar Ingreso" : "Guardar Gasto", 
                style: TextStyle(fontSize: 20.0, color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
