import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'currency_data.dart';
import 'dart:io' show Platform; // or hide if need any class
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String dropDownSelectedValue = 'USD';
  String cadValue = '?';
  var _cryptoToRegConversion = {};
  CryptoToRegular cryptoToReg = CryptoToRegular();
  _PriceScreenState() {
    print("Construct!!!!");
    _cryptoToRegConversion = cryptoToReg.convertCryptoToRegularBP();
  }
  void convertCryptoToRegular() async {
    _cryptoToRegConversion = await cryptoToReg.convertCryptoToRegular(
        currencyType: dropDownSelectedValue);
  }

  DropdownButton<String> buildDropDownListAndroid() {
    List<DropdownMenuItem<String>> dropDownList = [];
    for (String currType in currencyType) {
      var temp = DropdownMenuItem(
        child: Text(currType),
        value: currType,
      );
      dropDownList.add(temp);
    }
    //return dropDownList;
    return DropdownButton<String>(
      value: dropDownSelectedValue,
      items: dropDownList,
      onChanged: (value) async {
        _cryptoToRegConversion =
            await cryptoToReg.convertCryptoToRegular(currencyType: value);
        //print(rateValue);
        setState(() {
          this.dropDownSelectedValue = value;
          //this.cadValue = rateValue;
        });
      },
    );
  }

  //user Cupertino picker for iOS
  CupertinoPicker buildDropDownListiOS() {
    List<Text> dropDownListiOS = [];
    for (String currType in currencyType) {
      dropDownListiOS.add(Text(
        currType,
        style: TextStyle(color: Colors.white),
      ));
    }

    //return dropDownListiOS;
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 30,
      children: dropDownListiOS, //[Text('USD'), Text('CAD')],
      onSelectedItemChanged: (selectedIndex) async {
        //print(currencyType[selectedIndex]);
        // var rateValue = await conversionRate(
        //     cryptoCurr: "BTC", regularCurrency: currencyType[selectedIndex]);
        _cryptoToRegConversion = await cryptoToReg.convertCryptoToRegular(
            currencyType: currencyType[selectedIndex]);
        setState(() {
          //this.cadValue = rateValue;
          this.dropDownSelectedValue = currencyType[selectedIndex];
        });
      },
    );
  }

  List<Padding> cardsOnScreen({String crypoCurr}) {
    List<Padding> cardsOnScreen = [];
    for (String crypoType in cryptoList) {
      Padding newCard = Padding(
        padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
        child: Card(
          color: Colors.lightBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            child: Text(
              //'1 $crypoType= $cadValue $crypoCurr',
              '1 $crypoType= ' +
                  _cryptoToRegConversion[crypoType] +
                  ' ' +
                  crypoCurr,
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
      cardsOnScreen.add(newCard);
    }
    return cardsOnScreen;
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
          for (Padding each in cardsOnScreen(crypoCurr: dropDownSelectedValue))
            each,
          Container(
            height: 150,
            padding: EdgeInsets.only(bottom: 30),
            alignment: Alignment.center,
            color: Colors.lightBlue,
            child: Platform.isIOS
                ? buildDropDownListiOS()
                : buildDropDownListAndroid(),
          )
        ],
      ),
    );
  }
}
