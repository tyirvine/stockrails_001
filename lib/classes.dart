


class StockSearch {
    
  String symbol;
  String exchange;
  String companyname;
  
  var latestpriceCorrected;
  var changeCorrected; 
  var changeRendered;
  
  var latestprice;
  var change;


  StockSearch(this.symbol, this.exchange, this.companyname, this.latestprice, this.latestpriceCorrected, this.changeCorrected, this.changeRendered, this.change);

  @override toString() => '$symbol';

  StockSearch.fromJson(Map<String, dynamic> json) {
    symbol = json["symbol"];
    exchange = json["primaryExchange"];
    companyname = json["companyName"];

    latestpriceCorrected = json["latestPrice"];

    if(latestpriceCorrected > 1) latestprice = json["latestPrice"].toDouble().toStringAsFixed(2);
    if(latestpriceCorrected <= 1) latestprice = json["latestPrice"].toDouble().toStringAsFixed(3);

    change = json["change"];
    
    changeRendered =json["change"];
    changeCorrected = json["change"]?.abs();

    if(changeCorrected != null && changeRendered != null ) {
      if(changeCorrected > 1) change = json["change"].toDouble().toStringAsFixed(2);
      if(changeCorrected == 0) change = json["change"].toDouble().toStringAsFixed(2);
      if( changeCorrected <= 1 && changeCorrected >= 0.05 ) change = json["change"].toDouble().toStringAsFixed(3);
      if( changeCorrected <= 0.05 && changeCorrected != 0.0 ) change = json["change"].toDouble().toStringAsFixed(4);
    }
    else {
      changeCorrected = 0.0;
      changeRendered = 0.0;
    }
  }
}




class Symbol {

  final String symbol;

  Symbol(this.symbol);

  @override toString() => '$symbol';

}