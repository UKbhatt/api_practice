import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import './model/user.dart';

class Examplethree extends StatefulWidget {
  const Examplethree({super.key});

  @override
  State<Examplethree> createState() => _ExamplethreeState();
}

class _ExamplethreeState extends State<Examplethree> {
  List<UserModel> usersList = [];

  Future<List<UserModel>> getUsers() async {
    final response =
        await get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    List data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      usersList.clear();
      for (var i = 0; i < data.length; i++) {
        usersList.add(UserModel.fromJson(data[i]));
      }
      return usersList;
    } else {
      return usersList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Example Tree")),
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
                child: FutureBuilder(
              future: getUsers(),
              builder: (context, i) {
                if (i.hasData) {
                  return ListView.builder(
                      itemCount: usersList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            margin: const EdgeInsets.all(2),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Name"),
                                      Text(usersList[index].name.toString()),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("username"),
                                      Text(usersList[index].username.toString()),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Email"),
                                      Text(usersList[index].email.toString()),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Address"),
                                      Text("\n${usersList[index].address!.city}"),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(""),
                                      Text("${usersList[index].address!.street}\n ${usersList[index].address!.zipcode}")
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )),
          ],
        ));
  }
}
