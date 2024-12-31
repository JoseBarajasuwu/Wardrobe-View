import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lista de URLs de imágenes para los carruseles
    final carouselItems = [
      [
        'https://i.imgur.com/5CBQCl4.jpeg', // Imagen 1
        'https://i.imgur.com/XEVE42J.jpeg', // Imagen 2
        'https://i.imgur.com/ihUAX1n.jpeg', // Imagen 3
      ],
      [
        'https://i.imgur.com/5CBQCl4.jpeg', // Imagen 4
        'https://i.imgur.com/XEVE42J.jpeg', // Imagen 5
        'https://i.imgur.com/ihUAX1n.jpeg', // Imagen 6
      ],
      [
        'https://i.imgur.com/5CBQCl4.jpeg', // Imagen 7
        'https://i.imgur.com/XEVE42J.jpeg', // Imagen 8
        'https://i.imgur.com/ihUAX1n.jpeg', // Imagen 9
      ],
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Carruseles en una columna')),
      body: ListView.builder(
        itemCount: 3, // Tres carruseles
        itemBuilder: (context, index) {
          return CarouselWidget(
            carouselItems: carouselItems[index],
          );
        },
      ),
    );
  }
}

class CarouselWidget extends StatefulWidget {
  final List<String> carouselItems;

  CarouselWidget({required this.carouselItems});

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int carouselIndex = 0; // Estado local para el índice del carrusel

  @override
  Widget build(BuildContext context) {
    // Obtener la altura de la pantalla
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Mostrar la imagen actual del carrusel con animación fluida
          Container(
            width: double.infinity,
            height:
                screenHeight * 0.5, // La imagen ocupa la mitad de la pantalla
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500), // Duración de la animación
              child: Image.network(
                widget.carouselItems[carouselIndex],
                key: ValueKey<String>(widget.carouselItems[carouselIndex]),
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error);
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          // Botones para cambiar el índice del carrusel
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_left),
                onPressed: () {
                  // Cambiar al índice anterior
                  setState(() {
                    carouselIndex =
                        (carouselIndex - 1 + widget.carouselItems.length) %
                            widget.carouselItems.length;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_right),
                onPressed: () {
                  // Cambiar al siguiente índice
                  setState(() {
                    carouselIndex =
                        (carouselIndex + 1) % widget.carouselItems.length;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
