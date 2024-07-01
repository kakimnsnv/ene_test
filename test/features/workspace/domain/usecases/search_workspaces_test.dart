import 'package:ene_test/features/workspace/domain/entities/workspace.dart';
import 'package:ene_test/features/workspace/domain/usecases/search_workspace.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../mock_workspace_repo.mocks.dart';

void main() {
  late MockWorkspaceRepo mockWorkspaceRepository;
  late SearchWorkspaces usecase;

  setUp(() {
    mockWorkspaceRepository = MockWorkspaceRepo();
    usecase = SearchWorkspaces(mockWorkspaceRepository);
  });

  final workspaceList = [Workspace(id: 1, name: 'Test Workspace')];

  test('should get list of workspaces from repository', () async {
    // Arrange
    when(mockWorkspaceRepository.searchWorkspaces("Test")).thenAnswer((_) async => workspaceList);

    // Act
    final result = await usecase("Test");

    // Assert
    expect(result, workspaceList);
    verify(mockWorkspaceRepository.searchWorkspaces("Test"));
    verifyNoMoreInteractions(mockWorkspaceRepository);
  });
}
