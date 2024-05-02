import 'package:flutter/material.dart';

void main() {
  runApp(const CalculaAreaTriangulo());
}

class CalculaAreaTriangulo extends StatelessWidget {
  const CalculaAreaTriangulo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cálculo de Área do Retângulo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AreaTrianguloScreen(),
    );
  }
}

class AreaTrianguloScreen extends StatefulWidget {
  const AreaTrianguloScreen({super.key});

  @override
  AreaTrianguloScreenState createState() => AreaTrianguloScreenState();
}

class AreaTrianguloScreenState extends State<AreaTrianguloScreen> {
  final TextEditingController _baseController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  double? _area;

  void _calcularArea() {
    setState(() {
      double base = double.tryParse(_baseController.text) ?? 0.0;
      double altura = double.tryParse(_alturaController.text) ?? 0.0;
      _area = base * altura / 2; // Fórmula da área do triangulo: base * altura / 2
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cálculo de Área do Triângulo (m²)'),
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
              controller: _baseController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite a base do triângulo',
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite a altura do triângulo',
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
                'Área do Triângulo: ${_area!.toStringAsFixed(2)} m²',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 21, 55, 204)),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _baseController.dispose();
    _alturaController.dispose();
    super.dispose();
  }
}
