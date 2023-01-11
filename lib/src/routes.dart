import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jnote/src/presentation/ui/pages/add_task_page.dart';
import 'package:jnote/src/presentation/ui/pages/home_page.dart';
import 'package:jnote/src/presentation/ui/pages/task_details_page.dart';

abstract class Routes {
  static const initialRoute = "/";

  static final router = GoRouter(
    initialLocation: initialRoute,
    routes: [
      GoRoute(
        path: initialRoute,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            MaterialPage<void>(
          key: state.pageKey,
          child: HomePage(
            onTapItem: (task) => context.push("/tasks/${task.id}/details"),
            onTapAdd: () => context.push("/tasks/create"),
          ),
        ),
        routes: [
          GoRoute(
            path: "tasks/create",
            pageBuilder: (BuildContext context, GoRouterState state) =>
                MaterialPage<void>(
              key: state.pageKey,
              child: const AddTaskPage(),
            ),
          ),
          GoRoute(
            path: "tasks/:id/details",
            pageBuilder: (BuildContext context, GoRouterState state) {
              final id = int.parse(state.params["id"].toString());
              return MaterialPage<void>(
                key: state.pageKey,
                child: TaskDetailsPage(
                  id: id,
                ),
              );
            },
          ),
        ],
      )
    ],
  );
}
