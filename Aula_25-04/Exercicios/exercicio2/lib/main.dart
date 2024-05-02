import 'package:flutter/material.dart';

void main() {
  runApp(const CalcularAreaQuadrado());
}

class CalcularAreaQuadrado extends StatelessWidget {
  const CalcularAreaQuadrado({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cálculo de Área do Quadrado',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AreaQuadradoScreen(),
    );
  }
}

class AreaQuadradoScreen extends StatefulWidget {
  const AreaQuadradoScreen({super.key});

  @override
  AreaQuadradoScreenState createState() => AreaQuadradoScreenState();
}

class AreaQuadradoScreenState extends State<AreaQuadradoScreen> {
  final TextEditingController _ladoController = TextEditingController();
  double? _area;

  void _calcularArea() {
    setState(() {
      double lado = double.tryParse(_ladoController.text) ?? 0.0;
      _area = lado * lado; // Fórmula da área do quadrado: lado * lado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cálculo de Área do Quadrado (m²)'),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        backgroundColor: const Color.fromARGB(255, 21, 55, 204),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _ladoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite o lado do quadrado',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularArea,
              child: const Text('Calcular Área'),
            ),
            const SizedBox(height: 20),
            if (_area != null)
              Text(
                'Área do Quadrado: ${_area!.toStringAsFixed(2)} m²',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB( 255, 21, 55, 204)),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ladoController.dispose();
    super.dispose();
  }
}
