import 'package:code_test/provider/employee_provider.dart';
import 'package:code_test/screens/operation_screens/add_employee_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:code_test/constraints/theme.dart' as style;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState()=> _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
        backgroundColor: style.Colors.mainColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              child:const Text('CLEAR ALL',style: TextStyle(
                color: Colors.white,
                fontSize: 16
              ),),
              onPressed: (){
                Provider.of<EmployeeProvider>(context,listen: false).deleteAllEmployees();
              },
            ),
          )
        ],
      ),
      body: Consumer<EmployeeProvider>(
        builder: (context,todo,child){
          return todo.employeeList.isNotEmpty? ListView.builder(
            itemCount: todo.employeeList.length,
            itemBuilder: (_, index){
              return Card(
                child: ListTile(
                  leading: IconButton(
                    onPressed: (){
                      Provider.of<EmployeeProvider>(context,listen: false).deleteEmployee(todo.employeeList[index]);
                    },
                    icon:const Icon(Icons.delete, size: 30,),
                  ),
                  title: Text(todo.employeeList[index].name,style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(todo.employeeList[index].nrc,style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(todo.employeeList[index].position,style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      ),),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder)=> AddEmployeeScreen(true, todo.employeeList[index])));
                    },
                    icon: const Icon(Icons.edit, size: 30,),
                  ),
                ),
              );
            },
          ) :const Center(
            child: Text('No Data'),
          );
        },
      ),
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          backgroundColor: style.Colors.mainColor,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (builder)=> const AddEmployeeScreen(false, null)));
            //Provider.of<EmployeeProvider>(context,listen: false).insertEmployee(Employee(1, "String", 'nrc', 'position'));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}