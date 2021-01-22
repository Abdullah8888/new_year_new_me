import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:new_year_new_me/blocs/resolution_bloc.dart';
import 'package:new_year_new_me/local_push_notification/local_push_notification.dart';
import 'package:new_year_new_me/model/resolution_model.dart';
import 'package:new_year_new_me/pages/completed_resolution.dart';
import 'package:new_year_new_me/pages/summary_report.dart';

import 'add_resolution_box.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  
  var yearSelectedColor = Color(0xFF2073DC);
  var years = [
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026'
        '2027',
    '2029'
  ];
  final resolutionBloc = ResolutionBloc();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //resolutionBloc.createResTable();
    print('it seems it has created');
  }

  Resolution sampleCreateResolution() {
    var sampleRes = Resolution(
        description: "wanna buy  a pan for res2021 ", id: 5, isDone: false);
    return sampleRes;
  }

  void printAllResolutions(List<Resolution> resolutions) {
    if (resolutions.length > 0) {
      for (var i = 0; i < resolutions.length; i++) {
        var des = resolutions[i].description;
        var status = resolutions[i].isDone;
        var resNum = resolutions[i].id;
        print('content $i is $resNum , $des,  $status');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //addAutomaticKeepAlives: false,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: _showTop(context)
            ),
            Flexible(
              flex: 2,
              child: Container(
                child: StreamBuilder(
                  stream: resolutionBloc.resolutions,
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<Resolution>> snapshot) {
                      if (snapshot.hasData) {
                        print('the data is ${snapshot.data}');
                        printAllResolutions(snapshot.data);
                        return _showResolutions(snapshot);
                      } else {
                        print('problem somewhere ${snapshot.data}');
                        return _loadingData();
                      }
                  },
                ),
              ),
            ),
          ],
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var sampleRes = sampleCreateResolution();
          print("the sample create is $sampleRes");
          //resolutionBloc.createResolution(sampleRes);
          print('licked o');
          //_scaffoldKey.currentState.showSnackBar(_myLoaderContainer());
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Container(
                child: AddResolutionBox(resolutionBloc: resolutionBloc,)
              );
            }
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF2F80ED),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _showTop(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Color(0xFF2F80ED),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 40.0, left: 15.0, bottom: 10.0),
                  alignment: Alignment.topLeft,
                  child: Text('My Resolution',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                          color: Colors.white)),
                ),
              ),
              Flexible(
                flex: 2,
                child: _showResolutionStatus()
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showYears() {
    return SizedBox(
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsets.all(5.0),
        children: [
          _showYear('2021'),
          _showYear('2022'),
          _showYear('2023'),
          _showYear('2024'),
          _showYear('2025'),
          _showYear('2026'),
          _showYear('2027'),
          _showYear('2028'),
        ],
      ),
    );
  }

  Widget _showYear(String year) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 100.0,
        child: Center(
          child: InkWell(
            child: Text(
              year,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white),
            ),
            onTap: () {
              print('the year selected is $year');
              setState(() {
                yearSelectedColor = Color(0xFF28CBFF);
              });
            },
          ),
        ),
        decoration: BoxDecoration(
            color: yearSelectedColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white,
            )),
      ),
    );
  }

  Widget _showResolutionStatus() {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: _completedResolutionContainer()),
            Flexible(child: _divider()),
            Flexible(child: _summaryReportContainer())
          ],
        ),
      ),
    );
  }

  Widget _completedResolutionContainer() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LocalNotificationWidget())
        );
      },
      child: ListTile(
        leading: Image.asset(
          'images/green_mark.png',
          fit: BoxFit.cover,
        ),
        title: Text(
          'Completed Resolutions',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
        ),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '4',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Color(0xFF27AE60)),
            ),
            SizedBox(
              width: 4.0,
            ),
            Text(
              'Resolutions Completed',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Color(0xFF27AE60)),
            ),
          ],
        ),
        trailing: Image.asset(
          'images/right_arrow.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Divider(
        color: Color(0xFFDFE0E4),
      ),
    );
  }

  Widget _summaryReportContainer() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SummaryReport())
        );
      },
      child: ListTile(
        leading: Image.asset(
          'images/orange_mark.png',
          fit: BoxFit.cover,
        ),
        title: Text(
          'Summary Report',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(bottom: 0.0, top: 0),
          child: Text(
            'Progress report & completion rate',
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Color(0xFF9598A3)),
          ),
        ),
        trailing: Image.asset(
          'images/right_arrow.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _showResolutions(AsyncSnapshot<List<Resolution>> snapshot) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.all(5.0),
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return _showResolution(context, snapshot.data[index]);
      },
    );
  }

  Widget _showResolution(BuildContext context, Resolution resolution) {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: ListTile(
        title: Text(
          resolution.description,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
        ),
        leading: InkWell(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: resolution.isDone
                  ? Icon(
                      Icons.done,
                      size: 24,
                      color: Colors.indigo,
                    )
                  : Image.asset(
                      'images/round_check.png',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          onTap: () {},
        ),
        trailing: Container(
          child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    child: Icon(
                      Icons.edit,
                      size: 24,
                      color: Colors.black54,
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: Icon(
                      Icons.delete,
                      size: 24,
                      color: Colors.black54,
                    ),
                    onTap: () {
                      print('the selected item is ${resolution.id}');
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget _loadingData() {
    //pull todos again
    //todoBloc.getTodos();
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              backgroundColor: Colors.black,
            ),
            Text("Loading...",
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: Colors.red))
          ],
        ),
      ),
    );
  }

  Widget _myLoaderContainer() {
    return SnackBar(
      content: Row(
        children: [
          Text(
            'Loading man ...'
          ),
        ],
      ),
      duration: Duration(seconds: 1),
    );
  }

  Widget noResolutionMessageWidget() {
    return Container(
      child: Text(
        "Start adding Todo...",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
    );
  }
}

