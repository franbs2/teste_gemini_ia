import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final GenerativeModel gemini;
  final controller = TextEditingController();
  String generatedText = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    gemini = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: 'API_KEY',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Escreva uma receita',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                final content = [Content.text(controller.text)];
                final response = await gemini.generateContent(content);
                setState(() {
                  generatedText = response.text!;
                  isLoading = false;
                });
              },
              child: const Text('Gerar receita'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Resultado',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Text(
                generatedText,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
