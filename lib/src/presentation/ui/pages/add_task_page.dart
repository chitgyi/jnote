import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jnote/src/di/locator.dart';
import 'package:jnote/src/presentation/notifiers/add_task_notifier.dart';
import 'package:jnote/src/utils/constants/jnote_icons.dart';
import 'package:jnote/src/utils/constants/strings.dart';
import 'package:provider/provider.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<AddTaskProvider>(
      create: (_) => di.get(),
      child: Scaffold(
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
                const Text(
                  details,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: const _AddTaskForm(),
      ),
    );
  }
}

class _AddTaskForm extends StatelessWidget {
  const _AddTaskForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final desController = TextEditingController();
    final titleController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '*Please enter title...';
              }
              return null;
            },
            controller: titleController,
            decoration: InputDecoration(
              hintText: title,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '*Please enter description...';
              }
              return null;
            },
            controller: desController,
            maxLines: 15,
            decoration: InputDecoration(
              hintText: description,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context
                    .read<AddTaskProvider>()
                    .saveTask(titleController.text, desController.text);
                context.pop();
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(14.0),
              child: Text(addTask),
            ),
          )
        ],
      ),
    );
  }
}
