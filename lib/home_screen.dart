import 'dart:convert';

import 'package:e_commerce/repairer/repairer-list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // http://192.168.184.247/home_service_backend/public/api/service

  static const IconData access_alarm_sharp =
      IconData(0xe738, fontFamily: 'MaterialIcons');

  bool isGet = true;
  List serviceTypes = [];

  getData() async {
    var url =
        Uri.parse('http://172.31.144.1/home_service_backend/public/api/service');

    var resp = await http.get(url);

    if (resp.statusCode == 200) {
      setState(() {
        isGet = false;
        serviceTypes = jsonDecode(resp.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isGet) {
      getData();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Screen',
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          for (int i = 0; i < serviceTypes.length; i++)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RepairerList(
                        serviceId: serviceTypes[i]['id'].toString(),
                        serviceName: serviceTypes[i]['name'],
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 1,
                  color: Colors.grey[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        IconData(
                          int.parse(serviceTypes[i]['icon_code']),
                          fontFamily: 'MaterialIcons',
                        ),
                        size: 50,
                        color: Colors.amber,
                      ),
                      Text(
                        serviceTypes[i]['name'],
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
