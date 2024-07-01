import 'package:ene_test/features/workspace/domain/repos/workspace_repo.dart';

class RemoveWorkspace {
  final WorkspaceRepo repository;

  RemoveWorkspace(this.repository);

  Future<void> call(int id) async {
    await repository.removeWorkspace(id);
  }
}
