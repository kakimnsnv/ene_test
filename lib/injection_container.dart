import 'package:ene_test/features/workspace/data/data_sources/workspace_local_data_source.dart';
import 'package:ene_test/features/workspace/data/repos/workspace_repo_impl.dart';
import 'package:ene_test/features/workspace/domain/repos/workspace_repo.dart';
import 'package:ene_test/features/workspace/domain/usecases/search_workspace.dart';
import 'package:get_it/get_it.dart';
import 'core/database/database_helper.dart';
import 'features/workspace/domain/usecases/get_workspaces.dart';
import 'features/workspace/domain/usecases/add_workspace.dart';
import 'features/workspace/domain/usecases/remove_workspace.dart';
import 'features/workspace/presentation/providers/workspace_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Providers
  sl.registerFactory(() => WorkspaceProvider(getWorkspaces: sl(), addWorkspace: sl(), removeWorkspace: sl(), searchWorkspacesUseCase: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetWorkspaces(sl()));
  sl.registerLazySingleton(() => AddWorkspace(sl()));
  sl.registerLazySingleton(() => RemoveWorkspace(sl()));
  sl.registerLazySingleton(() => SearchWorkspaces(sl()));

  // Repository
  sl.registerLazySingleton<WorkspaceRepo>(
    () => WorkspaceRepoImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<WorkspaceLocalDataSource>(
    () => WorkspaceLocalDataSourceImpl(),
  );

  // Database
  sl.registerLazySingleton(() => DatabaseHelper());
}
