import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JSON Stock Test'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
            return Card(
              child: Padding(padding: const EdgeInsets.all(30.0),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[
                    Text(
                      'Ticker',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '0.00',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      );
  }
}