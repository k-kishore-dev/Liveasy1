import 'package:dummy/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyOtp extends StatefulWidget {
  final String verificationId;

  const MyOtp({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());

  String getOtp() {
    return _otpControllers.map((controller) => controller.text).join();
  }

  // Function to verify OTP
  Future<void> verifyOtp() async {
    final otp = getOtp();
    if (otp.length == 6) {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      try {
        await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.pushReplacementNamed(context, 'home');
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid OTP. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a 6-digit OTP.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Verify Phone",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  "Code is sent to your number",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
                Form(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(6, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SizedBox(
                          height: 68,
                          width: 64,
                          child: TextField(
                            controller: _otpControllers[index],
                            style: Theme.of(context).textTheme.headlineLarge,
                            keyboardType: TextInputType.number,
                            inputFormatters: [LengthLimitingTextInputFormatter(1)],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              filled: true,
                              fillColor: Colors.blue,
                              contentPadding: const EdgeInsets.all(16.0),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: verifyOtp,
                  child: const Text('Verify'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                ElevatedButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyProfile(),
                    ),
                  );
                }, child: const Text("Next"),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
