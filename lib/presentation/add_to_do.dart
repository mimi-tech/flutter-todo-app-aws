
import 'package:aws_todo_app/logic/auth/auth_bloc.dart';
import 'package:aws_todo_app/logic/auth/auth_state.dart';
import 'package:aws_todo_app/logic/helpers/colors.dart';
import 'package:aws_todo_app/logic/helpers/validator.dart';
import 'package:aws_todo_app/logic/todo_bloc.dart';
import 'package:aws_todo_app/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _addTodoForm = GlobalKey<FormState>();
  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodeTitle = FocusNode();

  TextEditingController todoController = TextEditingController();
  TextEditingController title = TextEditingController();

  @override
  void dispose() {
    todoController.dispose();
    title.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.50;
    var width = MediaQuery.of(context).size.width;


    return  SafeArea(child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF53C1E9),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              const Text("Add todo"),
              ElevatedButton(
                  onPressed: (){
                    BlocProvider.of<AuthBloc>(context).logoutUser(context);
                  },
                  child: const Text("Logout",style: TextStyle(fontFamily: 'UniNeue'),))
            ],
          ),

        ),
        backgroundColor: const Color(0xFF53C1E9),
        body: BlocProvider(
           create: (context){
             return TodosCubit(AuthInitial());
           },

          child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 0.5, 0.7, 0.9],
                    colors: [
                      kColor1,
                      kColor2,
                      kColor3,
                      kColor4

                    ],
                  )),
              child: Column(
                children: [
                  const SizedBox(height: 50,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: BlocConsumer<TodosCubit, AuthState>(
                          listener: (context, state) {
                            if (state is AuthDenied) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(state.errors,style: const TextStyle(color: Colors.red),),
                                duration: const Duration(seconds: 4),
                              ));
                            }
                            if(state is AuthLoading){
                               const Center(child: CircularProgressIndicator());
                            }
                            if (state is AuthSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Todo added successfully",style: TextStyle(color: Colors.green),),
                                duration: Duration(seconds: 4),
                              ));
                          }},
                          builder: (context, state) {


                            return Form(
                              key: _addTodoForm,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 40),
                                    child: TextFormField(
                                      maxLength: 100,
                                      maxLines: null,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'UniNeue',

                                          fontSize: 18),
                                      validator: (val) => validateString(val!),

                                      controller: title,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        hintText: 'Title',
                                        hintStyle: TextStyle(
                                            color: Colors.white70),
                                        prefixIcon: Icon(Icons.admin_panel_settings_sharp,size: 30,color: Colors.white,),

                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.white70),
                                        ),
                                      ),
                                      onChanged: (text) {

                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 40,top: 50),
                                    child: TextFormField(
                                      maxLength: 100,
                                      maxLines: null,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'UniNeue',

                                          fontSize: 18),
                                      validator: (val) => validateString(val!),

                                      controller: todoController,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        hintText: 'Add to do',
                                        hintStyle: TextStyle(
                                            color: Colors.white70),
                                        prefixIcon: Icon(Icons.admin_panel_settings_sharp,size: 30,color: Colors.white,),

                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.white70),
                                        ),
                                      ),
                                      onChanged: (text) {

                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40.0, right: 40),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(
                                              width * 0.65, height * 0.12),
                                          side: const BorderSide(
                                              color: Colors.white, width: 1),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(30)),
                                        ),
                            onPressed: () {

                              if(validateForm()){
                                Blog newBlog = Blog(name: todoController.text.trim());
                                var post = Post(
                                  title: title.text,
                                  blog: newBlog,
                                );
                                BlocProvider.of<TodosCubit>(context).addTodo(newBlog, post);
                              }
                                        },
                                        child: (state is AuthLoading)? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(color: Colors.white,)) : const Text(
                                          'Submit',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'UniNeue',
                                              fontSize: 20),
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              )),



    )



    ));
  }
  bool validateForm() {

    if (_addTodoForm.currentState!.validate()) {
      _addTodoForm.currentState?.save();
      return true;
    } else {
      return false;
    }
  }
}
