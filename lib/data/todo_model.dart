import 'dart:ffi';

import 'db_helper.dart';

class TodoModel {
  int? tID;
  String tTitle;
  String tDesc;
  String tCreatedAt;
  bool isCompleted;

  TodoModel(
      {this.tID,
      required this.tTitle,
      required this.tDesc,
      required this.tCreatedAt,
      required this.isCompleted});

  Map<String ,dynamic> toMap(){
   return {

     DbHelper.COLUMN_TODO_TITLE:tTitle,
     DbHelper.COLUMN_TODO_DESC: tDesc,
     DbHelper.COLUMN_TODO_CREATED_AT:tCreatedAt,
     DbHelper.COLUMN_TODO_COMPLETED:isCompleted ?1:0,

   };
  }

  factory TodoModel.forMap(Map<String,dynamic> map){
    return  TodoModel(
        tID: map[DbHelper.COLUMN_TODO_ID],
        tTitle: map[DbHelper.COLUMN_TODO_TITLE],
        tDesc: map[DbHelper.COLUMN_TODO_DESC],
        tCreatedAt: map[DbHelper.COLUMN_TODO_CREATED_AT],
        isCompleted: map[DbHelper.COLUMN_TODO_COMPLETED]==0? false : true);

  }

}
