import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('DropdownButton ตัวอย่าง'),
        ),
        body: MyDropdownButton(),
      ),
    );
  }
}

class MyDropdownButton extends StatefulWidget {
  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String selectedValue = 'เลือกข้อมูล'; // ค่าเริ่มต้น

  // รายการข้อมูลที่จะใช้ใน Dropdown
  List<String> items = ['เลือกข้อมูล', 'ข้อมูล 1', 'ข้อมูล 2', 'ข้อมูล 3'];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DropdownButton<String>(
            value: selectedValue, // ค่าที่เลือก
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue!;
              });
            },
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 20.0),
          Text(
            'คุณเลือก: $selectedValue',
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}



