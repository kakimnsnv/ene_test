import 'package:ene_test/features/workspace/presentation/providers/workspace_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkspaceScreen extends StatefulWidget {
  @override
  _WorkspaceScreenState createState() => _WorkspaceScreenState();
}

class _WorkspaceScreenState extends State<WorkspaceScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<WorkspaceProvider>(context, listen: false).fetchWorkspaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Рабочие пространства'),
        leading: const Icon(Icons.settings),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddWorkspaceDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Поиск',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                Provider.of<WorkspaceProvider>(context, listen: false).searchWorkspaces(value);
              },
            ),
          ),
          Expanded(
            child: Consumer<WorkspaceProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (provider.workspaces.isEmpty) {
                  return Center(child: Text('No Workspaces Available'));
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: provider.workspaces.length,
                  itemBuilder: (context, index) {
                    final workspace = provider.workspaces[index];
                    return Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.primaries[index % Colors.primaries.length],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  Provider.of<WorkspaceProvider>(context, listen: false).deleteWorkspace(workspace.id!);
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                workspace.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddWorkspaceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Workspace'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Workspace Name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final name = _controller.text;
                if (name.isNotEmpty) {
                  Provider.of<WorkspaceProvider>(context, listen: false).addNewWorkspace(name);
                  _controller.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
