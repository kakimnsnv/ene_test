import 'package:ene_test/features/workspace/domain/repos/workspace_repo.dart';

import '../entities/workspace.dart';

class GetWorkspaces {
  final WorkspaceRepo repository;

  GetWorkspaces(this.repository);

  Future<List<Workspace>> call() async {
    return await repository.getWorkspaces();
  }
}
