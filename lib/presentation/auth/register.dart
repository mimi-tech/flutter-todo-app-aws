import 'dart:io';
import 'package:aws_todo_app/logic/auth/auth_bloc.dart';
import 'package:aws_todo_app/logic/auth/auth_event.dart';
import 'package:aws_todo_app/logic/auth/auth_state.dart';
import 'package:aws_todo_app/logic/helpers/colors.dart';
import 'package:aws_todo_app/logic/helpers/constant.dart';
import 'package:aws_todo_app/logic/helpers/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class RegisterPublic extends StatefulWidget {
  const RegisterPublic({Key? key}) : super(key: key);

  @override
  _RegisterPublicState createState() => _RegisterPublicState();
}

class _RegisterPublicState extends State<RegisterPublic> {
  final GlobalKey<FormState> _reg1Form = GlobalKey<FormState>();
  final GlobalKey<FormState> _otpForm = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController cpwdController = TextEditingController();
  bool obscureText1 = true;
  bool obscureText = true;
  String? password;
  String? cPassword;
  @override
  void dispose() {
    otpController.dispose();
    emailController.dispose();
    pwdController.dispose();
    cpwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.50;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
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
        child: Stack(
          children: <Widget>[
            Column(
              children: [
                Container(
                    margin: const EdgeInsets.all(20)
                        .add(EdgeInsets.only(top: height * 0.10)),
                    alignment: Alignment.center,
                    child: const Center(
                      child: Icon(Icons.add_circle_outline,size: 80, color: Colors.white,)
                    )),
                const Text(
                  'Register',
                  style: TextStyle(
                      color: Colors.white, fontSize: 25, fontFamily: 'UniNeue'),
                ),
                Expanded(
                    child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0)
                              .add(EdgeInsets.only(top: height * 0.25)),
                          child: BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state is AuthDenied) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content:  Text(state.errors,style: const TextStyle(color: Colors.red),),
                                  duration: const Duration(seconds: 5),
                                ));
                              }

                              if (state is AuthSuccess) {

                                  Navigator.of(context).pushReplacementNamed("/confirm-user");

                                }

                            },
                            builder: (context, state) {
                              return Form(
                                key: _reg1Form,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 20.0, right: 40),
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Colors.white, fontFamily: 'UniNeue'),
                                        validator: (val) => validateEmail(val!),
                                        controller: emailController,
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: const InputDecoration(
                                          hintText: 'Email',
                                          hintStyle: TextStyle(
                                              color: Colors.white70,
                                              fontFamily: 'UniNeue'),
                                          prefixIcon: Icon(
                                            Icons.email_outlined,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.white70),
                                          ),
                                        ),
                                        onChanged: (value){
                                          Constants.userEmail = value;
                                        },

                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 40, left: 20.0, right: 40),
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Colors.white, fontFamily: 'UniNeue'),
                                        validator: (val) => validatePassword(val!),
                                        obscureText: obscureText,
                                        keyboardType: TextInputType.text,
                                        controller: pwdController,
                                        decoration: InputDecoration(
                                          hintText: 'Password',
                                          hintStyle: const TextStyle(
                                              color: Colors.white70,
                                              fontFamily: 'UniNeue'),
                                          prefixIcon: const Icon(Icons.add_circle_outline,size: 30,color: Colors.white,),
                                          suffixIcon: GestureDetector(
                                            onTap: _toggleObscure,
                                            child: Icon(
                                              obscureText
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              size: 20.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          enabledBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: const UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.white70),
                                          ),
                                        ),

                                        onChanged: (text) {
                                          Constants.userPassword = text;
                                        },

                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 40, left: 20.0, right: 40),
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'UniNeue',
                                            fontSize: 18),
                                        keyboardType: TextInputType.text,
                                        validator: (val)=>validateConfirmPassword(val!, pwdController.text),
                                        obscureText: obscureText1,
                                        controller: cpwdController,
                                        decoration: InputDecoration(
                                          hintText: 'Confirm Password',
                                          hintStyle: const TextStyle(
                                              color: Colors.white70,
                                              fontFamily: 'UniNeue'),
                                          prefixIcon: const Icon(Icons.add_circle_outline,size: 30,color: Colors.white,),

                                          suffixIcon: GestureDetector(
                                            onTap: _toggleObscure1,
                                            child: Icon(
                                              obscureText1
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              size: 20.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          enabledBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: const UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.white70),
                                          ),
                                        ),

                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 50, left: 40.0, right: 40),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          minimumSize:
                                          Size(width * 0.65, height * 0.12),
                                          side: const BorderSide(
                                              color: Colors.white, width: 1),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(30)),
                                        ),
                                        onPressed: (state is AuthLoading)? () => {null} :  () => {
                                          if(validateForm()){


                                            BlocProvider.of<AuthBloc>(context).registerUser(emailController.text, pwdController.text)
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
                                        ),

                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Already have an account?",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontFamily: 'UniNeue'),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed("/login");
                                          },
                                          child: const Text(
                                            'Login now',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontFamily: 'UniNeue',
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                    ))],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );


  }



  void _toggleObscure() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void _toggleObscure1() {
    setState(() {
      obscureText1 = !obscureText1;
    });
  }

  bool validateForm() {
    if (_reg1Form.currentState!.validate()) {
      _reg1Form.currentState?.save();
      return true;
    } else {
      return false;
    }
  }
}
