import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jnote/src/di/locator.dart';
import 'package:jnote/src/presentation/notifiers/task_details_notifier.dart';
import 'package:jnote/src/presentation/ui/widgets/common/custom_check_box.dart';
import 'package:jnote/src/utils/constants/jnote_icons.dart';
import 'package:jnote/src/utils/constants/strings.dart';
import 'package:provider/provider.dart';

class TaskDetailsPage extends StatelessWidget {
  const TaskDetailsPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            color: Theme.of(context).primaryColor,
          ),
          padding: EdgeInsets.only(
            top: (MediaQuery.of(context).padding.top * 0.5) + 10.0,
            bottom: 4.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  JNoteIcons.back,
                  size: 14,
                  color: Colors.white,
                ),
              ),
              const Expanded(
                child: Text(
                  details,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ChangeNotifierProvider<TaskDetailsNotifier>(
        create: (BuildContext context) => di.get()..loadTask(id),
        child: const _TaskDetailBody(),
      ),
    );
  }
}

class _TaskDetailBody extends StatelessWidget {
  const _TaskDetailBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskDetailsNotifier>(
      builder: (context, notifier, child) => notifier.viewState.when(
        failed: (msg) => Center(child: Text(msg)),
        success: (task) {
          bool isChecked = task.isCompleted;
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              CustomCheckBox(
                isChecked: isChecked,
                onChanged: (value) => isChecked = value,
              ),
              TextField(
                controller: notifier.titleController,
                decoration: InputDecoration(
                  hintText: title,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: notifier.desController,
                maxLines: 15,
                decoration: InputDecoration(
                  hintText: description,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        notifier
                            .updateTask(
                              task.copyWith(
                                title: notifier.titleController.text,
                                description: notifier.desController.text,
                                isCompleted: isChecked,
                              ),
                            )
                            .catchError(
                              (msg) => ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                      SnackBar(content: Text(msg.toString()))),
                            )
                            .then((value) => context.pop());
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text(update),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey),
                    ),
                    onPressed: () {
                      notifier.deleteTask(task);
                      context.pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Text(deleteTask),
                    ),
                  )
                ],
              )
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
