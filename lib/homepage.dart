import 'dart:convert';

import 'package:final_640710148/helpers/api_caller.dart';
import 'package:final_640710148/helpers/dialog_utils.dart';
import 'package:final_640710148/helpers/my_list_tile.dart';
import 'package:final_640710148/helpers/my_text_field.dart';
import 'package:final_640710148/model/item.dart';
import 'package:flutter/material.dart';

class MYpage extends StatefulWidget {
  const MYpage({super.key});

  @override
  State<MYpage> createState() => _MYpageState();
}

class _MYpageState extends State<MYpage> {
  List<Item> _todoItems = [];

  var controller = TextEditingController();
  var details = TextEditingController();

  void initState() {
    super.initState();
    _loadTodoItems();
  }

  Future<void> _loadTodoItems() async {
    try {
      final data = await ApiCaller().get("web_types");
      // ข้อมูลที่ได้จาก API นี้จะเป็น JSON array ดังนั้นต้องใช้ List รับค่าจาก jsonDecode()
      List list = jsonDecode(data);
      setState(() {
        _todoItems = list.map((e) => Item.fromJson(e)).toList();
        //debugPrint(_todoItems.toString());
      });
    } on Exception catch (e) {
      showOkDialog(context: context, title: "Error", message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeData().colorScheme.primary,
        title: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Webby Fondue',
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
              Text(
                'ระบบรายงานเว็บเลวๆ',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            MyTextField(controller: controller, hintText: '* URL'),
            MyTextField(controller: details, hintText: 'รายละเอียด'),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _todoItems.length,
              itemBuilder: (context, index) {
                var item = _todoItems[index];

                return Card(
                  child: InkWell(
                    onTap: () {
                      item.id.toString();
                      debugPrint(item.id.toString());
                    },
                    child: MyListTile(
                      title: item.title.toString(),
                      subtitle: item.Subtitle.toString(),
                      imageUrl: ApiCaller.host + item.image.toString(),
                    ),
                  ),
                );
              },
            )),
            SizedBox(
              height: 24.0,
            ),
            ElevatedButton(
              onPressed: _checkPost,
              child: SizedBox(
                width: double.infinity,
                child: Text('ส่งข้อมูล', textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkPost() async {
    try {
      final data = await ApiCaller().post("report_web", params: {
        "url": controller.text,
        "description": details.text,
        "type": "web"
      });
      Map map = jsonDecode(data);
      String text =
          'ขอบคุณสำหรับการแจ้งข้อมูล รหัสข้อมูลคือ ${map['id']} \n สถิติรายงาน \n ${map['title']}';
      debugPrint(text);
    } on Exception catch (e) {
      showOkDialog(context: context, title: "Error", message: e.toString());
    }
  }
}
