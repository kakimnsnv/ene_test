import 'package:ene_test/features/workspace/domain/usecases/remove_workspace.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../mock_workspace_repo.mocks.dart';

void main() {
  late MockWorkspaceRepo mockWorkspaceRepository;
  late RemoveWorkspace usecase;

  setUp(() {
    mockWorkspaceRepository = MockWorkspaceRepo();
    usecase = RemoveWorkspace(mockWorkspaceRepository);
  });

  final workspaceId = 1;

  test('should remove workspace from repository', () async {
    when(mockWorkspaceRepository.removeWorkspace(workspaceId)).thenAnswer((_) async => null);

    await usecase(workspaceId);

    verify(mockWorkspaceRepository.removeWorkspace(workspaceId));
    verifyNoMoreInteractions(mockWorkspaceRepository);
  });
}
