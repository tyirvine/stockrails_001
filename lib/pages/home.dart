import 'package:flutter/material.dart';
import 'package:stockrails_001/classes/stockSearch.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';




class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<List<StockSearch>> getStockSearch() async {

    var stockSearchData = await http.get('https://sandbox.iexapis.com/stable/search/apple?token=Tsk_801c26698a37427898480622dd23e138');

    var stockSearchJSONData = json.decode(stockSearchData.body);

    List<StockSearch> stockSearchList = [];

    for (var s in stockSearchJSONData) {
      
      StockSearch stockSearchUpdate = StockSearch(s["symbol"], s["exchange"]);

      stockSearchList.add(stockSearchUpdate);

    }

    print(stockSearchList.length);

    return stockSearchList;

  }


  @override
    Widget build(BuildContext context) {
      return Scaffold( 
        
        appBar: AppBar(
          title: Text('JSON Stock Test'),
        ),

        body:Column(
          
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: <Widget>[

            FutureBuilder(
              future: getStockSearch(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {

                if (snapshot.data == null) {
                      return Container(
                        child: Center(child: Text('Loading...'),),
                      );
                }    
                
                else{
                return Container(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index){

                      return ListTile(
                        title: Text(snapshot.data[index].ticker),
                        subtitle: Text(snapshot.data[index].exchange),
                      );

                    },
                  ),
                );
                }
              },
            ),
        ]),
      );
    }
  }
  