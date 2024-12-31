import 'package:flutter_riverpod/flutter_riverpod.dart';

// Proveedor para manejar el estado de carga
final isLoadingProvider = StateProvider<bool>((ref) => false);
// Proveedor para manejar la visibilidad de la contraseña
final passwordVisibilityProvider = StateProvider<bool>((ref) => false);
