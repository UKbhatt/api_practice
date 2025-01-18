import 'dart:convert';
import './model/posts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> postList = []; 
//if the api has un-named array then we need to create a custom list to store the data and then use it as required
  Future<List<PostModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    List data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      postList.clear();
      for (int j = 0; j < data.length; j++) {
        postList.add(PostModel.fromJson(data[j]));
      }
      return postList;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api"),
        backgroundColor: Colors.lightBlueAccent.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder(
                    future: getPostApi(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: postList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Title: ${postList[index].title}"),
                                    Text("Message: ${postList[index].body}")
                                  ],
                                )),
                              );
                            });
                      } else {
                        return const Text("Loading....");
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
