import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app_new/Views/Home_Screen/components/tasks_list.dart';
import 'package:todo_app_new/Widgets/custom_text.dart';

import '../../model/tasks_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _newTaskContent;
  Box? _box;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        toolbarHeight: height * 0.15,
        title: CustomText(
          text: 'Tasky!',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      body: _taskView(),
      floatingActionButton: _addTaskButton(),
    );
  }

// to show added tasks on screen
  Widget _taskView() {
    return FutureBuilder(
      future: Hive.openBox('tasks'),
      builder: (context, AsyncSnapshot _snapshot) {
        if (_snapshot.hasData) {
          // (_snapshot.connectionState == ConnectionState.done) {
          _box = _snapshot.data;
          return _taskList();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _taskList() {
    List tasks = _box!.values.toList();
    return ListView.builder(
      itemCount: tasks.length,
      shrinkWrap: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      itemBuilder: (context, index) {
        var task = TaskModel.fromMap(tasks[index]);
        return ListTile(
          title: CustomText(
            text: task.content,
            decoration: task.done ? TextDecoration.lineThrough : null,
            color: Colors.black,
          ),
          subtitle: CustomText(
            text: task.timeStamp.toString(),
          ),
          trailing: Icon(
            task.done
                ? Icons.check_box_outlined
                : Icons.check_box_outline_blank_outlined,
            color: Colors.red,
          ),
          onTap: () {
            task.done = !task.done;
            _box!.putAt(index, task.toMap());
            setState(() {});
          },
          onLongPress: () {
            _box!.delete(index);
            setState(() {});
          },
        );
      },
    );
  }

  FloatingActionButton _addTaskButton() {
    return FloatingActionButton(
      onPressed: () {
        _displaytaskPopUp();
      },
      child: Icon(Icons.add),
    );
  }

  void _displaytaskPopUp() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: CustomText(
            text: 'Add New Task',
          ),
          content: TextField(
            onChanged: (value) {
              setState(() {
                _newTaskContent = value;
              });
            },
            onSubmitted: (value) {
              if (_newTaskContent != null) {
                TaskModel _newTask = TaskModel(
                    content: _newTaskContent!,
                    timeStamp: DateTime.now(),
                    done: false);
                _box!.add(_newTask.toMap());
                setState(() {
                  _newTaskContent = null;
                  Navigator.pop(context);
                });
              }
            },
          ),
        );
      },
    );
  }
}
