import 'package:flutter/material.dart';
import 'package:miniprojeto1/FirstPage.dart';
import 'package:miniprojeto1/Historico.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum MenuItem { adicionar, historico }

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    List<RegistoPeso> historicoRegisto = DataSource.getInstance().getAll();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('WeightDrop'),
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () {},
        ),
        actions: [
          PopupMenuButton<MenuItem>(
            onSelected: (value) {
              if (value == MenuItem.adicionar) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FirstPage(title: 'Registo'),
                  ),
                );
              }
              if (value == MenuItem.historico) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Historico(title: 'Histórico'),
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: MenuItem.adicionar,
                child: Text('Adicionar Registo'),
              ),
              const PopupMenuItem(
                value: MenuItem.historico,
                child: Text('Histórico'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Bem vindo/a!",
              style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 30),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            const Text(
              "A sua avaliação: ",
              style: TextStyle(color: Colors.black, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text("Media de peso - últimos 7 dias: ${mediaPeso7Dias(DataSource.getInstance().getAll())} Kg",
            style: const TextStyle(color: Colors.black, fontSize: 15),
              textAlign: TextAlign.center,),
            const SizedBox(height: 10),
            Text("Media de peso - últimos 30 dias: ${mediaPeso30Dias(DataSource.getInstance().getAll())} Kg",
              style: const TextStyle(color: Colors.black, fontSize: 15),
              textAlign: TextAlign.center,),
            const SizedBox(height: 10),
            Text("Media de “como se sente hoje” - últimos 7 dias: ${mediaAvaliacao7Dias(DataSource.getInstance().getAll())}",
              style: const TextStyle(color: Colors.black, fontSize: 15),
              textAlign: TextAlign.center,),
            const SizedBox(height: 10),
            Text("Media de “como se sente hoje” - últimos 30 dias: ${mediaAvaliacao30Dias(DataSource.getInstance().getAll())}",
              style: const TextStyle(color: Colors.black, fontSize: 15),
              textAlign: TextAlign.center,),
            const SizedBox(height: 10),
            Text("Primeiro registo de peso: ${primeiroPeso(DataSource.getInstance().getAll())}",
              style: const TextStyle(color: Colors.black, fontSize: 15),
              textAlign: TextAlign.center,),
            const SizedBox(height: 10),
            Text("Último registo de peso: ${ultimoPeso(DataSource.getInstance().getAll())}",
              style: const TextStyle(color: Colors.black, fontSize: 15),
              textAlign: TextAlign.center,),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'Úiltimos 15 dias - Peso',
                  textStyle: const TextStyle(color: Colors.deepPurpleAccent, fontSize: 20)),
              legend: Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<RegistoPeso, int>>[
                LineSeries<RegistoPeso, int>(
                  dataSource: ultimos15(historicoRegisto),
                  xValueMapper: (RegistoPeso historicoRegisto, _) => historicoRegisto.dia,
                  yValueMapper: (RegistoPeso historicoRegisto, _) => int.parse(historicoRegisto.peso),
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
              ]
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                      const FirstPage(title: 'Registo de peso')));
        },
        tooltip: 'Registo de peso',
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 20.0),
      ),
    );
  }
}

double mediaPeso7Dias(List<RegistoPeso> _dataSource) {
  double peso = 0;
  double media = 0;
  List<RegistoPeso> pesos = [];
  for (int i = 0; i < _dataSource.length; i++) {
    if (_dataSource[i].ano == DateTime.now().year){
      if(_dataSource[i].mes == DateTime.now().month){
        if(_dataSource[i].dia >= DateTime.now().day - 7){
          peso += int.parse(_dataSource[i].peso);
          pesos.add(_dataSource[i]);
        }
      }
    }
  }
  media = (peso/pesos.length);
  if(peso == 0){
    return 0;
  }
  return media;
}

double mediaPeso30Dias(List<RegistoPeso> _dataSource) {
  double peso = 0;
  double media = 0;
  List<RegistoPeso> pesos = [];
  for (int i = 0; i < _dataSource.length; i++) {
    if (_dataSource[i].ano == DateTime.now().year){
      if(_dataSource[i].mes == DateTime.now().month){
        if(_dataSource[i].dia >= DateTime.now().day - 30 ){
          peso += int.parse(_dataSource[i].peso);
          pesos.add(_dataSource[i]);
        }
      }
    }
  }
  media = (peso/pesos.length);
  if(peso == 0){
    return 0;
  }
  return media;
}

double mediaAvaliacao7Dias(_dataSource) {
  double avaliacaoDias = 0;
  double media = 0;
  List<RegistoPeso> avaliacoes = [];
  for (int i = 0; i < _dataSource.length; i++) {
    if (_dataSource[i].ano == DateTime.now().year){
      if(_dataSource[i].mes == DateTime.now().month){
        if(_dataSource[i].dia >= DateTime.now().day - 7 ){
          avaliacaoDias += int.parse(_dataSource[i].avaliacaoDias);
          avaliacoes.add(_dataSource[i]);
        }
      }
    }
  }
  media = (avaliacaoDias/avaliacoes.length);
  if(avaliacaoDias == 0){
    return 0;
  }
  return media;
}

double mediaAvaliacao30Dias(_dataSource) {
  double avaliacaoDias = 0;
  double media = 0;
  List<RegistoPeso> avaliacoes = [];
  for (int i = 0; i < _dataSource.length; i++) {
    if (_dataSource[i].ano == DateTime.now().year){
      if(_dataSource[i].mes == DateTime.now().month){
        if(_dataSource[i].dia >= DateTime.now().day - 30 ){
          avaliacaoDias += int.parse(_dataSource[i].avaliacaoDias);
          avaliacoes.add(_dataSource[i]);
        }
      }
    }
  }
  media = (avaliacaoDias/avaliacoes.length);
  if(avaliacaoDias == 0){
    return 0;
  }
  return media;
}

String primeiroPeso(_dataSource){
  int anoTemp = DateTime.now().year;
  int mesTemp = DateTime.now().month;
  int diaTemp = DateTime.now().day;
  List<RegistoPeso> pesos = [];
  for (int i = 0; i < _dataSource.length; i++) {
    if(_dataSource[i].ano <= anoTemp){
      anoTemp = _dataSource[i].ano;
      if(_dataSource[i].mes <= mesTemp){
        mesTemp = _dataSource[i].mes;
        if(_dataSource[i].dia <= diaTemp){
          diaTemp = _dataSource[i].dia;
          pesos.add(_dataSource[i]);
        }
      }
    }
  }
  return pesos[0].peso;
}

String ultimoPeso(_dataSource){
  int anoTemp = DateTime.now().year;
  int mesTemp = DateTime.now().month;
  int diaTemp = DateTime.now().day;
  List<RegistoPeso> pesos = [];
  for (int i = 0; i < _dataSource.length; i++) {
    if(_dataSource[i].ano <= anoTemp){
      anoTemp = _dataSource[i].ano;
      if(_dataSource[i].mes <= mesTemp){
        mesTemp = _dataSource[i].mes;
        if(_dataSource[i].dia <= diaTemp){
          diaTemp = _dataSource[i].dia;
          pesos.add(_dataSource[i]);
        }
      }
    }
  }
  return pesos[pesos.length-1].peso;
}

List<RegistoPeso> ultimos15 (_dataSource){
  int anoTemp = DateTime.now().year;
  int mesTemp = DateTime.now().month;
  int diaTemp = DateTime.now().day;
  List<RegistoPeso> pesos = [];
  for(int i = 0; i <= 15 && i < _dataSource.length; i++){
    if(_dataSource[i].ano <= anoTemp){
      anoTemp = _dataSource[i].ano;
      if(_dataSource[i].mes <= mesTemp){
        mesTemp = _dataSource[i].mes;
        if(_dataSource[i].dia <= diaTemp){
          diaTemp = _dataSource[i].dia;
          pesos.add(_dataSource[i]);
        }
      }
    }
  }
  return pesos;
}



