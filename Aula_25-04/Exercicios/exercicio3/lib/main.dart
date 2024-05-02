import 'package:flutter/material.dart';

void main() {
  runApp(const CalcularAreaRetangulo());
}

class CalcularAreaRetangulo extends StatelessWidget {
  const CalcularAreaRetangulo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cálculo de Área do Retângulo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AreaRetanguloScreen(),
    );
  }
}

class AreaRetanguloScreen extends StatefulWidget {
  const AreaRetanguloScreen({super.key});

  @override
  AreaRetanguloScreenState createState() => AreaRetanguloScreenState();
}

class AreaRetanguloScreenState extends State<AreaRetanguloScreen> {
  final TextEditingController _baseController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  double? _area;

  void _calcularArea() {
    setState(() {
      double base = double.tryParse(_baseController.text) ?? 0.0;
      double altura = double.tryParse(_alturaController.text) ?? 0.0;
      _area = base * altura; // Fórmula da área do retângulo: base * altura
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cálculo de Área do Retângulo (m²)'),
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
                labelText: 'Digite a base do retângulo',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite a altura do retângulo',
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
                'Área do Retângulo: ${_area!.toStringAsFixed(2)} m²',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 55, 21, 204)),
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
