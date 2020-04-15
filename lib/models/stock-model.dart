

// * StockSearch : This class is the supplementary to Symbol ~ it handles the core stock parsing
class StockSearch {
    
  // Identifiers
  String symbol;
  String exchange;
  String companyname;
  
  // Pricing
  var latestprice;
  var change;

  // Pricing Corrected
  var latestpriceCorrected;
  var changeCorrected; 
  var changeRendered;
  
  // Constructor for StockSearch
  StockSearch(this.symbol, this.exchange, this.companyname, this.latestprice, this.latestpriceCorrected, this.changeCorrected, this.changeRendered, this.change);

  // This overrides the .toString() function making it possible to display strings
  @override toString() => '$symbol';

  // .fromJson is a function that parses all the JSON data 
  StockSearch.fromJson(Map<String, dynamic> json) {

    // Identifiers
    symbol = json["symbol"];
    exchange = json["primaryExchange"];
    companyname = json["companyName"];

    // Latest Pricing Corrected
    latestpriceCorrected = json["latestPrice"];

    // Latest Pricing Corrected parsing blocks
    if(latestpriceCorrected > 1) latestprice = json["latestPrice"].toDouble().toStringAsFixed(2);
    if(latestpriceCorrected <= 1) latestprice = json["latestPrice"].toDouble().toStringAsFixed(3);

    // Change Corrected
    change = json["change"];
    changeRendered =json["change"];
    changeCorrected = json["change"]?.abs();

    // Change Corrected parsing blocks
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

// * Symbol : This class is used by the search bar to create a list of symbols to then be used by the StockSearch class to provide more data about each symbol
class Symbol {

  // Holds symbol string data
  final String symbol;

  // Constructor for symbol class
  Symbol(this.symbol);

  // Overrides .toString() in order to properly display string
  @override toString() => '$symbol';

}