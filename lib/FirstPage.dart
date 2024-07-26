import 'package:flutter/material.dart';
import 'package:miniprojeto1/Historico.dart';

class FirstPage extends StatefulWidget {
  final String title;

  const FirstPage({Key? key, required this.title}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();
  String pesos = "";
  String alimentar = "";
  String avaliacaoDias = "";
  String observacoes = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: controller1,
              onChanged: (text) {
                pesos = controller1.text;
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.balance,
                  color: Colors.deepPurpleAccent,
                  size: 25.0,
                ),
                labelText:
                    "Insira o seu peso (com valores até duas casas decimais):",
              ),
            ),
            TextField(
              controller: controller2,
              onChanged: (text) {
                alimentar = controller2.text;
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.apple,
                    color: Colors.deepPurpleAccent, size: 25.0),
                labelText: "Alimentou-se nas últimas 3 horas? (sim/não):",
              ),
            ),
            TextField(
              controller: controller3,
              onChanged: (text) {
                avaliacaoDias = controller3.text;
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.accessibility,
                    color: Colors.deepPurpleAccent, size: 25.0),
                labelText: "Como se sente hoje? (1 a 5):",
              ),
            ),
            TextField(
              controller: controller4,
              onChanged: (text) {
                observacoes = controller4.text;
              },
              maxLength: 200,
              decoration: const InputDecoration(
                prefixIcon:
                    Icon(Icons.abc, color: Colors.deepPurpleAccent, size: 30.0),
                labelText:
                    "Observações (Entre 100 e 200 caracteres - incluindo espaços):",
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              if (peso(pesos) &&
                  alimentacao(alimentar) &&
                  avaliacaoDia(avaliacaoDias) &&
                  observacao(observacoes)) {
                DataSource.getInstance()
                    .insert(pesos, alimentar, avaliacaoDias, observacoes);
                setState((){
                    controller1.clear();
                    controller2.clear();
                    controller3.clear();
                    controller4.clear();
                    (ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('O seu registo foi submetido com sucesso.'),
                      ),
                    ));
                  },
                );
              } else {
                (ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Dados inválidos')),
                ));
              }
            },
            tooltip: 'Enviar',
            child: const Icon(Icons.add_rounded,
                color: Colors.white, size: 30.0, semanticLabel: 'Observações'),
          ),
          const SizedBox(height: 10.0,),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const Historico(title: 'Historico')));
            },
            tooltip: 'Historico',
            child: const Icon(Icons.all_inbox_rounded, color: Colors.white, size: 30.0),
          ),
        ],
      ),
    );
  }
}

bool peso(String pesos) {
  for (int i = 0; i < pesos.length; i++) {
    if (pesos[i] == '1' ||
        pesos[i] == '2' ||
        pesos[i] == '3' ||
        pesos[i] == '4' ||
        pesos[i] == '5' ||
        pesos[i] == '6' ||
        pesos[i] == '7' ||
        pesos[i] == '8' ||
        pesos[i] == '9' ||
        pesos[i] == '0' ||
        pesos[i] == '.' ||
        pesos[i] == ',') {
      return true;
    } else {
      return false;
    }
  }
  return true;
}

bool alimentacao(String alimentar) {
  if (alimentar == "sim" || alimentar == "não") {
    return true;
  } else {
    return false;
  }
}

bool avaliacaoDia(String avaliacaoDias) {
  if (avaliacaoDias == '1' ||
      avaliacaoDias == '2' ||
      avaliacaoDias == '3' ||
      avaliacaoDias == '4' ||
      avaliacaoDias == '5') {
    return true;
  } else {
    return false;
  }
}

bool observacao(String observacoes) {
  if (observacoes.isEmpty || observacoes.length > 100) {
    return true;
  } else {
    return false;
  }
}
