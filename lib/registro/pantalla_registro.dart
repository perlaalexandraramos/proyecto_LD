import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto/widgets/custom_textfield.dart';

class PantallaRegistro extends StatelessWidget {
  const PantallaRegistro ({super.key});


  @override
  Widget build(BuildContext context) {

    final nombreController = TextEditingController();
    final telefonoController = TextEditingController();
    final correoController = TextEditingController();
    final contraController = TextEditingController();

    
    final box = GetStorage();

    Future<void> validarYGuardar() async {
      final nombre = nombreController.text.trim();
      final telefono = telefonoController.text.trim();
      final correo = correoController.text.trim();
      final contra = contraController.text.trim();


      if (nombre.isEmpty || correo.isEmpty || telefono.isEmpty || contra.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Todos los campos son obligatorios')),
        );
        return;
      }

  
      if (!correo.endsWith('@unah.hn')) {
        _mostrarError(context, 'El correo debe ser institucional (@unah.hn)');
        return;
      }

      if (contra.length < 6 || !contra.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
        _mostrarError(context, 'La contraseña debe tener al menos 6 caracteres y un carácter especial.');
        return;
      }

      box.write('nombre', nombre);
      box.write('telefono', telefono);
      box.write('correo', correo);
      box.write('contra', contra);
    

      Navigator.pushReplacementNamed(context, '/login');
    }

    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text ("Registrarse",
          style: TextStyle(
          color: Colors.white,
          fontSize: 23,
          fontWeight: FontWeight.bold,
      ),
        textAlign: TextAlign.center,
      ),
    ),


      body: SingleChildScrollView(
        child: Padding(
          
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
                Container(
                  color: Colors.blue,
                ),
  
              SizedBox(height: 50),
              Icon(Icons.app_registration, size: 100, color: Colors.blueGrey,),
             SizedBox(height: 80),


              CustomTextfield(texto: "Nombre", controller: nombreController),
              const  SizedBox(height: 15),
              CustomTextfield(texto: "Correo", controller: correoController),
              const SizedBox(height: 15),  
              CustomTextfield(texto: "Telefono", controller: telefonoController),
              const  SizedBox(height: 15),
              CustomTextfield(texto: "Contraseña", isPassword: true, controller: contraController),
              const SizedBox(height: 20),

              ElevatedButton
              (style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  backgroundColor: Colors.black),
                  
                onPressed: validarYGuardar, 
                child: const Text("Registrarse", 
                    style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                   fontWeight: FontWeight.bold
                ),
                ), 
                ),  

                 TextButton(
                onPressed: ()=> Navigator.pushNamed(context, '/login'), 
                child: const Text("¿Ya tienes cuenta? Inicia Sesion"))
            ],
            
          ),
        ),

      )
    );
  }
  
  void _mostrarError(BuildContext context, String mensaje) {
        showDialog(context: context, 
        builder: (_) => AlertDialog(
            title: const Text("Error"),
            content: Text(mensaje),
            actions: [
              TextButton(onPressed: ()=> Navigator.pop(context), 
              child: const Text("Cerrar"))
            ],
        ), 
        );

    }
}