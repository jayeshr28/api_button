import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api_model.dart';

Future<LED1> fetchApi() async {
  final response = await http.get(
    Uri.parse(
        'https://iotmachlab.000webhostapp.com/api/LED_1/read_all.php?id=1'),
  );

  if (response.statusCode == 200) {
    return LED1.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

Future<LED1> updateApi(String status) async {
  final response = await http.put(
    Uri.parse(
        'https://iotmachlab.000webhostapp.com/api/LED_1/read_all.php?id=1'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "success": 1,
      "LED_1": [
        {"id": "1", "status": status}
      ]
    }),
  );

  if (response.statusCode == 200) {
    return LED1.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update');
  }
}

class TriggerApi extends StatefulWidget {
  const TriggerApi({Key? key}) : super(key: key);

  @override
  State<TriggerApi> createState() => _TriggerApiState();
}

class _TriggerApiState extends State<TriggerApi> {
  late Future<LED1> _futureAlbum;
  bool toggle = false;
  @override
  void initState() {
    super.initState();
    _futureAlbum = fetchApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<LED1>(
            future: _futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Text(snapshot.data!.success.toString()),
                      Text(snapshot.data!.LED_1[0]['status'].toString()),
                      ElevatedButton(
                        onPressed: () {
                          if (toggle == false) {
                            setState(() {
                              _futureAlbum = updateApi('on');
                              toggle = true;
                            });
                          } else {
                            setState(() {
                              _futureAlbum = updateApi('off');
                              toggle = false;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                toggle ? Colors.black : Colors.green),
                        child: const Text('Update Data'),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
