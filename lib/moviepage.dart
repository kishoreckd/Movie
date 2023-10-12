import 'package:flutter/material.dart';

class Moviepage extends StatelessWidget {
  final list;

  const Moviepage({Key? key, required this.list});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Movie Details'),
        ),
        body: Center(
          child: Column(
            children: [
              Image.network(
                  'https://m.media-amazon.com/images/I/81hSDsdtu0L._AC_UL640_FMwebp_QL65_.jpg'),
              SizedBox(
                child: Text(
                  list['original_title'],
                  style: TextStyle(fontSize: 30),
                ),
              )
            ],
          ),
        ),
      );
}
