import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_todo_app/logic/auth/auth_state.dart';
import 'package:aws_todo_app/models/ModelProvider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosCubit extends Cubit<AuthState> {

  TodosCubit(AuthState initialState) : super(initialState);


  Future<void> addTodo(Blog newBlog, Post post) async {

    try{
      emit(AuthLoading());
      await Amplify.DataStore.save(newBlog);
      await Amplify.DataStore.save(post);
      emit(AuthSuccess());
    }on AuthException catch (e) {
      emit(AuthDenied(e.message));
    }




  }

  void getTodo(){
    try{
      emit(AuthLoading());

      emit(AuthSuccess());
    }on AuthException catch (e) {
      emit(AuthDenied(e.message));
    }
  }
}