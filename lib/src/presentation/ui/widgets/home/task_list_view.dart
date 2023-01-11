import 'package:flutter/material.dart';
import 'package:jnote/src/domain/entities/task.dart';
import 'package:jnote/src/utils/constants/jnote_icons.dart';
import 'package:jnote/src/utils/constants/strings.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({
    this.tasks = const [],
    this.onTapItem,
    Key? key,
  }) : super(key: key);
  final List<Task> tasks;
  final void Function(Task task)? onTapItem;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(
        child: Text(emptyTaskMessage),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];

        return _TaskListItem(
          onTapItem: onTapItem,
          task: task,
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 16.0),
    );
  }
}

class _TaskListItem extends StatelessWidget {
  const _TaskListItem({
    Key? key,
    required this.onTapItem,
    required this.task,
  }) : super(key: key);

  final void Function(Task task)? onTapItem;
  final Task task;

  @override
  Widget build(BuildContext context) {
    final color = task.isCompleted
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).primaryColor;
    return InkWell(
      onTap: () => onTapItem?.call(task),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0)),
            child: Center(
              child: Icon(
                task.isCompleted ? JNoteIcons.completed : JNoteIcons.inprogress,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 4.0),
                Text(
                  task.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => onTapItem?.call(task),
            icon: const Icon(
              JNoteIcons.next,
              size: 14,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
