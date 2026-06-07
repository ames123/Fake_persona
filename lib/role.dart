
class Role {
  int id;
  String name;
  String roleAction1;
  String roleAction2;
  String roleAction3;
  String roleAction4;
  String roleAction5;

  Role({
    required this.id,
    required this.name,
    required this.roleAction1,
    required this.roleAction2,
    required this.roleAction3,
    required this.roleAction4,
    required this.roleAction5
  });

  factory Role.fromJson(Map<String, dynamic>? json){
    if(json != null){
    return Role(
      id: json['id'],
      name: json['name'],
      roleAction1: json['roleAction1'],
      roleAction2: json['roleAction2'],
      roleAction3: json['roleAction3'],
      roleAction4: json['roleAction4'],
      roleAction5: json['roleAction5']
    );
    } else {
      return Role(id: 9999, name: "", roleAction1: "", roleAction2: "", roleAction3: "", roleAction4: "", roleAction5: "");
    }
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'roleAction1': roleAction1,
      'roleAction2': roleAction2,
      'roleAction3': roleAction3,
      'roleAction4': roleAction4,
      'roleAction5': roleAction5
    };
  }
}