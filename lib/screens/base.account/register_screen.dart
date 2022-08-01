import 'dart:convert';
import 'dart:io';

import 'package:code_test/screens/base.account/otp_confirm_screen.dart';
import 'package:flutter/material.dart';
import 'package:code_test/constraints/theme.dart' as style;
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState()=> _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _nrcController = TextEditingController();
  final List<String> _base64ImgList = [];
  final _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: ()=> FocusScope.of(context).requestFocus(FocusNode()),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: const Text('Sign In',style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _nameController,
                  validator: (value){
                    if(value!.isEmpty) {
                      return 'Name must not be empty';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person) ,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      )
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _phoneNoController,
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
                TextFormField(
                  controller: _nrcController,
                  validator: (value){
                    if(value!.isEmpty) {
                      return 'NRC must not be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'NRC',
                      prefixIcon: Icon(Icons.credit_card) ,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      )
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async{
                          await _getImage();
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: style.Colors.mainColor),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.add,color: style.Colors.mainColor, size: 30,),
                                SizedBox(
                                  width: 80,
                                  child: Text('Add Photo',style: TextStyle(
                                      color: style.Colors.mainColor,
                                      fontSize: 16
                                  ),),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      _base64ImgList.isNotEmpty? SizedBox(
                        height: 150,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: _base64ImgList.length,
                          itemBuilder: (_,index){
                            return Row(
                              children: [
                                Image.memory(const Base64Decoder().convert(_base64ImgList[index]),width: 150, height: 150,fit: BoxFit.cover, gaplessPlayback: true,),
                                const SizedBox(
                                  width: 15,
                                )
                              ],
                            );
                          },
                        ),
                      ): Container()
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        height: 90,
        child: ElevatedButton(
          onPressed: (){
            if(_formKey.currentState!.validate() ) {
              if(_base64ImgList.isNotEmpty) {
                Navigator.push(context, MaterialPageRoute(builder: (builder)=> const OtpConfirmScreen(('register'))));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add NRC Photos')));
              }
            }
          },
          child: const Text('Register',style: TextStyle(
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
      ),
    );
  }

  _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if(pickedFile!=null) {
      File file = File(pickedFile.path);
      final bytes = file.readAsBytesSync();
      setState(() {
        _base64ImgList.add(base64Encode(bytes));
      });
    }
  }
}