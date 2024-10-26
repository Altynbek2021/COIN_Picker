import 'package:bitcoin_tickerr/coin_data.dart';
import 'package:bitcoin_tickerr/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:http/http.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "USD";
  String rateState = '';
  bool isLoaded = true;

  DropdownButton<String> getDropDownBtn() {
    return DropdownButton(
        value: selectedCurrency,
        items: currenciesList.map((currency) {
          return DropdownMenuItem(
            value: currency,
            child: Text(
              currency,
              style: TextStyle(color: Colors.white),
            ),
          );
        }).toList(),
        onChanged: (val) {
          setState(() {
            NetworkHelper();
            selectedCurrency = val!;
          });
        });
  }

  Widget getIosPicker() {
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (value) {
        setState(() {
          selectedCurrency = currenciesList[value];
        });
      },
      children: currenciesList.map((String currency) {
        return Text(currency);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: isLoaded
                ? Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            isLoaded = false;
                          });
                          NetworkHelper jgs = NetworkHelper();
                          String rate = await jgs.getData();
                          print("rate == $rate");
                          setState(() {
                            rateState = rate;
                            isLoaded = true;
                          });
                        },
                        child: Text(
                          '1 BTC =  $rateState USD',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                : Text(
                    "Loading...",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isLinux ? getDropDownBtn() : getIosPicker()),
        ],
      ),
    );
  }
}
