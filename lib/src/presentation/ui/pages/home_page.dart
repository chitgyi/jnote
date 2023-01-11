import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jnote/src/domain/entities/task.dart';
import 'package:jnote/src/presentation/notifiers/tasks_notifier.dart';
import 'package:jnote/src/presentation/ui/widgets/common/custom_tap_bar.dart';
import 'package:jnote/src/presentation/ui/widgets/home/task_list_view.dart';
import 'package:jnote/src/utils/constants/jnote_icons.dart';
import 'package:jnote/src/utils/constants/strings.dart';

class HomePage extends ConsumerWidget {
  const HomePage({
    Key? key,
    this.onTapItem,
    this.onTapAdd,
  }) : super(key: key);
  final void Function(Task task)? onTapItem;
  final VoidCallback? onTapAdd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(tasksProvider).loadTasks();
    return WillPopScope(
      onWillPop: () async {
        final result = await showExitDialog(context);
        return result ?? false;
      },
      child: Scaffold(
        body: Column(
          children: [
            const _AppBar(),
            Expanded(
              child: _TabBar(onTapItem: onTapItem),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: onTapAdd,
          child: const Icon(
            JNoteIcons.add,
            size: 18,
          ),
        ),
      ),
    );
  }

  Future<bool?> showExitDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(warning),
        content: const Text(exitWarningMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              cancel.toUpperCase(),
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          TextButton(
            onPressed: () => {Navigator.pop(context, true)},
            child: Text(
              ok.toUpperCase(),
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          )
        ],
      ),
    );
  }
}

class _TabBar extends ConsumerWidget {
  const _TabBar({
    Key? key,
    required this.onTapItem,
  }) : super(key: key);

  final void Function(Task task)? onTapItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider).tasks;
    return CustomTabBar(
      tabViews: [
        TaskListView(
          onTapItem: onTapItem,
          tasks: tasks.where((element) => !element.isCompleted).toList(),
        ),
        TaskListView(
          onTapItem: onTapItem,
          tasks: tasks.where((element) => element.isCompleted).toList(),
        ),
      ],
      items: const [
        CustomTabItem(
          iconData: JNoteIcons.inprogress,
          text: remainingTasks,
        ),
        CustomTabItem(
          iconData: JNoteIcons.completed,
          text: completedTasks,
        ),
      ],
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top * 0.6),
          Text(
            "JNote",
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
