import 'package:flutter/material.dart';
import 'package:new_year_new_me/blocs/resolution_bloc.dart';
import 'package:new_year_new_me/generic_container/generic_container.dart';
import 'package:new_year_new_me/model/resolution_model.dart';
import 'package:new_year_new_me/pages/homepage.dart';

class CompletedResolution extends StatefulWidget {
  final ResolutionBloc resolutionBloc;

  const CompletedResolution({this.resolutionBloc});
  @override
  _CompletedResolutionState createState() => _CompletedResolutionState();
}

class _CompletedResolutionState extends State<CompletedResolution> {
  GenerricContainer genericContainer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genericContainer = GenerricContainer();
    widget.resolutionBloc.fetchResolutions();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFFE5E5E5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: genericContainer.showNavBar(
                context,
                'Completed Resolution',
                Color(0xFF000000),
                Color(0xFF767E85),
                Color(0xFFE5E5E5),
              ),
            ),
            Flexible(
              flex: 2,
              child: _showCompletedContainer(),
            ),
          ],
        )
    );
  }

  Widget _showCompletedContainer() {
    return Container(
        child: StreamBuilder(
          stream: widget.resolutionBloc.resolutions,
          builder: (BuildContext context,
              AsyncSnapshot<List<Resolution>> snapshot) {
            if (snapshot.hasData) {
              print('the data is ${snapshot.data}');
              return _showCompletedResolutions(snapshot);
            } else {
              print('problem somewhere ${snapshot.data}');
              //return _noCompletedResolutionContainer();
            }
          },
        ),
    );
  }

  Widget _showCompletedResolutions(AsyncSnapshot<List<Resolution>> snapshot) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.all(5.0),
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return _showCompletedResolution(context, snapshot.data[index]);
      },
    );
  }

  Widget _showCompletedResolution(BuildContext context, Resolution resolution) {
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
              child: Image.asset(
                'images/green_mark.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          onTap: () {},
        ),
      ),
    );
  }

  Widget _noCompletedResolutionContainer() {
    return Text(
      'You don\'t have a completed Resolution',
      style: TextStyle(
        decoration: TextDecoration.none,
        color: Colors.black,
        fontSize: 18,
      ),
    );
  }
}
