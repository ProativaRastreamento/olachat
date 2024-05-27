import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DashTicketsFilas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Painel de Controle',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Flexible(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Data/Hora Agendamento',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Data/Hora Agendamento',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'SETORES',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: <String>['Setor 1', 'Setor 2', 'Setor 3']
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (_) {},
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Implementar lógica para gerar dados
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.refresh),
                                  SizedBox(width: 5),
                                  Text('Gerar'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatCard('Total Atendimentos', '100', Colors.red),
                      _buildStatCard('Ativo', '50', Colors.amber),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatCard('Tempo Médio de Atendimento (TMA)', '5 min', Colors.red),
                      _buildStatCard('Tempo Médio 1º Resposta', '2 min', Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _buildChart('Atendimento por canal')),
              Expanded(child: _buildChart('Atendimento por fila')),
            ],
          ),
          SizedBox(height: 10),
          _buildChart('Evolução por canal'),
          SizedBox(height: 10),
          _buildChart('Evolução atendimentos'),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      color: color,
      child: Container(
        width: 150,
        height: 100,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChart(String title) {
    return Card(
      child: Container(
        height: 300,
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: charts.BarChart(
                _createSampleData(),
                animate: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<charts.Series<ChartData, String>> _createSampleData() {
    final data = [
      ChartData('2014', 5),
      ChartData('2015', 25),
      ChartData('2016', 100),
      ChartData('2017', 75),
    ];

    return [
      charts.Series<ChartData, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (ChartData sales, _) => sales.year,
        measureFn: (ChartData sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class ChartData {
  final String year;
  final int sales;

  ChartData(this.year, this.sales);
}
