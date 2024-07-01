import 'package:ene_test/features/workspace/domain/entities/workspace.dart';
import 'package:ene_test/features/workspace/domain/usecases/add_workspace.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../mock_workspace_repo.mocks.dart';

void main() {
  late MockWorkspaceRepo mockWorkspaceRepository;
  late AddWorkspace usecase;

  setUp(() {
    mockWorkspaceRepository = MockWorkspaceRepo();
    usecase = AddWorkspace(mockWorkspaceRepository);
  });

  final workspace = Workspace(name: 'New Workspace');

  test('should add workspace to repository', () async {
    when(mockWorkspaceRepository.addWorkspace(workspace)).thenAnswer((_) async => null);

    await usecase(workspace);

    verify(mockWorkspaceRepository.addWorkspace(workspace));
    verifyNoMoreInteractions(mockWorkspaceRepository);
  });
}
