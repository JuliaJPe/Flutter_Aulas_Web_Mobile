import 'package:flutter/material.dart';

void main() {
  runApp(const MostrarAnteriorPosterior());
}

class MostrarAnteriorPosterior extends StatelessWidget {
  const MostrarAnteriorPosterior({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anterior e Posterior',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AnteriorPosteriorScreen(),
    );
  }
}

class AnteriorPosteriorScreen extends StatefulWidget {
  const AnteriorPosteriorScreen({super.key});

  @override
  AnteriorPosteriorScreenState createState() => AnteriorPosteriorScreenState();
}

class AnteriorPosteriorScreenState extends State<AnteriorPosteriorScreen> {
  final TextEditingController _numeroController = TextEditingController();
  int? _numeroDigitado;
  int? _anterior;
  int? _posterior;

  void _calcularAnteriorPosterior() {
    setState(() {
      _numeroDigitado = int.tryParse(_numeroController.text);
      if (_numeroDigitado != null) {
        _anterior = _numeroDigitado! - 1;
        _posterior = _numeroDigitado! + 1;
      } else {
        _anterior = null;
        _posterior = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anterior e Posterior'),
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
              controller: _numeroController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite um número',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularAnteriorPosterior,
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 20),
            if (_numeroDigitado != null)
              Text(
                'Número Digitado: $_numeroDigitado\n'
                'Anterior: ${_anterior ?? 'Indefinido'}\n'
                'Posterior: ${_posterior ?? 'Indefinido'}',
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
    _numeroController.dispose();
    super.dispose();
  }
}
