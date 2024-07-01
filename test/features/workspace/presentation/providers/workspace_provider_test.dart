// test/workspace_provider_test.dart
import 'package:ene_test/features/workspace/domain/entities/workspace.dart';
import 'package:ene_test/features/workspace/domain/usecases/add_workspace.dart';
import 'package:ene_test/features/workspace/domain/usecases/get_workspaces.dart';
import 'package:ene_test/features/workspace/domain/usecases/remove_workspace.dart';
import 'package:ene_test/features/workspace/domain/usecases/search_workspace.dart';
import 'package:ene_test/features/workspace/presentation/providers/workspace_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../../mock_workspace_repo.mocks.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late MockWorkspaceRepo mockWorkspaceRepository;
  late GetWorkspaces getWorkspaces;
  late AddWorkspace addWorkspace;
  late RemoveWorkspace removeWorkspace;
  late SearchWorkspaces searchWorkspaces;
  late WorkspaceProvider workspaceProvider;

  setUp(() {
    mockWorkspaceRepository = MockWorkspaceRepo();
    getWorkspaces = GetWorkspaces(mockWorkspaceRepository);
    addWorkspace = AddWorkspace(mockWorkspaceRepository);
    removeWorkspace = RemoveWorkspace(mockWorkspaceRepository);
    searchWorkspaces = SearchWorkspaces(mockWorkspaceRepository);
    workspaceProvider = WorkspaceProvider(
      getWorkspaces: getWorkspaces,
      addWorkspace: addWorkspace,
      removeWorkspace: removeWorkspace,
      searchWorkspacesUseCase: searchWorkspaces,
    );
  });

  final workspace = Workspace(id: 1, name: 'Test Workspace');
  final workspaceList = [workspace];

  test('should fetch workspaces', () async {
    when(mockWorkspaceRepository.getWorkspaces()).thenAnswer((_) async => workspaceList);

    await workspaceProvider.fetchWorkspaces();

    expect(workspaceProvider.workspaces, workspaceList);
    expect(workspaceProvider.isLoading, false);
  });

  test('should add a workspace', () async {
    when(mockWorkspaceRepository.getWorkspaces()).thenAnswer((_) async => workspaceList);
    when(mockWorkspaceRepository.addWorkspace(any)).thenAnswer((_) async => null);

    await workspaceProvider.addNewWorkspace('New Workspace');

    verify(mockWorkspaceRepository.addWorkspace(any)).called(1);
  });

  test('should remove a workspace', () async {
    when(mockWorkspaceRepository.getWorkspaces()).thenAnswer((_) async => workspaceList);
    when(mockWorkspaceRepository.removeWorkspace(any)).thenAnswer((_) async => null);

    await workspaceProvider.deleteWorkspace(1);

    verify(mockWorkspaceRepository.removeWorkspace(1)).called(1);
  });

  test('should search workspaces', () async {
    when(mockWorkspaceRepository.searchWorkspaces('Test')).thenAnswer((_) async => workspaceList);

    await workspaceProvider.searchWorkspaces('Test');

    expect(workspaceProvider.workspaces, workspaceList);
    expect(workspaceProvider.isLoading, false);
  });
}
