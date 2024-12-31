import 'package:flutter_riverpod/flutter_riverpod.dart';

// Proveedor para manejar el inicio de sesión
final loginProvider =
    FutureProvider.family<bool, Map<String, String>>((ref, credentials) async {
  await Future.delayed(Duration(seconds: 2)); // Simula una operación de red
  final email = credentials['email'];
  final password = credentials['password'];

  // Simula la validación de credenciales
  return email == "1" && password == "1";
});
