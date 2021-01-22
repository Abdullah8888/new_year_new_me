import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:new_year_new_me/model/bar_chart_model.dart';

class BarChartGraph extends StatefulWidget {
  final List<BarChartModel> data;

  const BarChartGraph({Key key, this.data}) : super(key: key);

  @override
  _BarChartGraphState createState() => _BarChartGraphState();
}

class _BarChartGraphState extends State<BarChartGraph> {
  List<BarChartModel> _barChartList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _barChartList = [
      BarChartModel(month: "Oct"),
      BarChartModel(month: "Nov"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
          id: "Financial",
          data: widget.data,
          domainFn: (BarChartModel series, _) => series.year,
          measureFn: (BarChartModel series, _) => series.financial,
          colorFn: (BarChartModel series, _) => series.color),
    ];

    //return _buildFinancialList(series);
    return Container(
      height: 400,
      padding: EdgeInsets.all(20.0),
      child: Card(
          child: Column(
            children: [
              Text(
                '',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
      ),
    );

  }

  // Widget _buildFinancialList(series) {
  //   return _barChartList != null
  //       ? ListView.separated(
  //     physics: NeverScrollableScrollPhysics(),
  //     separatorBuilder: (context, index) => Divider(
  //       color: Colors.white,
  //       height: 5,
  //     ),
  //     scrollDirection: Axis.vertical,
  //     shrinkWrap: true,
  //     itemCount: _barChartList.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return Container(
  //         height: MediaQuery.of(context).size.height/ 2.3,
  //         padding: EdgeInsets.all(10),
  //         child: Column(
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text(_barChartList[index].month,
  //                     style: TextStyle(
  //                         color: Colors.black, fontSize: 22,
  //                         fontWeight: FontWeight.bold)
  //                 ),
  //               ],
  //             ),
  //             Expanded( child: charts.BarChart(series, animate: true)),
  //           ],
  //         ),
  //       );
  //     },
  //   )
  //       : SizedBox();
  // }
}