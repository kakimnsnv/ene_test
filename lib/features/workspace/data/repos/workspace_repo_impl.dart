import 'package:ene_test/features/workspace/domain/repos/workspace_repo.dart';
import 'package:ene_test/features/workspace/data/data_sources/workspace_local_data_source.dart';

import '../../domain/entities/workspace.dart';

class WorkspaceRepoImpl implements WorkspaceRepo {
  final WorkspaceLocalDataSource localDataSource;

  WorkspaceRepoImpl({required this.localDataSource});

  @override
  Future<List<Workspace>> getWorkspaces() async {
    return await localDataSource.getWorkspaces();
  }

  @override
  Future<void> addWorkspace(Workspace workspace) async {
    await localDataSource.addWorkspace(workspace);
  }

  @override
  Future<void> removeWorkspace(int id) async {
    await localDataSource.removeWorkspace(id);
  }

  @override
  Future<List<Workspace>> searchWorkspaces(String searchText) async {
    return await localDataSource.searchWorkspaces(searchText);
  }
}
