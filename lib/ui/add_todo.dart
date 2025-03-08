import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/data/todo_model.dart';
import 'package:todo/ui/home_page.dart';

class AddTodo extends StatefulWidget {
  int id;
  String title ='';
  String desc='';
  String createdAt='';
  bool isUpdated= false;
  bool isCompleted=false;

  AddTodo({this.id=-1,  this.title='',  this.desc='', this.createdAt='',this.isUpdated=false });

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    if(widget.isUpdated){
      titleController.text=widget.title;
      descController.text=widget.desc;

    }
    return Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back,color: Colors.white,)),

        title: widget.isUpdated ? Text("Task Update ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)):Text("Add Task",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xff9395D3),

      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(

          children: [

            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Title",
                hintStyle: TextStyle(color: Colors.grey),
                focusedBorder: UnderlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                hintText: "Detail",
                hintStyle: TextStyle(color: Colors.grey),
                focusedBorder: UnderlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(onPressed: (){
             if(widget.isUpdated){
               context.read<TodoCubit>().updateTodo(upTodo: TodoModel(
                   tTitle: titleController.text,
                   tDesc: descController.text,
                   tCreatedAt: widget.createdAt,
                   tID: widget.id,
                   isCompleted: false));

             }else{
               context.read<TodoCubit>().addTodo(
                   title: titleController.text,
                   desc: descController.text);
             }
              Navigator.pop(context);

            },
                style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff9395D3),
                  padding: EdgeInsets.symmetric(horizontal: 100,vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  )
            ),
                child: widget.isUpdated?Text("UPDATE",style: TextStyle(fontSize: 18,color: Colors.white),):Text("ADD",style: TextStyle(fontSize: 18,color: Colors.white),)),
          ],
        ),
      ),

      /*Center(child: IconButton(onPressed: (){
      context.read<TodoCubit>().addTodo(
        title: "h5555i",
        desc: "desc",


      );

    }, icon: Icon(Icons.done,size: 50,))),*/
    );
  }
}
