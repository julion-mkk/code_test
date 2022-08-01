import 'package:code_test/screens/operation_screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:code_test/constraints/theme.dart' as style;

class PasswordEnterScreen extends StatefulWidget {
  const PasswordEnterScreen({Key? key}) : super(key: key);

  @override
  _PasswordEnterScreenState createState()=> _PasswordEnterScreenState();
}

class _PasswordEnterScreenState extends State<PasswordEnterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    //_loadData();
  }

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
                    obscureText: _isObscure,
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
                            _isObscure = !_isObscure;
                          });
                        },
                        icon: Icon(_isObscure? Icons.visibility : Icons.visibility_off),
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
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=> const MainScreen()));
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