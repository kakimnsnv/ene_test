import 'package:ene_test/features/workspace/data/data_sources/workspace_local_data_source.dart';
import 'package:ene_test/features/workspace/data/repos/workspace_repo_impl.dart';
import 'package:ene_test/features/workspace/domain/usecases/add_workspace.dart';
import 'package:ene_test/features/workspace/domain/usecases/get_workspaces.dart';
import 'package:ene_test/features/workspace/domain/usecases/remove_workspace.dart';
import 'package:ene_test/features/workspace/domain/usecases/search_workspace.dart';
import 'package:ene_test/features/workspace/presentation/pages/workspace_screen.dart';
import 'package:ene_test/features/workspace/presentation/providers/workspace_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localDataSource = WorkspaceLocalDataSourceImpl();
  final repository = WorkspaceRepoImpl(localDataSource: localDataSource);
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final WorkspaceRepoImpl repository;

  MyApp({required this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WorkspaceProvider(
            getWorkspaces: GetWorkspaces(repository),
            addWorkspace: AddWorkspace(repository),
            removeWorkspace: RemoveWorkspace(repository),
            searchWorkspacesUseCase: SearchWorkspaces(repository),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Workspace App',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: WorkspaceScreen(),
      ),
    );
  }
}
