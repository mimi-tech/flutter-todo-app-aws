import 'package:aws_todo_app/logic/auth/auth_bloc.dart';
import 'package:aws_todo_app/logic/auth/auth_state.dart';
import 'package:aws_todo_app/logic/helpers/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmForgotPasswordCode extends StatefulWidget {
  const ConfirmForgotPasswordCode({Key? key}) : super(key: key);

  @override
  _ConfirmForgotPasswordCodeState createState() =>
      _ConfirmForgotPasswordCodeState();
}

class _ConfirmForgotPasswordCodeState extends State<ConfirmForgotPasswordCode> {
  final GlobalKey<FormState> _fgtCodeForm = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
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
            Color(0xFF87CDE1),
            Color(0xFF53C1E9),
            Color(0xFF0093CD),
            Color(0xFF037EAF),
          ],
        )),
        child: Stack(
          children: <Widget>[
            const Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child:
                    Image(image: AssetImage('assets/icons/registration.png'))),
            Column(
              children: [
                Container(
                    margin: const EdgeInsets.all(20)
                        .add(EdgeInsets.only(top: height * 0.25)),
                    alignment: Alignment.center,
                    child: const Center(
                      child: ImageIcon(
                        AssetImage('assets/icons/lock_80px.png'),
                        size: 120,
                        color: Colors.white,
                      ),
                    )),
                const Text(
                  'Check your email',
                  style: TextStyle(
                      color: Colors.white, fontSize: 25, fontFamily: 'UniNeue'),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Center(
                    child: Text(
                        "You'll receive a code to verify here so you can reset your account password.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'UniNeue')),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0)
                          .add(EdgeInsets.only(top: height * 0.10)),
                      child:BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                      if (state is AuthDenied) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.errors[0],style: const TextStyle(color: Colors.red),),
                      duration: const Duration(milliseconds: 300),
                      ));
                      }
                      if (state is AuthGeneral) {
                        Navigator.of(context).pushNamed('/forgot-password/update-password');
                      }
                      },
                      builder: (context, state) {
                      return Form(
                        key: _fgtCodeForm,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 40),
                              child: TextFormField(
                                style: const TextStyle(
                                    color: Colors.white, fontFamily: 'UniNeue'),
                                validator: (val) => validateOTP(val!),
                                controller: codeController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: 'Enter your code',
                                  hintStyle: TextStyle(
                                      color: Colors.white70,
                                      fontFamily: 'UniNeue'),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white70),
                                  ),
                                ),
                                onChanged: (text) {
                                  setState(() {});
                                },
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
                                  // onPressed: () {
                                  //   Navigator.of(context).pushNamed('/forgot-password/update-password');
                                  // },
                                onPressed: (state is AuthLoading)? () => {null} :  () => {
                                  if(validateForm()){
                                    BlocProvider.of<AuthBloc>(context).onRecoverPassword(codeController.text)

                                  }
                                },
                                child: (state is AuthLoading)? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(color: Colors.white,)) :const Text(
                                    'Verify',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'UniNeue'),
                                  )),
                            ),
                            const SizedBox(
                              height: 80,
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
                    }),
                  ),
                )
                )],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text(
                  'Password Reset',
                  style: TextStyle(fontFamily: 'UniNeue', color: Colors.white),
                ),
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
  bool validateForm() {
    if (_fgtCodeForm.currentState!.validate()) {
      _fgtCodeForm.currentState?.save();
      return true;
    } else {
      return false;
    }
  }
}
