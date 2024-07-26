import 'package:flutter/material.dart';
import 'package:miniprojeto1/DetalhesHistorico.dart';
import 'EdicaoDeRegistos.dart';

class Historico extends StatefulWidget {
  const Historico({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Historico> createState() => _HistoricoState();
}

enum MenuItem { selecionar }

class _HistoricoState extends State<Historico> {
  @override
  Widget build(BuildContext context) {
    int count = 1;
    List<RegistoPeso> historicoRegisto = DataSource.getInstance().getAll();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
      ),
      body: ListView.builder(
        itemCount: historicoRegisto.length,
        itemBuilder: (context, index) {
          final registo = historicoRegisto[index];
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(registo.toString()),
            onDismissed: (direction) {
              setState(() {
                if (historicoRegisto[index].dia >= DateTime.now().day - 7) {
                  historicoRegisto.removeAt(index);
                }
                (ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                    Text('O registo selecionado foi eliminado com sucesso.'),
                  ),
                ));
              });
            },
            child: ListTile(
              title: Text(
                  "Registo nº ${count++}\n${historicoRegisto[index]
                      .toString()}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async {
                      final newValues = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetalhesHistorico(
                                pesos: historicoRegisto[index].peso,
                                avaliacaoDias: historicoRegisto[index]
                                    .avaliacaoDias,
                                alimentar: historicoRegisto[index].alimentar,
                                observacoes: historicoRegisto[index]
                                    .observacoes,
                              ),
                        ),
                      );
                      setState(() {
                        historicoRegisto = newValues ?? historicoRegisto;
                      });
                    },
                    icon: const Icon(
                      Icons.blur_circular_rounded,
                      color: Colors.deepPurpleAccent,
                      size: 25.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DataSource {
  final _datasource = [
    RegistoPeso("56", "sim", "4", ""),
    RegistoPeso("70", "não", "2", ""),
    RegistoPeso("45", "não", "1", ""),
    RegistoPeso("65", "sim", "5", ""),
    RegistoPeso("86", "sim", "3", "")
  ];
  static DataSource _instance = DataSource._internal();

  DataSource._internal();

  static DataSource getInstance() {
    _instance ??= DataSource._internal();
    return _instance;
  }

  void insert(String peso, String alimentar, String avaliacaoDias,
      String observacoes) =>
      _datasource.add(RegistoPeso(peso, alimentar, avaliacaoDias, observacoes));

  List<RegistoPeso> getAll() => _datasource;
}

class RegistoPeso {
  String _peso;
  String _alimentar;
  String _avaliacaoDias;
  String _observacoes;
  int dia = DateTime.now().day;
  int mes = DateTime.now().month;
  int ano = DateTime.now().year;
  int hora = DateTime.now().hour;
  int minutos = DateTime.now().minute;

  String get peso => _peso;

  String get alimentar => _alimentar;

  String get avaliacaoDias => _avaliacaoDias;

  String get observacoes => _observacoes;


  RegistoPeso(this._peso, this._alimentar, this._avaliacaoDias,
      this._observacoes);

  @override
  String toString() {
    return "Peso: $peso "
        "\nComo se sente hoje: $avaliacaoDias "
        "\nData do registo: $dia/$mes/$ano - $hora:$minutos";
  }
}
