

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

Widget defaultButton ({
  Color color = Colors.blue,
  double width = double.infinity,
  double raduis = 0,
  bool isUpperCase = true,
  @required  Function() fanction,
  @required String text,
}) {
  return Container(
    height: 40,
    width: width,
    child: MaterialButton(onPressed: fanction,
      child: Text(
        isUpperCase? text.toUpperCase() : text,
        style: TextStyle(color: Colors.white),),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(raduis),
      color: color,
    ),
  );
}
 Widget defaultFormFile({
   @required TextEditingController controller,
   Function  onsubmit,
   @required Function validator,
   @required String lable,
   @required IconData prefix,
   Function onTap,
   TextInputType type,
   IconData suffix,
   bool enable = true,
   bool isPassword = false,
}) => TextFormField(
    controller: controller,
    obscureText: isPassword,
    keyboardType:type  ,
    onFieldSubmitted: onsubmit,
    validator:validator,
    onTap: onTap,
    enabled: enable ,
    decoration: InputDecoration(
      labelText: lable,
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null ?  Icon(suffix) : null,
      border: OutlineInputBorder(

      ),

    ),

  );

Widget bulidTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(15.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 40,

          child: Text(

              '${model['time']}'

          ),

        ),

        SizedBox(

          width: 20,

        ),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            children: [

              Text(

               '${model['title']}',

                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),

              ),

              Text(

                '${model['date']}',

                style: TextStyle(fontSize: 18, color: Colors.grey),

              ),

            ],

          ),

        ),

        SizedBox(

          width: 20,

        ),

        IconButton(

            onPressed: (){

              AppCubit.get(context).updateData(status: 'done', id: model['id'],);

            },

            icon: Icon(Icons.check_box),color: Colors.green,),

        IconButton(

          onPressed: (){

           AppCubit.get(context).updateData(status: 'archive', id: model['id'],);

          },

          icon: Icon(Icons.archive),color: Colors.grey,),

      ],

    ),

  ),
  onDismissed: (direction){
    AppCubit.get(context).deleteData(id: model['id']);
  },
);


Widget tasksBuilder({@required List<Map> tasks}) => ConditionalBuilder(
  condition: tasks.length > 0,
  builder: (context) => ListView.separated(
      itemBuilder: (context, index) {
        return bulidTaskItem(tasks[index], context);
      },
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsetsDirectional.only(start: 20.0),
        child: Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey,
        ),
      ),
      itemCount: tasks.length),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100,
          color: Colors.grey,
        ),
        Text(
          'No Taks Yet, Please Add Some Tasks',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey),
        ),
      ],
    ),
  ),
);