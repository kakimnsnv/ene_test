import 'package:ene_test/features/workspace/domain/entities/workspace.dart';
import 'package:ene_test/features/workspace/domain/repos/workspace_repo.dart';

class SearchWorkspaces {
  final WorkspaceRepo repository;

  SearchWorkspaces(this.repository);

  Future<List<Workspace>> call(String searchText) async {
    return await repository.searchWorkspaces(searchText);
  }
}
