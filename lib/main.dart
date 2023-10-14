import 'package:flutter/material.dart';
import 'package:flutter_conn_database/model/Transactions.dart';
import 'package:flutter_conn_database/providers/Transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_conn_database/screens/form_screen.dart';
import 'package:flutter_conn_database/screens/DetailScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        })
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.pink),
        home: const MyHomePage(
          title: 'YRU',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FormScreen();
                }));
              },
              icon: Icon(Icons.add),
            )
          ],
        ),
        body:
            Consumer(builder: (context, TransactionProvider provider, widget) {
          var count = provider.transactions.length;
          if (count <= 0) {
            return Center(
              child: Text(
                "ไม่พบข้อมูล",
                style: TextStyle(fontSize: 20),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: provider.transactions.length,
                itemBuilder: (context, int index) {
                  Transactions data = provider.transactions[index];
                  return Container(
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
                    margin: const EdgeInsets.all(3.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 28,
                        child: ClipOval(
                          child: SizedBox(
                            width: 200, // ขนาดของรูปในวงกลม
                            height: 200, // ขนาดของรูปในวงกลม
                            child: data.imageFile != null
                                ? Image.file(
                                    data.imageFile!,
                                    fit: BoxFit.cover,
                                  )
                                : Center(child: Text('No Image',style: TextStyle(fontSize: 8),)),
                          ),
                        ),
                      ),
                      title: Text(data.name),
                      subtitle: Text("รหัสนักศึกษา : "+data.number,),
                      onTap: () {
                        print(data.nomo);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(transaction: data)),
                        );
                      },
                    ),
                  );

                  // return Container(
                  //   height: 430,
                  //   margin: const EdgeInsets.all(20.0),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: Color.fromARGB(255, 245, 173, 79)),
                  //   child: Column(
                  //     children: [
                  //       Container(
                  //           child: ListTile(
                  //         leading: CircleAvatar(
                  //     radius: 30,
                  //     child: FittedBox(
                  //       child: data.imageFile != null
                  //           ? Image.file(data.imageFile!)
                  //           : Text('No Image'),)
                  //     ),
                  //       )),
                  //       Container(
                  //         height: 200,
                  //         width: 350,
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               "หนังสือ : " + data.book,
                  //               style: TextStyle(fontSize: 20),
                  //             ),
                  //             Text(
                  //               "ชื่อผู้เเต่ง : " + data.name,
                  //               style: TextStyle(fontSize: 20),
                  //             ),
                  //             Text("พิมพ์วันที่" + (data.date),
                  //                 style: TextStyle(fontSize: 20)),
                  //             // Text("รหัสผ่าน : "+data.pass,style: TextStyle(fontSize: 20),),
                  //             Text(
                  //               "ราคา : " + data.number.toString() + " บาท",
                  //               style: TextStyle(fontSize: 23),
                  //             ),
                  //             // Text("เพศ :"+data.gender,style: TextStyle(fontSize: 20),),
                  //             // Text("สาขา : "+data.selectedValue,style: TextStyle(fontSize: 20),),
                  //             Text(
                  //               "อื่น ๆ : " + data.other,
                  //               style: TextStyle(fontSize: 20),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // );
                });
          }
        }));
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('DropdownButton ตัวอย่าง'),
//         ),
//         body: MyDropdownButton(),
//       ),
//     );
//   }
// }

// class MyDropdownButton extends StatefulWidget {
//   @override
//   _MyDropdownButtonState createState() => _MyDropdownButtonState();
// }

// class _MyDropdownButtonState extends State<MyDropdownButton> {
//   String selectedValue = 'เลือกข้อมูล'; // ค่าเริ่มต้น

//   // รายการข้อมูลที่จะใช้ใน Dropdown
//   List<String> items = ['เลือกข้อมูล', 'ข้อมูล 1', 'ข้อมูล 2', 'ข้อมูล 3'];

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         // mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           DropdownButton<String>(
//             value: selectedValue, // ค่าที่เลือก
//             onChanged: (String? newValue) {
//               setState(() {
//                 selectedValue = newValue!;
//               });
//             },
//             items: items.map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//           ),
//           // SizedBox(height: 20.0),
//           // Text(
//           //   'คุณเลือก: $selectedValue',
//           //   style: TextStyle(fontSize: 18.0),
//           // ),
//         ],
//       ),
//     );
//   }
// }
