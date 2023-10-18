// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:todo_app_new/Widgets/custom_text.dart';
//
// import '../../../model/tasks_model.dart';
//
// class TasksList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Box? _box;
//     List tasks = _box!.values.toList();
//     TaskModel _newTask =
//         TaskModel(content: 'content', timeStamp: DateTime.now(), done: true);
//     _box.add(_newTask.toMap());
//
//     return ListView.builder(
//       itemCount: tasks.length,
//       shrinkWrap: true,
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       itemBuilder: (context, index) {
//         var task = TaskModel.fromMap(tasks[index]);
//         return ListTile(
//           title: CustomText(
//             text: task.content,
//             decoration: task.done ? TextDecoration.lineThrough : null,
//             color: Colors.black,
//           ),
//           subtitle: CustomText(
//             text: task.timeStamp.toString(),
//           ),
//           trailing: Icon(
//             task.done
//                 ? Icons.check_box_outlined
//                 : Icons.check_box_outline_blank_outlined,
//             color: Colors.red,
//           ),
//         );
//       },
//     );
//   }
// }
