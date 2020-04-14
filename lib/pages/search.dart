//Packages
import 'dart:ui';

//Pages
import 'package:flutter/material.dart';
import 'package:stockrails_001/classes.dart';
import 'package:stockrails_001/custom/bottom_sheet.dart' as my;

// Dependencies
import 'package:http/http.dart' as http;
import 'package:stockrails_001/custom/flappy_search_bar.dart';

// Dart Files
import 'dart:async';
import 'dart:convert';

//Global Data
import 'package:stockrails_001/data.dart';
import 'package:stockrails_001/storage/saves.dart';

/*........................................... Program ......................................*/

//Identifiers
String companyName;
String exchange;
String symbol;

//Focus State
ValueChanged<bool> onFocusChanged;


class Search extends StatefulWidget {

  @override
  _SearchState createState() => _SearchState();

  // * Captures list of all symbols
  getSymbolList() async {
    var symbolList = await notifierHelperData.readAllSymbols() ?? ['symbolList :: null'];
    return symbolList;
  }

  // * Captures symbol count of specified symbol
  getSymbolCount(String symbol) async {
    final int symbolCount = await notifierHelperData.readSymbolCount(symbol) ?? 0;
    return symbolCount;
  }

  // * Captures total number of symbols
  getTotalSymbolCount() async {
    final int symbolCount = await notifierHelperData.readTotalSymbolCount() ?? 0;
    print('$symbolCount');
    return symbolCount;
  }

  // * Opens notifier creation page
  newNotifier(context, String companyName, String exchange, String symbol, dynamic price) {
  notifierData.notifierPrinciplePrice = price; // Records latest price
  print(notifierData.notifierPrinciplePrice);
  Navigator.of(context).pushNamed('/notifier', arguments: {
      'symbol': symbol,
      'companyname': companyName,
      'exchange': exchange,
      'price': price
    });  // Pushes data to next page
  }

 // * Displays bottom sheet
  showBottomSheet(context, String companyName, String exchange, String symbol, dynamic price, var symbolCount) async {
    my.showModalBottomSheet(
        context: (context),
        isScrollControlled: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.25),
        ),
        builder: (BuildContext context) {
// * -------------------------------------------------- Rounded Corners & Card
          return Column(
            // key: _stockBottomSheetKey,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 0.0),
// * -------------------------------------------------- Drag Tab & Close
                  child: SafeArea(
                    top: true,
                    bottom: false,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                      SizedBox(width: 50.0),
                      Align(child: Icon(Icons.drag_handle), alignment: Alignment.center),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close)),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
// * -------------------------------------------------- Stock Info & Notifier Count
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
// * -------------------------------------------------- Symbol / Exchange / Company Name
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
// * -------------------------------------------------- Divider ----------------------------------------------
                Divider(),
// * -------------------------------------------------- Alert section tool bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: Column(
                    children: <Widget>[
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
                                Container(
                                    width: 30.0,
                                    padding: EdgeInsets.all(0.0),
                                    child: IconButton(
                                        onPressed: () {
                                          newNotifier(context, companyName, exchange, symbol, price);
                                        },
                                        icon: Icon(Icons.add))),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),

// * -------------------------------------------------- New alert add button
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    
                    if(symbolCount > 0 || notifierData.notifierHasAlert == true) Container(alignment: Alignment.center, child: Text('Notifier'))
                      
                    else if(symbolCount == 0 || notifierData.notifierHasAlert == false) FlatButton(
                      onPressed: () {
                        newNotifier(context, companyName, exchange, symbol, price);
                      },
                      color: Colours.grey7,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.add,
                              color: Colours.grey10,
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'New Alert'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Colours.grey10,
                              ),
                            ),
                          ],
                        ),
                      )),

                    ],
                  ),
                ),
              ]),
            ],
          );
        });
  }

}


class _SearchState extends State<Search> {

  @override
  Widget build(BuildContext context) {

    // * Application
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: <Widget>[
// * -------------------------------------------------- Underlying Content

        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(0.0, Sizes.searchBarHeight, 0.0, 0.0),
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
          child: Column(
              children: <Widget>[
              FutureBuilder(
                future: widget.getSymbolList(),
                builder: (context, snapshot) {

                  if(snapshot.data == null) return Container();

                  else return Expanded(
                    child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int i) {

                            // * Corrects index
                            int q = i -1;

                            // * Dashboard list icon buttons
                            if(i == 0) return Padding(
                              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[

                                  // TODO Delete me eventually
                                  RaisedButton(onPressed: () {notifierHelperData.readAllSymbols();}, child: Text('Read')),

                                  SizedBox(width: 10.0),

                                  GestureDetector(onTap: () {}, child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(Icons.create, size: 21.0, color: Colors.grey[600],),
                                  )),
                                  GestureDetector(onTap: () {}, child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(Icons.crop_3_2, size: 24.0, color: Colors.grey[600]),
                                  )),
                              ]),
                            );
                            
                            // * Dashboard list
                            else return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 0.0),
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0), color: Colors.grey[200]),
                                padding: EdgeInsets.all(35.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                        // * Symbol title
                                        Text(snapshot.data[q].symbol.toString(),
                                            style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),

                                        // * Company name title
                                        Text(snapshot.data[q].companyname.toString()),

                                      ],
                                    ),
                                    
                                    Container(
                                      height: 25.0,
                                      width: 30.0,
                                      child: Row(children: <Widget>[
                                        // Text(widget.getSymbolCount(snapshot.data[q].symbol).toString()),
                                        ]),
                                    ),

                                  ],
                                ),
                          ),
                        );
                      }
                    ),
                  );
                },
              ),
            ],
          ),
        ),


// * -------------------------------------------------- Search Bar

        SearchBar<StockSearch>(
          searchBarPadding: EdgeInsets.all(5.0),
          onSearch: getStockSearch,
          onItemFound: (StockSearch post, int index) {
            return Column(
              children: <Widget>[
// * -------------------------------------------------- List Stock Tile
                ListTile(
                  onTap: () async {
                    var symbolCount = await widget.getSymbolCount('${post.symbol}') ?? 0;
                    widget.showBottomSheet(context, post.companyname, post.exchange, post.symbol, post.latestprice, symbolCount);
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        //Ticker, Exchange, and Name
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
// * -------------------------------------------------- Symbol & Exchange!
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(post.symbol), //Symbol

                                SizedBox(width: 5.0), //Spacer

// * -------------------------------------------------- Exchange!
                                Expanded(
                                  child: Text(
                                    //Exchange
                                    post.exchange,
                                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                ),
                              ],
                            ),

// * -------------------------------------------------- Company Name!
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(post.latestprice.toString().replaceAll('null', '')), //Stock Price!

                            SizedBox(height: 2.0), //Spacer

                            if (post.changeRendered != 'null')
                              if (post.changeRendered > 0) //Positive Change!
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
                              else if (post.changeRendered < 0) //Negative Change!
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
                              else if (post.changeRendered == 0) //Negative Change!
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
// * -------------------------------------------------- Divider ----------------------------------------------
                Divider(),
              ],
            );
          },
        ),
      
      ]),
    );
  }


// * -------------------------------------------------- API Data!


  Future<List<StockSearch>> getStockSearch(String search) async {
    String symbol;
    await Future.delayed(Duration(seconds: 1));

    var stockSearchSymbolData = await http.get(('https://sandbox.iexapis.com/stable/search/' + '$search' + '?token=Tsk_801c26698a37427898480622dd23e138'));
    var stockSearchSymbolJSONData;

    try {
    stockSearchSymbolJSONData = json.decode(stockSearchSymbolData.body);
    } on FormatException {
      print('search.dart :: FormatException :: JSON is unreadable!');
    }

    List<Symbol> stockSymbolList = [];
    List<StockSearch> stockSearchList = [];

    if(stockSearchSymbolJSONData != null) {
        for (var u in stockSearchSymbolJSONData) {

          // * --------------- This adds in from the first API search -----
          Symbol stockSymbolUpdate = Symbol(u["symbol"]);
          stockSymbolList.add(stockSymbolUpdate);
          symbol = u["symbol"];
          print(symbol);
    
          // * --------------- This gathers the remaining information using a new api request from the symbol list above -----
          var stockSearchData = await http.get(('https://cloud.iexapis.com/stable/stock/' + '$symbol' + '/quote?token=pk_d41c533580ca4184ab59cb764a374bb5'));
          var stockSearchJSONData = json.decode(stockSearchData.body);
    
          if (stockSearchData.statusCode == 200) {
            if (stockSearchJSONData.toString().contains('latestPrice: null') == false) stockSearchList.add(StockSearch.fromJson(stockSearchJSONData));
          }
        }
    } else {
      print('search.dart :: JSON Data is unreadable!');
    }

    // * --------------- This instantiates the data to the UI -----

    return stockSearchList;
  }
}

/*........................................... Program ......................................*/
