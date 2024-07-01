import 'package:dartz/dartz.dart';
import 'package:ene_test/core/error/failure.dart';
import 'package:ene_test/features/workspace/domain/entities/workspace.dart';

abstract class WorkspaceRepo {
  Future<List<Workspace>> getWorkspaces();
  Future<void> addWorkspace(Workspace workspace);
  Future<void> removeWorkspace(int id);
  Future<List<Workspace>> searchWorkspaces(String searchText);
}
