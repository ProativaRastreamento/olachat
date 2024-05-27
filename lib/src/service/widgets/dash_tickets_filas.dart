import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../../../dashboard/dash_tickets_filas.dart';
import '../configuracoes/configuracoes_service.dart';
import '../estatisticas/estatisticas_service.dart';
import '../filas/filas_service.dart';

class DashTicketsFilas extends StatefulWidget {
  @override
  _DashTicketsFilasState createState() => _DashTicketsFilasState();
}

class _DashTicketsFilasState extends State<DashTicketsFilas> {
  final EstatisticasService _estatisticasService = EstatisticasService();
  final ConfiguracoesService _configuracoesService = ConfiguracoesService();
  final FilasService _filasService = FilasService();

  Map<String, dynamic> ticketsAndTimes = {};
  List<dynamic> filas = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final params = {
        'startDate': '2023-01-01',
        'endDate': '2023-01-31',
      };
      final ticketsAndTimesData = await _estatisticasService.getDashTicketsAndTimes(params);
      final filasData = await _filasService.listarFilas();

      setState(() {
        ticketsAndTimes = ticketsAndTimesData;
        filas = filasData;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildHeader(),
          _buildStats(),
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

  Widget _buildHeader() {
    return Card(
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
                            items: filas.map<DropdownMenuItem<String>>((dynamic value) {
                              return DropdownMenuItem<String>(
                                value: value['id'].toString(),
                                child: Text(value['queue']),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _loadData();
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
    );
  }

  Widget _buildStats() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard('Total Atendimentos', ticketsAndTimes['qtd_total_atendimentos']?.toString() ?? '0', Colors.red),
                _buildStatCard('Ativo', ticketsAndTimes['qtd_demanda_ativa']?.toString() ?? '0', Colors.amber),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard('Tempo Médio de Atendimento (TMA)', '${ticketsAndTimes['tma'] ?? '0'} min', Colors.red),
                _buildStatCard('Tempo Médio 1º Resposta', '${ticketsAndTimes['tme'] ?? '0'} min', Colors.blue),
              ],
            ),
          ],
        ),
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
  }}