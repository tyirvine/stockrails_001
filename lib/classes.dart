
class StockSearch {
    
  String symbol;
  String exchange;
  String companyname;
  var latestprice;
  var change;

  StockSearch(this.symbol, this.exchange, this.companyname, this.latestprice, this.change);

  @override toString() => '$symbol';

  StockSearch.fromJson(Map<String, dynamic> json) {
    symbol = json["symbol"];
    exchange = json["primaryExchange"];
    companyname = json["companyName"];
    latestprice = json["latestPrice"];
    change = json["change"];
  }

}


class Symbol {

  final String symbol;

  Symbol(this.symbol);

  @override toString() => '$symbol';

}