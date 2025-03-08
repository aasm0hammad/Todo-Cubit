import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/cubit/todo_state.dart';
import 'package:todo/data/todo_model.dart';
import 'package:todo/ui/details.dart';

import 'add_todo.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<TodoCubit>().initialTodo();
  }

  @override
  Widget build(BuildContext context) {
    print("object bui cont");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff9395D3),
        title: Text(
          "TODO APP",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Color(0xffD6D7EF),
      body: BlocBuilder<TodoCubit, TodoState>(builder: (_, state) {
        return ListView.builder(
            itemCount: state.mTodo.length,
            itemBuilder: (_, index) {
              TodoModel eachTodo = state.mTodo[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Details(
                                title: eachTodo.tTitle,
                                desc: eachTodo.tDesc,
                                createdAt: eachTodo.tCreatedAt,
                              )));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          spreadRadius: 2,
                          offset: Offset(0, 4))
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      eachTodo.tTitle,
                      style: TextStyle(
                          color: Color(0xff9395D3),
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(eachTodo.tDesc),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!eachTodo.isCompleted)
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddTodo(
                                              isUpdated: true,
                                              id: eachTodo.tID!,
                                              title: eachTodo.tTitle,
                                              desc: eachTodo.tDesc,
                                              createdAt: eachTodo.tCreatedAt,
                                            )));
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Color(0xff9395D3),
                              )),
                        if (!eachTodo.isCompleted)
                          IconButton(
                            onPressed: () {
                              context
                                  .read<TodoCubit>()
                                  .deleteTodo(id: eachTodo.tID!);
                            },
                            icon: Icon(Icons.delete_forever),
                            color: Color(0xff9395D3),
                          ),
                        IconButton(
                          onPressed: () {
                            context.read<TodoCubit>().isComplete(
                                  id: eachTodo.tID!,
                                  isCompleted: !eachTodo
                                      .isCompleted,
                                );
                          },
                          icon: Icon(
                            eachTodo.isCompleted
                                ? Icons.check_circle
                                : Icons.check_circle_outline,
                            color: Color(0xff9395D3),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTodo()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
