import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/utils/app_snackbar.dart';
import 'package:frontend/features/task/presentation/bloc/task_bloc.dart';
import 'package:frontend/features/task/presentation/widgets/custom_list_tile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final titleController = TextEditingController();
  final descripController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descripController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: white,
        title: const Text(
          'To-Do List',
          style: TextStyle(color: white, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.deepPurple.shade300,
                child: Container(
                  height: 30.h,
                  width: 80.w,
                  child: Padding(
                    padding: EdgeInsets.all(2.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            hintText: 'Title',
                            hintStyle: TextStyle(color: Colors.deepPurple),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepPurple, width: 2)),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        TextField(
                          controller: descripController,
                          decoration: const InputDecoration(
                            hintText: 'Description',
                            hintStyle: TextStyle(color: Colors.deepPurple),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepPurple, width: 2)),
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                if (titleController.text.isNotEmpty &&
                                    descripController.text.isNotEmpty) {
                                  context.read<TaskBloc>().add(AddNewTaskEvent(
                                        title: titleController.text.trim(),
                                        description:
                                            descripController.text.trim(),
                                      ));
                                }
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Add Task',
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: white),
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskErrorState) {
            return AppSnack.error(context, state.message);
          }
          if (state is TaskLoadedState) {
            return AppSnack.success(context, 'Tasks fetched successfully...');
          }
        },
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is TaskLoadedState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  final task = state.tasks[index];
                  return CustomListTile(
                    value: task.completed,
                    id: task.id,
                    title: task.title,
                    description: task.description,
                    onChanged: (value) {
                      context
                          .read<TaskBloc>()
                          .add(UpdateTaskCompletionEvent(task.id, value!));
                    },
                    onDelete: (context) {
                      context
                          .read<TaskBloc>()
                          .add(DeleteTaskEvent(id: task.id));
                    },
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
