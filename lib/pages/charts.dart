import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class GraphContainer extends StatefulWidget {
  @override
  _GraphContainerState createState() => _GraphContainerState();
}

class _GraphContainerState extends State<GraphContainer> {
  List<charts.Series<GraphData
  , int>> _graphSeries;

   _createSampleData() {
    final pulseRateData = [
      new GraphData(0, 65),
      new GraphData(1, 70),
      new GraphData(2, 69),
      new GraphData(3, 75),
      new GraphData(4, 70),
      new GraphData(5, 70),
      new GraphData(6, 72),
    ];

    var diastolicData = [
      new GraphData(0, 78),
      new GraphData(1, 80),
      new GraphData(2, 72),
      new GraphData(3, 80),
      new GraphData(4, 75),
      new GraphData(5, 69),
      new GraphData(6, 70),
    ];

    var systolicData = [
      new GraphData(0, 126),
      new GraphData(1, 120),
      new GraphData(2, 115),
      new GraphData(3, 128),
      new GraphData(4, 120),
      new GraphData(5, 118),
      new GraphData(6, 118),
    ];

    _graphSeries =  [
      new charts.Series<GraphData
      , int>(
        id: 'Pulse Rate',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (GraphData pointData, _) => pointData.year,
        measureFn: (GraphData pointData, _) => pointData.pointData,
        data: pulseRateData,
      ),
      new charts.Series<GraphData
      , int>(
        id: 'Diastolic',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (GraphData pointData, _) => pointData.year,
        measureFn: (GraphData pointData, _) => pointData.pointData,
        data: diastolicData,
      ),
      new charts.Series<GraphData
      , int>(
        id: 'Systolic BP',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (GraphData pointData, _) => pointData.year,
        measureFn: (GraphData pointData, _) => pointData.pointData,
        data: systolicData,
      ),
    ];
  }

  @override
  void initState() {
    _createSampleData();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StackedAreaLineChart(_graphSeries, animate: false,),
    );
  }
}

class StackedAreaLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StackedAreaLineChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(
      seriesList,
      defaultRenderer: new charts.LineRendererConfig(includeArea: false, stacked: false),
      animate: true,
      behaviors: [
        new charts.SeriesLegend(
          // Positions for "start" and "end" will be left and right respectively
          // for widgets with a build context that has directionality ltr.
          // For rtl, "start" and "end" will be right and left respectively.
          // Since this example has directionality of ltr, the legend is
          // positioned on the right side of the chart.
          position: charts.BehaviorPosition.top,
          // For a legend that is positioned on the left or right of the chart,
          // setting the justification for [endDrawArea] is aligned to the
          // bottom of the chart draw area.
          outsideJustification: charts.OutsideJustification.middleDrawArea,
          // By default, if the position of the chart is on the left or right of
          // the chart, [horizontalFirst] is set to false. This means that the
          // legend entries will grow as new rows first instead of a new column.

          // horizontalFirst: false,

          // By setting this value to 2, the legend entries will grow up to two
          // rows before adding a new column.
          desiredMaxRows: 2,
          // This defines the padding around each legend entry.
          cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
          // Render the legend entry text with custom styles.
          entryTextStyle: charts.TextStyleSpec(
              color: charts.Color(r: 127, g: 63, b: 191),
              fontFamily: 'Georgia',
              fontSize: 11),
        )
      ],
    );
  }

}


class GraphData{
  final int year;
  final int pointData;

  GraphData(this.year, this.pointData);
}

