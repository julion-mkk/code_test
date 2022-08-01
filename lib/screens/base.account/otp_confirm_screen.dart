import 'package:code_test/screens/base.account/confirm_password_screen.dart';
import 'package:code_test/screens/base.account/password_enter_screen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:code_test/constraints/theme.dart' as style;

class OtpConfirmScreen extends StatefulWidget {
  final String screenName;
  const OtpConfirmScreen(this.screenName,{Key? key}) : super(key: key);
  @override
  _OtpConfirmScreenState createState()=> _OtpConfirmScreenState();
}

class _OtpConfirmScreenState extends State<OtpConfirmScreen> {
  String _otpCode = '';
  final _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 250,
              height: 250,
              child: Image(image: AssetImage('assets/image/otp_verification.png'),),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('OTP Verification',style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 330,
              height: 70,
              child: PinCodeTextField(
                keyboardType: TextInputType.number,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  inactiveColor: style.Colors.mainColor,
                  borderRadius: BorderRadius.circular(5),
                  shape: PinCodeFieldShape.box,
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white
                ),
                animationDuration: const Duration(microseconds: 30),
                controller: _otpController,
                onChanged: (value){
                  setState(() {
                    _otpCode = value;
                  });
                },appContext: context,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              height: 55,
              child: ElevatedButton(
                onPressed: (){
                  _verifyPin();
                },
                child: const Text('Verify',style: TextStyle(
                    fontSize: 16
                ),),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(style.Colors.mainColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _verifyPin() {
    if(_otpCode.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Complete the otp code')));
    } else {
      if(widget.screenName == 'login') {
        Navigator.push(context, MaterialPageRoute(builder: (builder)=> const PasswordEnterScreen()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (builder)=> const ConfirmPasswordScreen()));
      }
    }

  }
}