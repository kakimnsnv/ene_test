class Workspace {
  final int? id;
  final String name;

  Workspace({this.id, required this.name});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Workspace.fromJson(Map<String, dynamic> map) {
    return Workspace(
      id: map['id'],
      name: map['name'],
    );
  }
}
