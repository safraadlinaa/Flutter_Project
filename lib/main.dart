// import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CityHall',
      home: Scaffold(
        body: MyHomePage(
          title: 'Welcome to CityHall',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? dropdownvalue;
  var items = ['Female', 'Male', 'Other'];

  final myControllerName = TextEditingController();
  final myControllerEmail = TextEditingController();
  final myControllerPassword = TextEditingController();

  bool isDisabled = true;

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myControllerName.addListener(_isFilled);
    myControllerEmail.addListener(_isFilled);
    myControllerPassword.addListener(_isFilled);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _isFilled listener.
    myControllerName.dispose();
    myControllerEmail.dispose();
    myControllerPassword.dispose();
    super.dispose();
  }

  // enable or disable sign up button
  void _isFilled() {
    setState(() {
      if (myControllerName.text != "" &&
          myControllerEmail.text != "" &&
          myControllerPassword.text != "" &&
          dropdownvalue != null) {
        isDisabled = false;
      } else {
        isDisabled = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to CityHall'),
        ),
        body: ListView(
          children: <Widget>[
            InkWell(
              child: Image(
                width: 250,
                height: 230,
                image: NetworkImage(
                    'https://www.pngkit.com/png/detail/301-3012189_government-action-council-cartoon-city-hall-building.png'),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter your name'),
              controller: myControllerName,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter your email'),
              controller: myControllerEmail,
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your password'),
              controller: myControllerPassword,
            ),
            DropdownButton(
              value: dropdownvalue,
              icon: Icon(Icons.keyboard_arrow_down),
              items: items.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
              hint: Text('Select your gender'),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue;
                });
              },
            ),
            ElevatedButton(
              onPressed: isDisabled
                  ? null
                  : () {
                      final snackBar = SnackBar(
                        content: const Text('You have signed Up!'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
