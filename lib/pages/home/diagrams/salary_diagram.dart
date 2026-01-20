import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kancha/pages/home/diagrams/components/diagram_title.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalaryDiagram extends StatefulWidget {
  const SalaryDiagram({super.key});

  @override
  State<SalaryDiagram> createState() => _SalaryDiagramState();
}

class _SalaryDiagramState extends State<SalaryDiagram> {
  final List<MoneyData> weekData = [
    MoneyData(1, 10000),
    MoneyData(2, 6000),
    MoneyData(3, 3000),
    MoneyData(4, 8000),
    MoneyData(5, 4000),
    MoneyData(6, 6000),
    MoneyData(7, 7000),
  ];
  final List<MoneyData> yearData = [
    MoneyData(1, 10000),
    MoneyData(2, 6000),
    MoneyData(3, 3000),
    MoneyData(4, 8000),
    MoneyData(5, 4000),
    MoneyData(6, 6000),
    MoneyData(7, 7000),
    MoneyData(8, 3000),
    MoneyData(9, 8000),
    MoneyData(10, 4000),
    MoneyData(11, 6000),
    MoneyData(12, 7000),
  ];
  final List<MoneyData> monthData = [
    MoneyData(1, 10000),
    MoneyData(2, 6000),
    MoneyData(3, 3000),
    MoneyData(4, 8000),
    MoneyData(5, 4000),
    MoneyData(6, 6000),
    MoneyData(7, 7000),
    MoneyData(8, 10000),
    MoneyData(9, 6000),
    MoneyData(10, 3000),
    MoneyData(11, 8000),
    MoneyData(12, 4000),
    MoneyData(13, 6000),
    MoneyData(14, 7000),
    MoneyData(15, 10000),
    MoneyData(16, 6000),
    MoneyData(17, 3000),
    MoneyData(18, 8000),
    MoneyData(19, 4000),
    MoneyData(20, 6000),
    MoneyData(21, 7000),
    MoneyData(22, 4000),
    MoneyData(23, 6000),
    MoneyData(24, 7000),
    MoneyData(25, 10000),
    MoneyData(26, 6000),
    MoneyData(27, 3000),
    MoneyData(28, 8000),
    MoneyData(29, 4000),
    MoneyData(30, 6000),
    MoneyData(31, 7000),
  ];

  final List<int> dropdownList = [7, 31, 365];
  int? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = dropdownList.first;
  }

  List<MoneyData> get getData {
    switch (selectedValue) {
      case 31:
        return monthData;
      case 365:
        return yearData;
      default:
        return weekData;
    }
  }

  AxisTitle get getTitlesOfData {
    switch (selectedValue) {
      case 31:
        return AxisTitle(text: 'Дни', textStyle: TextStyle(fontFamily: 'Ubuntu Condensed'));
      case 365:
        return AxisTitle(text: 'Месяцы', textStyle: TextStyle(fontFamily: 'Ubuntu Condensed'));
      default:
        return AxisTitle(text: 'Дни', textStyle: TextStyle(fontFamily: 'Ubuntu Condensed'));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(10, 40, 10, 20),
      elevation: 2,
      color: Colors.white,
      shadowColor: Colors.grey[300],
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFe5e5ef), width: 0.6),
                ),
              ),
              child: DiagramTitle(
                dropdownList: dropdownList,
                value: selectedValue,
                onValueChanged: (newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
              ),
            ),
            SizedBox(height: 10),
            SfCartesianChart(
              tooltipBehavior: TooltipBehavior(enable: true),
              primaryXAxis: CategoryAxis(title: getTitlesOfData),
              primaryYAxis: NumericAxis(
                numberFormat: NumberFormat.compactCurrency(
                  symbol: '',
                  decimalDigits: 0,
                ),
              ),
              series: <CartesianSeries>[
                AreaSeries<MoneyData, String>(
                  dataSource: getData,
                  xValueMapper: (MoneyData d, _) => d.day.toString(),
                  yValueMapper: (MoneyData d, _) => d.amount,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF93AAFD).withValues(alpha: 0.7),
                      Color(0xFFC6D2FD).withValues(alpha: 0.5),
                      Color(0xFFE5EAFC).withValues(alpha: 0.3),
                    ],
                    stops: [0, 0.47, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  markerSettings: MarkerSettings(isVisible: true),
                  borderColor: Color(0xFF2D5BFF),
                  borderWidth: 1.8,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MoneyData {
  final int day;
  final double amount;
  MoneyData(this.day, this.amount);
}
