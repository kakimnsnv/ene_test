import 'package:ene_test/features/workspace/domain/entities/workspace.dart';
import 'package:ene_test/features/workspace/domain/usecases/get_workspaces.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../mock_workspace_repo.mocks.dart';

void main() {
  late MockWorkspaceRepo mockWorkspaceRepository;
  late GetWorkspaces usecase;

  setUp(() {
    mockWorkspaceRepository = MockWorkspaceRepo();
    usecase = GetWorkspaces(mockWorkspaceRepository);
  });

  final workspaceList = [Workspace(id: 1, name: 'Test Workspace')];

  test('should get list of workspaces from repository', () async {
    when(mockWorkspaceRepository.getWorkspaces()).thenAnswer((_) async => workspaceList);

    final result = await usecase();

    expect(result, workspaceList);
    verify(mockWorkspaceRepository.getWorkspaces());
    verifyNoMoreInteractions(mockWorkspaceRepository);
  });
}
