import 'package:flutter/material.dart';
import 'package:new_year_new_me/blocs/resolution_bloc.dart';
import 'package:new_year_new_me/model/resolution_model.dart';

class AddResolutionBox extends StatefulWidget {
  final ResolutionBloc resolutionBloc;

  const AddResolutionBox({this.resolutionBloc});
  @override
  _AddResolutionBoxState createState() => _AddResolutionBoxState();
}

class _AddResolutionBoxState extends State<AddResolutionBox> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  var dateText = 'Pick Date';

  Resolution sampleCreateResolution() {
    var sampleRes = Resolution(
        description: "wanna buy  a camry car for res2021 ",
        id: 7,
        isDone: false);
    return sampleRes;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 100,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [_showTopContainer(), _showContent()],
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  )),
            ),
          )
        ],
      );
  }

  Widget _showTopContainer() {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //mainAxisSize: MainAxisSize.max,
      children: [
        Container(),
        Spacer(
          flex: 2,
        ),
        Container(
          child: Text(
            'Add Resolution',
            style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none),
          ),
        ),
        Spacer(),
        Container(
          child: FlatButton(
            onPressed: () {
              var sampleRes = sampleCreateResolution();
              print("the sample create is $sampleRes");
              //widget.resolutionBloc.createResolution(sampleRes);
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Color(0xFF9598A3),
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _showContent() {
    return Material(
      child: Column(
        children: [
          _showTitleContainer(),
          _showNoteContainer(),
          _showDateContainer()
        ],
      ),
    );
  }

  Widget _showTitleContainer() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        style: TextStyle(
          fontSize: 16,
        ),
        keyboardType: TextInputType.text,
        onTap: (){
          //FocusScope.of(context).unfocus();
          //SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        controller: _titleController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Title',
          hintText: 'Enter Title',
        ),
      ),
    );
  }

  Widget _showNoteContainer() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        style: TextStyle(
          fontSize: 16,
        ),
        keyboardType: TextInputType.text,
        controller: _noteController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Note',
          hintText: 'Enter Note',
        ),
      ),
    );
  }

  Widget _showDateContainer() {
    return Container(
      padding: EdgeInsets.all(10),
      child: RaisedButton(
        
        child: Text(
          dateText
        ),
        onPressed: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime(2022),
          ).then((date) {
            setState(() {
              print('the date is $date');
              dateText = date.year.toString() + '-' +  date.month.toString() + '-' + date.day.toString();
            });
          });
        },
      )
    );
  }
}
