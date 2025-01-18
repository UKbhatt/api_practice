import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './model/photos.dart';

class Exampletwo extends StatefulWidget {
  const Exampletwo({super.key});

  @override
  State<Exampletwo> createState() => _ExampletwoState();
}

class _ExampletwoState extends State<Exampletwo> {
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotos() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));

    if (response.statusCode == 200) {
      photosList.clear();
      List data = jsonDecode(response.body
          .toString()); // list that is storing the responses from the API
      for (var j = 0; j < data.length; j++) {
        Photos photos = Photos(title: data[j]['title'], url: data[j]['url']);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Two'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
              builder: (context, i) {
                // i is the snapshot telling us about whether we have data or not by using the hasData function
                if (i.hasData) {
                  return ListView.builder(
                      itemCount: photosList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(photosList[index].url.toString()),
                          ),
                          title: RichText( 
    // this is just for the styling of the text and title and its data to be inline with each other
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Title: ', // The bold heading
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: photosList[index]
                                      .title
                                      .toString(), // The title data
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          subtitle: Text(
                            photosList[index].title.toString(),
                          ),
                        );
                      });
                } else {
                  return const Text("Loading...");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
