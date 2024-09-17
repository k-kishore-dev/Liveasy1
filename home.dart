import 'package:dummy/phoneno.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String? language;
  List<String> list = ['English', 'Hindi'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 25, right: 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/imageicon.png',
                width: 42,
                height: 42,
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'Please select your Language',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'You can change the language \n at any time',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black, width: 2),
                  borderRadius:
                      BorderRadius.circular(0),
                ),
                child: DropdownButton<String>(
                  hint: Text('Select Language'),
                  dropdownColor: Colors.white,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 20,
                  isExpanded: false,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                  value: language,
                  onChanged: (newValue) {
                    setState(() {
                      language = newValue!;
                    });
                  },
                  items: list.map((String language) {
                    return DropdownMenuItem<String>(
                      value: language,
                      child: Text(language),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 50,
                width: 210,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyPhone(),
                      ),
                    );
                  },
                  child: const Text(
                    'NEXT',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.indigo[900],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
