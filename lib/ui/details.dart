import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/cubit/todo_cubit.dart';

class Details extends StatelessWidget {


  String title='';
  String desc='';
  String createdAt='';

  Details({this.title='' ,this.desc='',this.createdAt=''});




  @override
  Widget build(BuildContext context) {
    var eachTime= DateTime.fromMicrosecondsSinceEpoch(int.parse(createdAt));

    DateFormat dateFormat= DateFormat.yMMMEd();
    return Scaffold(
      backgroundColor: Color(0xffD6D7EF),
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        title: Text("Detail",style: TextStyle(color: Colors.white),),

        backgroundColor: Color(0xff9395d3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Color(0xff9395d3)),),
            SizedBox(
              height: 12,
            ),
            Text(dateFormat.format(eachTime),style: TextStyle(color: Colors.grey),),

            SizedBox(
              height: 20,
            ),
            Text(desc,style: TextStyle(fontSize: 18,),),

          ],
        ),
      ),
      
    );
  }
}
