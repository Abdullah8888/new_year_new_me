import 'package:flutter/material.dart';
import 'package:new_year_new_me/pages/homepage.dart';

class GenerricContainer {

  Widget showNavBar(BuildContext context, String title, Color tileColor, Color leftArrowColor, Color navBarColor) {
    return Material(
      color: navBarColor,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0, bottom: 5.0),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage())
                    );
                  },
                  child: Image.asset(
                    'images/left_arrow.png',
                    fit: BoxFit.cover,
                    color: leftArrowColor,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 100,
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 19,
                        color: tileColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}