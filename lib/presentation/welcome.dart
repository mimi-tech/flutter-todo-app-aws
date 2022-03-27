import 'package:aws_todo_app/logic/auth/auth_bloc.dart';
import 'package:aws_todo_app/logic/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {



  @override
  void initState() {
    super.initState();

    BlocProvider.of<AuthBloc>(context).getCurrentUser();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return  SafeArea(child: Scaffold(
        backgroundColor: const Color(0xFF53C1E9),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {

            if (state is AuthInitial) {

              Navigator.of(context).pushNamedAndRemoveUntil("/login",(route) => false);
            }

            if (state is AuthSuccess) {

              Navigator.of(context).pushNamedAndRemoveUntil("/dashboard",(route) => false);
            }



          },
    builder: (context, state) {
      return state is AuthLoading?const Center(child: CircularProgressIndicator()):const SingleChildScrollView(
          child: Text("jknejfe")
      );
    }))



    );
  }
}
