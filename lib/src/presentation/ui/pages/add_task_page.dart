import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jnote/src/presentation/notifiers/add_task_notifier.dart';
import 'package:jnote/src/utils/constants/jnote_icons.dart';
import 'package:jnote/src/utils/constants/strings.dart';

class AddTaskPage extends ConsumerWidget {
  const AddTaskPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(addTaskProvider);
    final formKey = GlobalKey<FormState>();
    final desController = TextEditingController();
    final titleController = TextEditingController();
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
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  return null;
                }
                return '*Required';
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
                if (value != null && value.isNotEmpty) {
                  return null;
                }
                return '*Required';
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
                  provider.saveTask(
                    titleController.text,
                    desController.text,
                  );
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
      ),
    );
  }
}
