import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'Box/boxes.dart';
import 'nots_modle/notes_model.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  final titlecontroller = TextEditingController();
  final descpcontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    titlecontroller.clear();
    descpcontroller.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive Local Database"),
      ),
      body: ValueListenableBuilder<Box<NotsModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<NotsModel>();
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          data[index].title.toString(),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              return delete(data[index]);
                            },
                            icon: Icon(Icons.delete)),
                        IconButton(
                            onPressed: () {
                              _editdialog(
                                data[index],
                                data[index].title.toString(),
                                data[index].description.toString(),
                              );
                            },
                            icon: Icon(Icons.edit)),
                      ],
                    ),
                    Text(
                      data[index].description.toString(),
                    ),
                    // Text(data[index].dropdown.toString()),
                  ],
                ),
              );
            },
          );
        },
      ),
      /*ValueListenableBuilder<Box<NotsModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<NotsModel>();
          return ListView.builder(
            itemCount: box.length,
            reverse: true,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          data[index].title.toString(),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            delete(data[index]);
                          },
                          child: Icon(Icons.delete),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            _editdialog(
                                data[index],
                                data[index].title.toString(),
                                data[index].description.toString());
                          },
                          child: Icon(Icons.edit),
                        ),
                      ],
                    ),
                    Text(
                      data[index].description.toString(),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _showmydialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void delete(NotsModel notsModel) async {
    await notsModel.delete();
  }

  Future<void> _editdialog(
      NotsModel notsModel,
      String title,
      String description,
      ) async {
    titlecontroller.text = title;
    descpcontroller.text = description;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Notes"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: titlecontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Enter Title",
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: descpcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Enter Description",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("cancle"),
            ),
            TextButton(
              onPressed: () {
                notsModel.title = titlecontroller.text.toString();
                notsModel.description = descpcontroller.text.toString();
                notsModel.save();
                titlecontroller.clear();
                descpcontroller.clear();
                Navigator.pop(context);
              },
              child: Text("Edit"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showmydialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Notes"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: titlecontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Enter Title",
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: descpcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Enter Description",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("cancle"),
            ),
            TextButton(
              onPressed: () {
                final data = NotsModel(
                  title: titlecontroller.text,
                  description: descpcontroller.text, dropdown: '',
                );
                final box = Boxes.getData();
                box.add(data);
                //  data.save();
                print(box);
                titlecontroller.clear();
                descpcontroller.clear();
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
