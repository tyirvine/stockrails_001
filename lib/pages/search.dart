import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:stockrails_001/classes/stockSearch.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SearchBar<StockSearch>(
            onSearch: getStockSearch,
            onItemFound: (StockSearch post, int index) {
              return ListTile(
                title: Text(post.ticker),
                subtitle: Text(post.exchange),
              );
            },
          ),
        ),
      ),
    );
  }

    Future<List<StockSearch>> getStockSearch(String search) async {

      await Future.delayed(Duration(seconds: 1));

      var stockSearchData = await http.get( ('https://sandbox.iexapis.com/stable/search/' + '$search' + '?token=Tsk_801c26698a37427898480622dd23e138') );
      var stockSearchJSONData = json.decode(stockSearchData.body);

      print(stockSearchData.toString());

      List<StockSearch> stockSearchList = [];

      for (var s in stockSearchJSONData) {
        StockSearch stockSearchUpdate = StockSearch(s["symbol"], s["exchange"]);
        stockSearchList.add(stockSearchUpdate);
      }

      return stockSearchList;
      
  }
}






