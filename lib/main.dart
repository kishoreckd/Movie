// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie/Moviepage.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List listResponses;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var headers = {
      'Authorization':
          'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNzQ2N2FkNzFjZjQ0MDViMzJmNDk1MTIzNmFkOTlhMiIsInN1YiI6IjY1MjY4M2E2ZWE4NGM3MDBjYTBlOWM3NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VFOAOgt88QL_M3zEq31KQRNjO5jUI8i0DYS2VBeE5Wo'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://api.themoviedb.org/3/movie/top_rated?language=en-US&api_key=d7467ad71cf4405b32f4951236ad99a2',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      listResponses = response.data["results"];
      print(listResponses);
      // print(json.encode(response.data["results"]));
    } else {
      print(response.statusMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (listResponses.isNotEmpty) {}
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Fetch Api',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final list = listResponses[index];
          if (listResponses != null) {
            return Column(
              children: [
                Container(
                  height: 100.0,
                  child: Card(
                    child: ListTile(
                      leading: Image.network(
                        'https://m.media-amazon.com/images/I/81hSDsdtu0L._AC_UL640_FMwebp_QL65_.jpg',
                        height: double.infinity,
                      ),

                      // image: NetworkImage(
                      //     'https://m.media-amazon.com/images/I/81hSDsdtu0L._AC_UL640_FMwebp_QL65_.jpg'),
                      title: Text(list['original_title']),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Moviepage(
                                  list: list,
                                )));
                      },
                      trailing: Icon(Icons.arrow_circle_right_outlined),
                      // subtitle: Text(listResponses[index]['vote_average']),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
        itemCount: listResponses == null ? 0 : listResponses.length,
      ),
    );
  }
}
