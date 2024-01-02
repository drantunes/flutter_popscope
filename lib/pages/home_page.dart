import 'package:flutter/material.dart';
import 'package:flutter_popscope/pages/form_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: FilledButton.tonal(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const FormPage(),
            ),
          ),
          child: const Text('Página c/ Form'),
        ),
      ),
    );
  }
}
