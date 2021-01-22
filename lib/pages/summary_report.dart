import 'package:flutter/material.dart';
import 'package:new_year_new_me/chart/bar_chart_demo.dart';
import 'package:new_year_new_me/generic_container/generic_container.dart';

class SummaryReport extends StatefulWidget {
  @override
  _SummaryReportState createState() => _SummaryReportState();
}

class _SummaryReportState extends State<SummaryReport> {
  GenerricContainer genericContainer;
  BarChartDemo barChartDemo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genericContainer = GenerricContainer();
    barChartDemo = BarChartDemo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFF2F80ED),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Flexible(
                child: genericContainer.showNavBar(
              context,
              'Summary Report',
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
              Color(0xFF2F80ED),
            )),
            Flexible(
              flex: 4,
              child: Column(
                children: [
                  Flexible(child: _showCompletionRateContainer()),
                  Flexible(child: _showAverageContainer()),
                  Flexible(flex: 7, child: _showBarChartContainer()),
                  Flexible(flex: 4, child: _showProgressReport())
                ],
              ),
            )
          ],
        ));
  }

  Widget _showCompletionRateContainer() {
    return Container(
        alignment: Alignment.centerLeft,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Completion rate',
            style: TextStyle(
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white),
          ),
        ));
  }

  Widget _showAverageContainer() {
    return Container(
        alignment: Alignment.centerLeft,
        height: 80,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20.0),
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Average of 4 complete',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 11,
                    color: Colors.white),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'resolution in the last 6 months',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 11,
                    color: Colors.white),
              ),
            ),
          ],
        ));
  }

  Widget _showBarChartContainer() {
    return barChartDemo.showChart();
  }

  Widget _showProgressReport() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.only(left: 20.0),
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Progress Report',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          _showCompletedResolutionContainer(),
          _showUnCompletedResolutionContainer(),
          _showFailedResolutionContainer()
        ],
      ),
    );
  }

  Widget _showCompletedResolutionContainer() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 10.0, bottom: 0.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Completed Resolution',
              style: TextStyle(
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            Text(
              '89',
              style: TextStyle(
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.green,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _showUnCompletedResolutionContainer() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 10.0, bottom: 0.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Uncompleted Resolution',
              style: TextStyle(
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            Text(
              '89',
              style: TextStyle(
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.yellow,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _showFailedResolutionContainer() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 10.0, bottom: 0.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Failed Resolution',
              style: TextStyle(
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            Text(
              '33',
              style: TextStyle(
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
