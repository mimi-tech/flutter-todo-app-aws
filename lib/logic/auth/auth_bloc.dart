import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:aws_todo_app/logic/auth/auth_state.dart';
import 'package:aws_todo_app/logic/helpers/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AuthBloc extends Cubit<AuthState> {

  AuthBloc(AuthState initialState) : super(initialState);

  Duration duration = const Duration(seconds: 3);
  void registerUser(String email, String password) async {

    try{
      emit(AuthLoading());
    await Amplify.Auth.signUp(
      username: email,
      password: password,
      options: CognitoSignUpOptions(userAttributes:{
        CognitoUserAttributeKey.email:email
      }),
    ).then((value) {
      emit(AuthSuccess());


    });
  }on AuthException catch (e) {
      emit(AuthDenied(e.message));
    }
  }
  void authLoginRequested(String email, String password) async {
    try{
      emit(AuthLoading());
       await Amplify.Auth.signIn(
        username: email,
        password: password,
      ).then((value) {
        emit(AuthAuthenticated());


      });
    }on AuthException catch (e) {
      emit(AuthDenied(e.message));
    }
  }

  void confirmUser(String email, String confirmationNumber) async {
    try{
      emit(AuthLoading());
      await Amplify.Auth.confirmSignUp(
        username: email,
        confirmationCode: confirmationNumber,
      ).then((value) async {
        if(value.isSignUpComplete == true){
          authLoginRequested(Constants.userEmail.toString(),  Constants.userPassword.toString());
          emit(AuthSuccess());
        }


      });
    }on AuthException catch (e) {
      emit(AuthDenied(e.message));
    }
  }

    void resendCode() async {
      try {
        await Amplify.Auth.resendSignUpCode(username: Constants.userEmail.toString());

      } on AuthException catch (e) {
        emit(AuthDenied(e.message));
      }
    }


    void onRecoverPassword( String email) async {



      try {
        emit(AuthLoading());
        final res = await Amplify.Auth.resetPassword(username: email);
        emit(AuthSuccess());
        // print(res.nextStep.updateStep);
        // print(res.nextStep.codeDeliveryDetails);
        // print(res.isPasswordReset);
        if (res.nextStep.updateStep == 'CONFIRM_RESET_PASSWORD_WITH_CODE') {
          emit(AuthSuccess());
        }else{
          emit(const AuthDenied("User not found"));
        }
      } on AuthException catch (e) {
        emit(AuthDenied(e.toString()));
      }
    }

    void resetPassword( String code, String password, String email) async {
      try {
        emit(AuthLoading());
        await Amplify.Auth.confirmResetPassword(
            username: email,
            newPassword: password,
            confirmationCode: code
        ).then((value) => emit(AuthSuccess()));
      } on AuthException catch (e) {
        emit(AuthDenied(e.message));

      }
    }

    Future<void> getCurrentUser() async {
      emit(AuthLoading());
      await Future.delayed(duration);
      await Amplify.Auth.getCurrentUser().then((user) {
        var currentUser = user.userId;
        if(currentUser != null){

          emit(AuthSuccess());
        }else{

          emit(AuthInitial());
        }

      }).catchError((error) async {
        emit(AuthInitial());
        //print((error as AuthException).message);
      });
    }

  Future<void> logoutUser(BuildContext context) async {
    emit(AuthLoading());
    await Amplify.Auth.signOut().then((user) {
      Navigator.of(context).pushNamedAndRemoveUntil("/login",(route) => false);

    }).catchError((error) async {
      emit(AuthInitial());
      //print((error as AuthException).message);
    });
  }
  }
