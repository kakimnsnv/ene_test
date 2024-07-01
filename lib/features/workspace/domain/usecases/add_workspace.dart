import 'package:ene_test/features/workspace/domain/repos/workspace_repo.dart';

import '../entities/workspace.dart';

class AddWorkspace {
  final WorkspaceRepo repository;

  AddWorkspace(this.repository);

  Future<void> call(Workspace workspace) async {
    await repository.addWorkspace(workspace);
  }
}
