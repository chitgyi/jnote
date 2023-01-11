import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jnote/src/presentation/notifiers/task_details_notifier.dart';
import 'package:jnote/src/presentation/ui/widgets/common/custom_check_box.dart';
import 'package:jnote/src/utils/constants/jnote_icons.dart';
import 'package:jnote/src/utils/constants/strings.dart';

class TaskDetailsPage extends ConsumerWidget {
  const TaskDetailsPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(taskDeatilsProvider).loadTask(id);
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
      body: const _TaskDetailBody(),
    );
  }
}

class _TaskDetailBody extends ConsumerWidget {
  const _TaskDetailBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(taskDeatilsProvider);

    return provider.viewState.when(
      failed: (msg) => Center(child: Text(msg)),
      success: (task) {
        final formKey = GlobalKey<FormState>();

        final desController = TextEditingController(text: task.description);
        final titleController = TextEditingController(text: task.title);
        bool isChecked = task.isCompleted;
        return Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              CustomCheckBox(
                isChecked: isChecked,
                onChanged: (value) => isChecked = value,
              ),
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
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          provider.updateTask(
                            task.copyWith(
                              title: titleController.text,
                              description: desController.text,
                              isCompleted: isChecked,
                            ),
                          );
                          context.pop();
                        }
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
                      if (formKey.currentState!.validate()) {
                        provider.deleteTask(task);
                        context.pop();
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Text(deleteTask),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
