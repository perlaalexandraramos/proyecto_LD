
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto/widgets/custom_textfield.dart';

class PantallaLogin extends StatelessWidget {
  const PantallaLogin ({super.key});

  @override
  Widget build(BuildContext context) {

    final correoController = TextEditingController();
    final contraController = TextEditingController();

    final box = GetStorage();

    void iniciarSesion () {
      final correoIngresado = correoController.text.trim();
      final contraIngresado = contraController.text.trim();


      final correoGuardado = box.read('correo');
      final contraGuardada = box.read('contra');

       if (correoIngresado == correoGuardado &&
          contraIngresado == contraGuardada) {
        Navigator.pushReplacementNamed(context, '/inicio');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciales incorrectas')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text ("Iniciar Sesion",
          style: TextStyle(
          color: Colors.white,
          fontSize: 23,
          fontWeight: FontWeight.bold,
      ),
        textAlign: TextAlign.center,
      ),
      ),

      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(50.0),
        child: Column(
          children: [

           SizedBox(height: 50),
           Icon(Icons.vpn_key, size: 100, color: Colors.blueGrey,),
            SizedBox(height: 100),

            CustomTextfield(texto: "Correo", controller: correoController),
            const SizedBox(height: 18),

            CustomTextfield(texto: "Contraseña", isPassword: true, controller: contraController),
            const SizedBox(height: 80),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  backgroundColor: Colors.black),
              onPressed: iniciarSesion, 
              child: const Text("Ingresar", style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
              ),
              ),
              
              TextButton(
                onPressed: ()=> Navigator.pushNamed(context, '/registro'), 
                child: const Text("¿No tienes una cuenta? Registrate"))
          ],
          

        ),),
      ),
    );
  }
}