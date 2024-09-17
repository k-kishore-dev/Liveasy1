import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:dummy/otp.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  String phoneNumber = '';
  String verificationId = '';
  bool isLoading = false;

  Future<void> verifyPhoneNumber() async {
    setState(() {
      isLoading = true;
    });

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-sign in the user
        await FirebaseAuth.instance.signInWithCredential(credential);
        setState(() {
          isLoading = false;
        });
        // Navigate or show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Phone number automatically verified and signed in!')),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          isLoading = false;
        });
        String errorMessage = 'Something went wrong';
        if (e.code == 'invalid-phone-number') {
          errorMessage = 'The phone number entered is invalid!';
        } else if (e.code == 'too-many-requests') {
          errorMessage = 'Too many requests. Please try again later.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      },
      codeSent: (String verId, int? resendToken) {
        setState(() {
          verificationId = verId;
          isLoading = false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyOtp(
              verificationId: verificationId,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verId) {
        setState(() {
          verificationId = verId;
        });
      },
      timeout: const Duration(seconds: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Please Enter your mobile number',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'You will receive a 6-digit code \n to verify next.',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              IntlPhoneField(
                decoration: const InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    )),
                onChanged: (phone) {
                  setState(() {
                    phoneNumber = phone.completeNumber;
                  });
                },
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (phoneNumber.isNotEmpty) {
                      verifyPhoneNumber();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a valid phone number')),
                      );
                    }
                  },
                  child: const Text('Continue'),
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