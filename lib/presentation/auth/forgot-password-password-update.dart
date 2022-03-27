
import 'package:aws_todo_app/logic/auth/auth_bloc.dart';
import 'package:aws_todo_app/logic/auth/auth_state.dart';
import 'package:aws_todo_app/logic/helpers/constant.dart';
import 'package:aws_todo_app/logic/helpers/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordChange extends StatefulWidget {
  const ForgotPasswordChange({Key? key}) : super(key: key);

  @override
  _ForgotPasswordChangeState createState() => _ForgotPasswordChangeState();
}

class _ForgotPasswordChangeState extends State<ForgotPasswordChange> {
  final GlobalKey<FormState> _resetPwdForm = GlobalKey<FormState>();
  TextEditingController pwdController = TextEditingController();
  TextEditingController cpwdController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  bool obscureText1 = true;
  bool obscureText2 = true;

  @override
  void dispose() {
    pwdController.dispose();
    cpwdController.dispose();
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.50;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0093CD),
          centerTitle: true,
          title: const Text("Reset your Password",
              style: TextStyle(fontFamily: 'UniNeue', color: Colors.white)),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Check your email',
              style: TextStyle(
                  color: Colors.white, fontSize: 25, fontFamily: 'UniNeue'),
            ),
            const SizedBox(height: 10),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: height * 0.2,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://velocityhealth.co.za/assets/images/icons/logo.png"),
                        fit: BoxFit.fill,
                      ),
                      border: Border.all(
                        color: const Color(0xFF0093CD),
                        width: 3.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: const <Widget>[
                          Text(
                            "Name Surname",
                            style: TextStyle(
                              color: Color(0xFF0093CD),
                              fontSize: 20.0,
                              fontFamily: 'UniNeue',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "email@example.com",
                        style: TextStyle(
                          color: Color(0xFF0093CD),
                          fontSize: 13.0,
                          fontFamily: 'UniNeue',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(50.0),
              child: Text(
                  "Strong password contains numbers, letters and punctuation marks",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF0093CD),
                      fontSize: 20,
                      fontFamily: 'UniNeue')),
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                  if (state is AuthDenied) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:  Text(state.errors,style: const TextStyle(color: Colors.red),),
                  duration: const Duration(seconds: 5),
                  ));
                  }

                  if (state is AuthSuccess) {
               //push user to login screen

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:  Text("Password updated successfully",
                  style:  TextStyle(
                  color: Colors.green, fontFamily: 'UniNeue'),
                  ),
                  duration: Duration(seconds: 5),
                  ));
                  Navigator.of(context).pushNamed('/login');
                  }


                  },
                  builder: (context, state) {
                  return Form(
                key: _resetPwdForm,
                child: Column(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20.0, right: 40),
                      child: TextFormField(
                        style: const TextStyle(
                            color: Color(0xFF0093CD), fontFamily: 'UniNeue'),
                        validator: (val) => validateOTP(val!),
                        controller: codeController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Enter your code',
                          hintStyle: TextStyle(
                              color: Color(0xFF0093CD), fontFamily: 'UniNeue'),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color(0xffff026c93)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0093CD)),
                          ),
                        ),
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 40,top: 50),
                      child: TextFormField(
                        style: const TextStyle(
                            color: Color(0xFF0093CD), fontFamily: 'UniNeue'),
                        validator: (val) => validatePassword(val!),
                        controller: pwdController,
                        obscureText: obscureText1,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'New Password',
                          suffixIcon: GestureDetector(
                            onTap: _toggleObscure1,
                            child: Icon(
                              obscureText1
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 20.0,
                              color: const Color(0xFF0093CD),
                            ),
                          ),
                          hintStyle: const TextStyle(
                              color: Color(0xFF0093CD), fontFamily: 'UniNeue'),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffff026c93)),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0093CD)),
                          ),
                        ),
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 40, top: 50),
                      child: TextFormField(
                        style: const TextStyle(
                            color: Color(0xFF0093CD), fontFamily: 'UniNeue'),
                        validator: (val)=>validateConfirmPassword(val!, pwdController.text),
                        controller: cpwdController,
                        keyboardType: TextInputType.text,
                        obscureText: obscureText2,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          suffixIcon: GestureDetector(
                            onTap: _toggleObscure2,
                            child: Icon(
                              obscureText2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 20.0,
                              color: Color(0xFF0093CD),
                            ),
                          ),
                          hintStyle: const TextStyle(
                              color: Color(0xFF0093CD), fontFamily: 'UniNeue'),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFFF026C93)),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0093CD)),
                          ),
                        ),
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 50, left: 40.0, right: 40),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(width * 0.65, height * 0.12),
                            side: const BorderSide(
                                color: Color(0xFF0093CD), width: 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: (state is AuthLoading)? () => {null} :  () => {
                            if(validateForm()){
                              BlocProvider.of<AuthBloc>(context).resetPassword(codeController.text, pwdController.text, Constants.userEmail.toString())
                            }
                          },
                          child: (state is AuthLoading)? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(color: Colors.white,)) :const Text(
                            'Reset Password',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'UniNeue'),
                          )),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Didn't receive your code?",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'UniNeue',
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            //resendCode()
                            BlocProvider.of<AuthBloc>(context).resendCode();

                          },
                          child: const Text(
                            "Resend code.",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'UniNeue',
                                color: Colors.white,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
              })
            )
            )],
        ));

  }

  void _toggleObscure1() {
    setState(() {
      obscureText1 = !obscureText1;
    });
  }

  void _toggleObscure2() {
    setState(() {
      obscureText2 = !obscureText2;
    });
  }
  bool validateForm() {
    if (_resetPwdForm.currentState!.validate()) {
      _resetPwdForm.currentState?.save();
      return true;
    } else {
      return false;
    }
  }
}
