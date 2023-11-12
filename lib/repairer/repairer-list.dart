import 'dart:convert';
import 'package:e_commerce/helper/global.dart';
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
    var url = Uri.parse("$apiUrl/repairer");
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
        title: const Text(
          "Repairer",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          for (int i = 0; i < repairerList.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Card(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Image.network(
                        imageUrl + repairerList[i]['image'],
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
              ),
            )
        ],
      ),
    );
  }
}
