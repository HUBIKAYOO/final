import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conn_database/model/Transactions.dart';
import 'package:flutter_conn_database/providers/Transaction_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final sacaController = TextEditingController();
  final nomoController = TextEditingController();
  final TextEditingController formattedDateController = TextEditingController();

  var gender = "";

  File? _imageFile; // เพิ่มตัวแปร _imageFile
  final ImagePicker _imagePicker = ImagePicker(); // เพิ่มตัวแปร _imagePicker

  // คำสั่งยืนยันรูปภาพและเปลี่ยนสถานะตัวแปร _imageFile
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // คำสั่งเคลียร์รูปภาพที่ถูกเลือก
  void _clearImage() {
    setState(() {
      _imageFile = null;
    });
  }

  DateTime _dataTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  void _showDataPicker() {
    showDatePicker(
      context: context,
      initialDate: _dataTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      if (value != null) {
        setState(() {
          _dataTime = value;
          formattedDateController.text =
              DateFormat('dd-MM-yyyy').format(_dataTime);
        });
      }
    });
  }

  String selectedValue = 'สาขา'; // ค่าเริ่มต้น

  // รายการข้อมูลที่จะใช้ใน Dropdown
  List<String> items = [
    'สาขา',
    'สาขาวิทยาการคอมพิวเตอร์',
    'สาขาเทคโนโลยีสารสนเทศ',
    'สาขาคอมพิวเตอร์ ค.บ. '
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "เพิ่มนักศึกษา",
          style: TextStyle(color: Color.fromARGB(255, 44, 44, 44)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          // key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        _pickImage(); // เมื่อคลิกที่ภาพเพื่อเลือกรูป
                      },
                      child: Stack(
                        children: [
                          _imageFile != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      10), // เพิ่มขอบโค้งของรูปภาพ
                                  child: Image.file(
                                    _imageFile!,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit
                                        .cover, // ปรับขนาดรูปภาพให้พอดีกับ Container
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      10), // เพิ่มขอบโค้งของ Container
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    color: Color.fromARGB(255, 255, 193, 213),
                                    child: Center(
                                      child: Icon(
                                        Icons.add_photo_alternate,
                                        color:
                                            Color.fromARGB(255, 255, 75, 135),
                                        size: 100,
                                      ),
                                    ),
                                  ),
                                ),
                          if (_imageFile != null)
                            Positioned(
                              top: 3, // ระยะขอบบนของรูปภาพ
                              right: 3, // ระยะขอบซ้ายของรูปภาพ
                              child: InkWell(
                                onTap: _clearImage,
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                controller: nameController, // Connect the controller
                decoration: InputDecoration(labelText: "ชื่อ-สกุล"),
                keyboardType: TextInputType.name,
              ),
              TextFormField(
                controller: numberController, // Connect the controller
                decoration: InputDecoration(labelText: "รหัสนักศึกษา"),
                keyboardType: TextInputType.number,
              ),
              Text("เพศ"),
              Row(
                children: <Widget>[
                  Radio(
                    value: "ชาย",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                  Text("ชาย"),
                  Radio(
                    value: "หญิง",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                  Text("หญิง"),
                ],
              ),
              Row(
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
                  // SizedBox(height: 20.0),
                  // Text(
                  //   'คุณเลือก: $selectedValue',
                  //   style: TextStyle(fontSize: 18.0),
                  // ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
              ),
              TextFormField(
                controller: formattedDateController,
                decoration: InputDecoration(
                  labelText: "เกิดวัน/เดือน/ปี",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                textAlign: TextAlign.center,
                onTap: () {
                  _showDataPicker();
                },
              ),
              TextFormField(
                controller: nomoController, // Connect the controller
                decoration: InputDecoration(labelText: "เบอร์"),
                keyboardType: TextInputType.number,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 75, 135),
                  minimumSize: Size(400, 50),
                ),
                onPressed: () {
                  var name = nameController.text;
                  var number = numberController.text;
                  var nomo = nomoController.text;
                  var date = _dataTime;

                  Transactions statement = Transactions(
                      imageFile: _imageFile,
                      name: name,
                      number: number,
                      nomo: nomo,
                      date: date,
                      selectedValue: selectedValue,
                      gender: gender);
                  var provider =
                      Provider.of<TransactionProvider>(context, listen: false);
                  provider.addTransaction(statement);
                  Navigator.pop(context);
                },
                child: Text(
                  "บันทึก",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      )
    );
  }
}
