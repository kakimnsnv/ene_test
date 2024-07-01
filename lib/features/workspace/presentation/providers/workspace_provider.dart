import 'dart:developer';

import 'package:ene_test/features/workspace/domain/usecases/search_workspace.dart';
import 'package:flutter/material.dart';
import 'package:ene_test/features/workspace/domain/usecases/get_workspaces.dart';
import 'package:ene_test/features/workspace/domain/usecases/add_workspace.dart';
import 'package:ene_test/features/workspace/domain/usecases/remove_workspace.dart';
import 'package:ene_test/features/workspace/domain/entities/workspace.dart';

class WorkspaceProvider with ChangeNotifier {
  final GetWorkspaces getWorkspaces;
  final AddWorkspace addWorkspace;
  final RemoveWorkspace removeWorkspace;
  final SearchWorkspaces searchWorkspacesUseCase;

  WorkspaceProvider({
    required this.getWorkspaces,
    required this.addWorkspace,
    required this.removeWorkspace,
    required this.searchWorkspacesUseCase,
  });

  List<Workspace> _workspaces = [];
  List<Workspace> get workspaces => _workspaces;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchWorkspaces() async {
    _setLoading(true);
    final result = await getWorkspaces();
    _workspaces = result;
    _setLoading(false);
  }

  Future<void> addNewWorkspace(String name) async {
    _setLoading(true);
    final newWorkspace = Workspace(name: name);
    await addWorkspace(newWorkspace);
    fetchWorkspaces();
  }

  Future<void> deleteWorkspace(int id) async {
    _setLoading(true);
    await removeWorkspace(id);
    fetchWorkspaces();
  }

  Future<void> searchWorkspaces(String searchText) async {
    _setLoading(true);
    final result = await searchWorkspacesUseCase(searchText);
    _workspaces = result;
    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    _notifyListenersSafely();
  }

  void _notifyListenersSafely() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
