import 'package:flutter/material.dart';

import 'Historico.dart';

class DetalhesHistorico extends StatefulWidget {
  final String pesos;
  final String alimentar;
  final String avaliacaoDias;
  final String observacoes;

  const DetalhesHistorico(
      {Key? key,
      required this.pesos,
      required this.alimentar,
      required this.avaliacaoDias,
      required this.observacoes})
      : super(key: key);

  @override
  State<DetalhesHistorico> createState() =>
      _DetalhesHistoricoState(pesos, alimentar, avaliacaoDias, observacoes);
}

class _DetalhesHistoricoState extends State<DetalhesHistorico> {
  final String pesos;
  final String alimentar;
  final String avaliacaoDias;
  final String observacoes;

  _DetalhesHistoricoState(
      this.pesos, this.alimentar, this.avaliacaoDias, this.observacoes);

  @override
  Widget build(BuildContext context) {
    int count = 1;
    List<RegistoPeso> historicoRegisto = DataSource.getInstance().getAll();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Detalhes do registo'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
          Text("Peso: $pesos \n"
              "Alimentou-se nas últimas 3 horas: $alimentar\n"
              "Como se sente hoje: $avaliacaoDias\n"
              "Observações: $observacoes",
          style: const TextStyle(color: Colors.black, fontSize: 20),
          textAlign: TextAlign.left,)
        ]),
      ),
    );
  }
}
