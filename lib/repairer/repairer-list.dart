import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RepairerList extends StatefulWidget {
  final String serviceId;
  final String serviceName;

  const RepairerList(
      {Key? key, required this.serviceId, required this.serviceName})
      : super(key: key);

  @override
  State<RepairerList> createState() => _RepairerListState();
}

class _RepairerListState extends State<RepairerList> {
  bool isGetRepairer = true;
  List repairerList = [];

  getRepairer() async {
    var url = Uri.parse(
        "http://192.168.1.7/home_service_backend/public/api/repairer");
    var resp = await http.post(url, body: {"service_id": widget.serviceId});
    if (resp.statusCode == 200) {
      setState(() {
        isGetRepairer = false;
        repairerList = jsonDecode(resp.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isGetRepairer) {
      getRepairer();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: ListView(
        children: [
          for (int i = 0; i < repairerList.length; i++)
            Card(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Image.network(
                      "https://cdn-icons-png.flaticon.com/512/7360/7360966.png?ga=GA1.1.1267191725.1679321065",
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        repairerList[i]['name'],
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(repairerList[i]['phone']),
                      Text(repairerList[i]['sex']),
                    ],
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
