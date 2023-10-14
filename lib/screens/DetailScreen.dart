import 'package:flutter/material.dart';
import 'package:flutter_conn_database/model/Transactions.dart';
import 'package:intl/intl.dart';


class DetailScreen extends StatefulWidget {
  final Transactions transaction;

  DetailScreen({required this.transaction});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the description controller with the transaction's description
    // _descriptionController.text = widget.transaction.description;
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ประวัติส่วนตัว"),
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 200, // กำหนดความกว้างของ Container
                height: 200, // กำหนดความสูงของ Container
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10.0), // ปรับมุมโค้งของรูปภาพ
                  child: Image.file(
                    widget.transaction.imageFile,
                    width: 200, // ปรับขนาดรูปภาพตามที่คุณต้องการ
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ข้อมูลส่วนตัว",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(95, 47, 46, 46),
                    ),
                  ),
                  Container(
                    child: Material(
                      elevation: 4.0, // ความสูงของเงาด้านนอก
                      borderRadius: BorderRadius.circular(10.0), // เพิ่มขอบมน
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.all(20.0),
                            width: 350,
                            height: null,
                           decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 5),
                            color: Color.fromARGB(255, 255, 189, 211),
                            spreadRadius: 2,
                            blurRadius: 10)
                      ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ขื่อ-สกุล :" + widget.transaction.name,
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                    "รหัสนักศึกษา :" +
                                        widget.transaction.number,
                                    style: TextStyle(fontSize: 18)),
                                    Text("เพศ :" + widget.transaction.gender,
                                    style: TextStyle(fontSize: 18)),
                                Text("สาขา :" + widget.transaction.selectedValue,
                                    style: TextStyle(fontSize: 18)),
                                Text("เกิด :${DateFormat('dd-MM-yyyy').format(widget.transaction.date,)}",
                                    style: TextStyle(fontSize: 18)),
                                Text("เบอร์ :" + widget.transaction.nomo,
                                    style: TextStyle(fontSize: 18)),
                                
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      )
    );
  }
}
