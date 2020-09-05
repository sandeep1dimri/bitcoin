import 'package:flutter/material.dart';
import 'currency_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String dropDownSelectedValue = 'USD';

  List<DropdownMenuItem> buildDropDownList() {
    List<DropdownMenuItem<String>> dropDownList = [];
    for (String currType in currencyType) {
      var temp = DropdownMenuItem(
        child: Text(currType),
        value: currType,
      );
      dropDownList.add(temp);
    }
    return dropDownList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("🤑 Coin Ticker")),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
            child: Card(
              color: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                child: Text(
                  "1 BTC= ? CAD",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            padding: EdgeInsets.only(bottom: 30),
            alignment: Alignment.center,
            color: Colors.blue,
            child: DropdownButton<String>(
              value: dropDownSelectedValue,
              items: buildDropDownList(),
              onChanged: (value) {
                setState(() {
                  dropDownSelectedValue = value;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
