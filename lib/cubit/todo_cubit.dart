import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/todo_state.dart';
import 'package:todo/data/db_helper.dart';
import 'package:todo/data/todo_model.dart';

class TodoCubit extends Cubit<TodoState>{

  DbHelper dbHelper;

  TodoCubit({required this.dbHelper}): super(TodoState(mTodo: []));


  addTodo({required String title, required String desc})async{
  bool check= await  dbHelper.addTodo(TodoModel(
      tTitle: title,
      tDesc: desc,
      tCreatedAt: DateTime.now().microsecondsSinceEpoch.toString(),
      isCompleted: false));
  if(check){
    List<TodoModel>  allTodo= await  dbHelper.fetchAllTodo();
    emit(TodoState(mTodo: allTodo));
  }

  }

  initialTodo()async{
   List<TodoModel> allTodo= await dbHelper.fetchAllTodo();
   emit(TodoState(mTodo: allTodo));
  }

  updateTodo({required TodoModel upTodo})async{

    bool check =await dbHelper.updateTodo(upTodo);
    if(check){

      List<TodoModel> allTodo=await dbHelper.fetchAllTodo();

      emit(TodoState(mTodo: allTodo));
    }


  }
  isComplete({required int id, required bool isCompleted})async{

    bool check =await dbHelper.completed(todoId: id, isComplete: isCompleted?1:0);

    if(check){
      List<TodoModel> allTodo= await dbHelper.fetchAllTodo();
      emit(TodoState(mTodo: allTodo));

    }


  }

  deleteTodo( {required int id})async{

    bool check=await dbHelper.deleteTodo(id);
    if(check) {

      List<TodoModel>  allToDo= await dbHelper.fetchAllTodo();
      
      emit(TodoState(mTodo: allToDo));
    }


  }

}