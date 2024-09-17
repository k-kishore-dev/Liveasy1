import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String profile = 'None selected';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        children: [
          const SizedBox(height:50,width: 40),
        Text('Select:$profile'),
        SizedBox(
          width: 200,
          child: RadioMenuButton(
            value: 'Shipper',
            groupValue: profile,
            onChanged: (selectedValue) {
              setState(() =>profile=selectedValue!);
            },
            style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                elevation: const MaterialStatePropertyAll(2),
                backgroundColor: const MaterialStatePropertyAll(Colors.white)),
            child:Row(
              children: [
                const SizedBox(width: 10),
                const Text('Shipper'),
            ],

            ),
          ),
        ),
          SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: RadioMenuButton(
              value: 'Transporter',
              groupValue: profile,
              onChanged: (selectedValue) {
                setState(() =>profile=selectedValue!);
              },
              style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  elevation: const MaterialStatePropertyAll(2),
                  backgroundColor: const MaterialStatePropertyAll(Colors.white)),
              child:Row(
                children: [
                  const SizedBox(width: 10),
                  const Text('Transporter'),
                ],

              ),
            ),
          ),
      ],),
    ),);
  }
}
