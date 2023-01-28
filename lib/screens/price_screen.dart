// ignore_for_file: avoid_print

import 'package:bitcoin_ticker_app/services/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "AUD";
  Map<String, String> currentPrice = {};

  // dropdown items for Android Material
  DropdownButton<String> androidDropdown() {
    // prepare an empty list
    List<DropdownMenuItem<String>> dropdownItems = [];

    // store each item to the list
    for (String currency in currenciesList) {
      DropdownMenuItem<String> newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );

      dropdownItems.add(newItem);
    }

    // return Dropdown Widget with data
    return DropdownButton<String>(
      value: selectedCurrency, // selected
      items: dropdownItems, // menu
      onChanged: ((value) {
        setState(() {
          selectedCurrency = value!;

          getPrice();
        });
      }),
    );
  }

  CupertinoPicker iosPicker() {
    // prepare an empty list
    List<Text> listItems = [];

    // store each item to the list
    for (String currency in currenciesList) {
      listItems.add(Text(currency));
    }

    // return the Picker Widget with data
    return CupertinoPicker(
      itemExtent: 32, // height of items
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];

          getPrice();
        });
      },
      children: listItems, // menu
    );
  }

  void getPrice() async {
    try {
      Map<String, String> data = await CoinData().getCoinData(selectedCurrency);

      setState(() {
        currentPrice = data;
      });
    } catch (e) {
      print(e);
    }
  }

  List<CryptoCard> cryptoCardList() {
    List<CryptoCard> list = [];

    for (String crypto in cryptoList) {
      list.add(
        CryptoCard(
            crypto: crypto,
            currentPrice:
                currentPrice[crypto] != null ? currentPrice[crypto]! : '?',
            selectedCurrency: selectedCurrency),
      );
    }

    return list;
  }

  @override
  void initState() {
    super.initState();

    getPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: cryptoCardList(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key? key,
    required this.crypto,
    required this.currentPrice,
    required this.selectedCurrency,
  }) : super(key: key);

  final String crypto;
  final String currentPrice;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 28.0,
          ),
          child: Text(
            '$crypto = $currentPrice $selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
