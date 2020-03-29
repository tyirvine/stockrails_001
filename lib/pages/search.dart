

// Packages
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stockrails_001/classes.dart';
import 'package:stockrails_001/custom/bottom_sheet.dart' as my;


// Dependencies
import 'package:http/http.dart' as http;
import 'package:flappy_search_bar/flappy_search_bar.dart';


// Dart Files
import 'dart:async';
import 'dart:convert';



/*........................................... Program ......................................*/

//Variables
String companyName;
String exchange;
String symbol;

//Colours
const blue1 = const Color(0xFF517CD3);
const blue2 = const Color(0xFF5B8AEA);
const blue3 = const Color(0xFF6292F3);
const blue4 = const Color(0xFF7BA7FF);
const blue5 = const Color(0xFFC5D8FF);
const green6 = const Color(0xFF89B78A);
const grey7 = const Color(0xFF373B49);
const grey8 = const Color(0xFF454A5C);
const grey9 = const Color(0xFF3E4251);
const grey10 = const Color(0xFF656C84);
const grey11 = const Color(0xFF6C748F);
const grey12 = const Color(0xFFD0D0D0);
const white13 = const Color(0xFFFFFFFF);
const red14 = const Color(0xFFC95C5C);





class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}


class _SearchState extends State<Search> {

//-------------------------------------------------- Bottom Sheet Card
  
  _showBottomSheet(context, String companyName, String exchange, String symbol) {
      my.showModalBottomSheet(
        context: (context),
        isScrollControlled: false,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.25),
        ),
        builder: (BuildContext context){
//-------------------------------------------------- Rounded Corners & Card
          return Column(
                    // key: _stockBottomSheetKey,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 0.0),
//-------------------------------------------------- Drag Tab & Close
          child: SafeArea(
            top: true,
            bottom: false,
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            SizedBox(width: 50.0),
            Align(child: Icon(Icons.drag_handle), alignment: Alignment.center),
            IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.close)),
            ]),
          ),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
//-------------------------------------------------- Stock Info & Notifier Count
                    child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
//-------------------------------------------------- Symbol / Exchange / Company Name
                    Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
              Text(
                '$symbol',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                '$exchange',
                style: TextStyle(
                  fontSize: 11.0,
                ),
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
              ),
          ],
                    ),
                    Text(
          '$companyName',
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
                    ),
                    ],
                  ),
                ],
              ),
                  Column(
                    children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(10.0, 6.0, 6.0, 6.0),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
              Text(
                '0',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  ),
              ),
              Icon(
                Icons.notifications,
                color: Colors.white,
                size: 18.0,
                ),
              ],
              ),
          ),
                ],
              ),
          ],
                    ),
                  ),
                  SizedBox(height: 15.0),
//-------------------------------------------------- Divider ----------------------------------------------
                Divider(),

//-------------------------------------------------- Alert section tool bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: Column(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                      Text(
                        'Alerts'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black, 
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                          Container(width: 30.0, padding: EdgeInsets.all(0.0), child: IconButton(onPressed: () {}, icon: Icon(Icons.create))),
                          Container(width: 30.0, padding: EdgeInsets.all(0.0), child: IconButton(onPressed: () {}, icon: Icon(Icons.add))),
                        ],),
                      )
                    ],)
                  ],),
                ),

//-------------------------------------------------- New alert add button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    child: FlatButton(
                    onPressed: () {},
                    color: grey7,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.add, color: grey10,),
                          SizedBox(height: 10.0),
                          Text(
                            'New Alert'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: grey10,
                            ),
                          ),
                        ],
                      ),
                    )
                      ),
                  ),
                ]),
          ],
                  );
         }
      );
  }


//-------------------------------------------------- Page
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    body: Stack(
    children: <Widget>[
    SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SearchBar<StockSearch>(
          onSearch: getStockSearch,
          onItemFound: (StockSearch post, int index) {
              return Column(
              children: <Widget>[
//-------------------------------------------------- List Stock Tile
                ListTile(
                  onTap: () {
                    _showBottomSheet(context, post.companyname, post.exchange, post.symbol);
                    // _afterLayout();
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible( //Ticker, Exchange, and Name
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
//-------------------------------------------------- Symbol & Exchange!
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                
                                Text(post.symbol), //Symbol

                                SizedBox(width: 5.0), //Spacer

//-------------------------------------------------- Exchange!
                                Expanded(
                                  child: Text( //Exchange
                                    post.exchange,
                                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                ),

                              ],
                            ),

//-------------------------------------------------- Company Name!
                            Text(
                              post.companyname,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                            ), //Company Name

                          ],
                        ),
                      ),
                      Flexible(
//-------------------------------------------------- Price & Change! 
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[

                            Text(post.latestprice.toString().replaceAll('null', '')), //Stock Price!

                            SizedBox(height: 2.0), //Spacer


                            if(post.changeRendered != 'null')
                            
                            if(post.changeRendered > 0) //Positive Change!
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(6.0, 2.0, 4.0, 2.0),
                                child: Text(
                                  post.change.toString().replaceAll('null', ''),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0,
                                    ),
                                ),
                              ))

                            else if(post.changeRendered < 0) //Negative Change!
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(6.0, 2.0, 4.0, 2.0),
                                child: Text(
                                  post.change.toString().replaceAll('null', ''),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0,
                                    ),
                                ),
                              ))

                            else if(post.changeRendered == 0) //Negative Change!
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(6.0, 2.0, 4.0, 2.0),
                                child: Text(
                                  post.change.toString().replaceAll('null', ''),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0,
                                    ),
                                ),
                              )),


                          ],
                        ),
                      )
                    ],
                  ),
                ),
//-------------------------------------------------- Divider ----------------------------------------------
                Divider(),
              ],
            );
          },
        ),
      ),
    ),  
        ]),
      );
  }

//-------------------------------------------------- API Data!

    Future<List<StockSearch>> getStockSearch(String search) async {

      String symbol;
      await Future.delayed(Duration(seconds: 1));

      var stockSearchSymbolData = await http.get( ('https://sandbox.iexapis.com/stable/search/' + '$search' + '?token=Tsk_801c26698a37427898480622dd23e138') );
      var stockSearchSymbolJSONData = json.decode(stockSearchSymbolData.body);

      List<Symbol> stockSymbolList = [];
      List<StockSearch> stockSearchList = [];

      for (var u in stockSearchSymbolJSONData) {
        
        // --------------- This adds in from the first API search -----

        Symbol stockSymbolUpdate = Symbol(u["symbol"]);
        stockSymbolList.add(stockSymbolUpdate);
        symbol = u["symbol"];
        print(symbol);


        // --------------- This gathers the remaining information using a new api request from the symbol list above -----

        var stockSearchData = await http.get( ('https://cloud.iexapis.com/stable/stock/' + '$symbol' + '/quote?token=pk_d41c533580ca4184ab59cb764a374bb5') );
        var stockSearchJSONData = json.decode(stockSearchData.body);

        if (stockSearchData.statusCode == 200) {
          if(stockSearchJSONData.toString().contains('latestPrice: null') == false) 
            stockSearchList.add(StockSearch.fromJson(stockSearchJSONData));
        }

      }
      
      // --------------- This instantiates the data to the UI -----

      return stockSearchList;

  }
}


/*........................................... Program ......................................*/