import 'package:code_test/model/employee.dart';
import 'package:code_test/provider/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:code_test/constraints/theme.dart' as style;
import 'package:provider/provider.dart';
class AddEmployeeScreen extends StatefulWidget {
  final bool isEdit;
  final Employee? employee;
  const AddEmployeeScreen(this.isEdit, this.employee,{Key? key}) : super(key: key);

  @override
  _AddEmployeeScreenState createState()=> _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nrcController = TextEditingController();
  final _positionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() {
    if(widget.employee != null) {
      _nameController.text = widget.employee!.name;
      _nrcController.text = widget.employee!.nrc;
      _positionController.text = widget.employee!.position;
    }
    /*if(widget.employee!.name !=null) {
      _nameController.text = widget.name!;
    }
    if(widget.nrc !=null) {
      _nrcController.text = widget.nrc!;
    }
    if(widget.position != null) {
      _positionController.text = widget.position!;
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isEdit? const Text('Edit Employee') : const Text('Add Employee'),
        backgroundColor: style.Colors.mainColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  validator: (value){
                    if(value!.isEmpty) {
                      return 'Name must not be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Name*',
                      prefixIcon: Icon(Icons.person) ,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                      labelText: 'NRC*',
                      prefixIcon: Icon(Icons.credit_card) ,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _positionController,
                  validator: (value){
                    if(value!.isEmpty) {
                      return 'Position must not be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Position*',
                      prefixIcon: Icon(Icons.accessibility) ,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding:const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        height: 90,
        child: ElevatedButton(
          onPressed: (){
            addOrEditEmployee();
          },
          child: Text(widget.isEdit? 'Edit' : 'Add',style: const TextStyle(
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

  addOrEditEmployee() {
    if(widget.isEdit) {
      Provider.of<EmployeeProvider>(context,listen: false).updateEmployee(widget.employee!.id, Employee(widget.employee!.id, _nameController.text, _nrcController.text, _positionController.text));
    } else {
      Provider.of<EmployeeProvider>(context,listen: false).insertEmployee(_nameController.text,_nrcController.text,_positionController.text);
    }
    Navigator.pop(context);
  }
}