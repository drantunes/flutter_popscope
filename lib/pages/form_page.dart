import 'dart:io';

import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _name = TextEditingController();
  bool formSaved = false;

  _save(String text) async {
    if (text.isNotEmpty) {
      setState(() => formSaved = true);
      FocusScope.of(context).unfocus();
    }
  }

  _showAlert() {
    if (!formSaved) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Você tem certeza?'),
            content: const Text(
              'O campo nome ainda não está salvo!',
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Não'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FilledButton(
                child: const Text('Sim, quero sair'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (Platform.isIOS && details.delta.dx > 8) {
          if (!formSaved) {
            _showAlert();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Form Page 1'),
        ),
        body: PopScope(
          canPop: formSaved,
          onPopInvoked: (bool didPop) {
            if (didPop) {
              return;
            }
            _showAlert();
          },
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _name,
                  onChanged: (_) => setState(() => formSaved = false),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Nome'),
                  ),
                ),
                FilledButton(
                  onPressed: () => _save(_name.text),
                  child: const Text('Salvar'),
                ),
                TextButton(
                  onPressed: () => formSaved ? Navigator.of(context).pop() : _showAlert(),
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
