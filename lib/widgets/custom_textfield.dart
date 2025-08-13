import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String texto;
  final bool isPassword;
  final TextEditingController controller;

  const CustomTextfield({
    super.key,
    required this.texto,
    this.isPassword = false,
    required this.controller,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool _ocultarTexto = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _ocultarTexto : false,
      decoration: InputDecoration(
        labelText: widget.texto,
        border: const OutlineInputBorder(),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _ocultarTexto ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _ocultarTexto = !_ocultarTexto;
                  });
                },
              )
            : null,
      ),
    );
  }
}