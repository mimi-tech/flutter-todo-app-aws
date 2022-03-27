
import 'dart:async';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_todo_app/logic/auth/auth_bloc.dart';
import 'package:aws_todo_app/logic/helpers/validator.dart';
import 'package:aws_todo_app/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  StreamSubscription? _subscription;
   List<Blog> _blogs = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subscription = Amplify.DataStore.observe(Blog.classType)
        .listen((SubscriptionEvent event) {
      print(event.eventType);
      switch (event.eventType) {
        case EventType.create:
          _blogs.add(event.item as Blog);
          break;
        case EventType.update:
          var index = _blogs.indexOf(event.item as Blog);
          _blogs[index] = event.item as Blog;
          break;
        case EventType.delete:
          _blogs.removeWhere((element) => element.id == event.item.getId());
          break;
      }
      setState(() {});
    });
    initBlogs();
  }
  @override
  void dispose() {
    super.dispose();
    _subscription!.cancel();
  }
  @override
  Widget build(BuildContext context) {

    return  SafeArea(child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed("/add-todo");

        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add,size: 30,color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF53C1E9),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
             const Text("Dashboard"),
            ElevatedButton(
                onPressed: (){
                  BlocProvider.of<AuthBloc>(context).logoutUser(context);
                },
                child: const Text("Logout",style: TextStyle(fontFamily: 'UniNeue'),))
          ],
        ),

      ),
        backgroundColor: const Color(0xFF53C1E9),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.5, 0.7, 0.9],
                colors: [
                  Color(0xFF87CDE1),
                  Color(0xFF53C1E9),
                  Color(0xFF0093CD),
                  Color(0xFF037EAF),
                ],
              )),
          child: Column(

            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    indent: 16,
                    endIndent: 16,
                    color: Colors.black,
                  ),
                  itemCount: _blogs.length,
                  itemBuilder: (item, index) {
                    return ListTile(
                      title: Text(_blogs[index].name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () async {
                          Amplify.DataStore.delete(_blogs[index]);
                        },
                      ),

                    );
                  },
                ),
              ),
            ],
          )
        ))



    );
  }

  Future<void> initBlogs() async {
    var result = await Amplify.DataStore.query(Blog.classType);
    setState(()  {
      _blogs = result;
    });

  }

}
