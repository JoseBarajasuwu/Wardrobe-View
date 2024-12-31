import 'package:close_view/core/login/future/login_future.dart';
import 'package:close_view/core/login/provider/login_provider.dart';
import 'package:close_view/presentation/menu/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(isLoadingProvider);

    // Mostrar el indicador de carga si está cargando
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Mostrar la pantalla de inicio de sesión si no está cargando
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Correo'),
            ),
            Consumer(builder: (context, ref, child) {
              final isPasswordVisible = ref.watch(passwordVisibilityProvider);
              return TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      ref.read(passwordVisibilityProvider.notifier).state =
                          !isPasswordVisible;
                    },
                  ),
                ),
                obscureText: !isPasswordVisible,
              );
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                ref.read(isLoadingProvider.notifier).state = true;

                final credentials = {
                  'email': emailController.text,
                  'password': passwordController.text,
                };

                final result =
                    await ref.read(loginProvider(credentials).future);

                ref.read(isLoadingProvider.notifier).state = false;

                if (result) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Correo o contraseña incorrectos")),
                  );
                }
              },
              child: Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
