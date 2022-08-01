import 'package:code_test/screens/base.account/otp_confirm_screen.dart';
import 'package:code_test/screens/base.account/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:code_test/constraints/theme.dart' as style;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState()=> _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 300,
                    height: 300,
                    child: Image(image: AssetImage('assets/image/login_vector.jpg'),),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    validator: (value){
                      if(value!.isEmpty) {
                        return 'Phone Number must not be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone) ,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      )
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()) {
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=> const OtpConfirmScreen('login')));
                        }
                      },
                      child: const Text('Login',style: TextStyle(
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
                    )
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't you have an account?",style: TextStyle(
                        fontSize: 16
                      ),),
                      const SizedBox(
                        width: 12,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=> const RegisterScreen()));
                        },
                        child: const Text('Register',style: TextStyle(
                          color: style.Colors.mainColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}