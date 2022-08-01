import 'package:code_test/screens/operation_screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:code_test/constraints/theme.dart' as style;

class ConfirmPasswordScreen extends StatefulWidget {
  const ConfirmPasswordScreen({Key? key}) : super(key: key);

  @override
  _ConfirmPasswordScreenState createState()=> _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  bool _isObscurePassword = true;
  bool _isObscureConfirm = true;
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
                    child: Image(image: AssetImage('assets/image/password_vector.png'),),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _isObscurePassword,
                    validator: (value){
                      if(value!.isEmpty) {
                        return 'Password must not be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock) ,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            _isObscurePassword = !_isObscurePassword;
                          });
                        },
                        icon: Icon(_isObscurePassword? Icons.visibility: Icons.visibility_off),
                      )
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _passwordConfirmController,
                    obscureText: _isObscureConfirm,
                    validator: (value){
                      if(value!.isEmpty) {
                        return 'Password must not be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: const Icon(Icons.lock) ,
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            _isObscureConfirm = !_isObscureConfirm;
                          });
                        },
                        icon: Icon(_isObscureConfirm? Icons.visibility: Icons.visibility_off),
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
                            if(_passwordController.text == _passwordConfirmController.text) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=> const MainScreen()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passwords are not match. Try Again')));
                            }
                          }
                        },
                        child: const Text('Confirm',style: TextStyle(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}