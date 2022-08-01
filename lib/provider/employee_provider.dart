import 'package:code_test/model/employee.dart';
import 'package:flutter/material.dart';

class EmployeeProvider with ChangeNotifier {
  final List<Employee> _employeeList = [];

  List<Employee> get employeeList => _employeeList;

  void insertEmployee(String name, String nrc, String position) {
    _employeeList.add(Employee(_employeeList.length, name, nrc, position));
    notifyListeners();
  }

  void deleteEmployee(Employee employee) {
    _employeeList.remove(employee);
    notifyListeners();
  }

  void deleteAllEmployees() {
    _employeeList.clear();
    notifyListeners();
  }

  void updateEmployee(int i, Employee employee) {
    _employeeList[i] = employee;
    //_employeeList.replaceRange(i, i, [employee]);
    notifyListeners();
  }
}