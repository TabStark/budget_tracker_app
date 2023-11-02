import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(
                  255, 2, 249, 130)), //const Color.fromARGB(255, 2, 249, 130)
          useMaterial3: true),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final amountfield = TextEditingController();
  var items = TextEditingController();
  final pricereset = TextEditingController();
  num itemPrice = 0;
  num initAmount = 0;
  num initAmountSum = 0;
  num addBillAmount = 0;
  var itemStore = [];
  var priceStore = [];
  var priceuse = [];
  var initAmountTrack = [];

  num showBalance = 0;
  num DisplayBalance = 0;
  num mainAmount = 0;

  void _initvalue() {
    setState(() {
      initAmountTrack.add(initAmount);
      initAmountSum += initAmount;

      amountfield.clear();
      print('${initAmountSum}');
      mainAmount = initAmountSum - DisplayBalance;
      // print('${initAmount}');
    });
  }

  void _combine() {
    if (items.text == "") {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text(
                  "WARNING!",
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                content: const Text("Please Fill the Required Details",
                    style: TextStyle(fontSize: 20)),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("OK",
                          style: TextStyle(fontSize: 20, color: Colors.blue)))
                ],
              ));
    } else {
      itemStore.add(items.text);
      priceStore.add(itemPrice);
      priceuse.add(itemPrice);
      print("${itemStore}:${priceStore}");
      items.clear();
      pricereset.clear();

      priceuse.forEach((e) {
        showBalance += e;
      });
      priceuse.clear();
      DisplayBalance += showBalance;
      showBalance = 0;
      mainAmount = initAmountSum - DisplayBalance;
      print("${priceStore}");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Budget Tracker"),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 30, bottom: 30, right: 10, left: 10),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // INITIAL AMOUNT DISPLAY
                  Container(
                    child: Column(
                      children: [
                        Container(
                          child: Text("Balance Amount",
                              style: TextStyle(fontSize: 18)),
                        ),
                        Container(
                          child: Text(
                            '₹${mainAmount}',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),

                  //  ADD INITIAL AMOUNT
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Text("Add Initial Amount",
                            style: TextStyle(fontSize: 18)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              // <-- SEE HERE
                              width: 250,
                              height: 50,
                              child: TextField(
                                controller: amountfield,
                                onChanged: (value) {
                                  setState(() {
                                    initAmount = num.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                    labelText: 'Enter Initail Amount',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                            width: 2))),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: 120,
                              child: ElevatedButton(
                                onPressed: _initvalue,
                                child: Text(
                                  "ADD",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(11)),
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  // ADD ITEM & PRICE
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Text("Add Item and Price",
                            style: TextStyle(fontSize: 18)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 250,
                              height: 50,
                              child: TextField(
                                controller: items,
                                decoration: InputDecoration(
                                    labelText: 'Enter Items',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                            width: 2))),
                                keyboardType: TextInputType.name,
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              height: 50,
                              child: TextField(
                                controller: pricereset,
                                onChanged: (value) {
                                  setState(() {
                                    itemPrice = num.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                    labelText: "Enter Price",
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                            width: 2))),
                                keyboardType: TextInputType.number,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _combine,
                              child: Text(
                                "Add itmes",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(11)),
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary),
                            ))
                      ],
                    ),
                  ),

                  // SHOW ITEM PRICE

                  Padding(padding: EdgeInsets.only(top: 30)),
                  Container(
                    child: Text(
                      "List Items",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    height: 230,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            width: 3),
                        borderRadius: BorderRadius.circular(5)),
                   
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text(
                            '${index + 1}',
                            style: TextStyle(fontSize: 15),
                          ),
                          title: Text(
                            "${itemStore[index]}",
                            style: TextStyle(fontSize: 18),
                          ),
                          trailing: Text("₹${priceStore[index]}",
                              style: TextStyle(fontSize: 18)),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 2,
                          height: 20,
                        );
                      },
                      itemCount: itemStore.length,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Bill Amount:"),
                        Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  width: 3),
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            '₹${DisplayBalance}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
