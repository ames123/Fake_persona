import 'package:schedule_sleuth/game_state.dart';
import 'package:schedule_sleuth/role.dart';

class Player {
  int id;
  String displayName;
  Role? role;
  String? freeTime;
  String? action1;
  String? action2;
  String? action3;
  String? action4;
  String? action5;
  bool freeTimeReady;
  bool orderingReady;
  bool positionReady;
  bool hourEnded;

  Player({
    required this.id,
    required this.displayName,
    this.role,
    this.freeTime,
    this.action1,
    this.action2,
    this.action3,
    this.action4,
    this.action5,
    required this.freeTimeReady,
    required this.orderingReady,
    required this.positionReady,
    required this.hourEnded
  });

  factory Player.fromJson(Map<String, dynamic> json){
    return Player(
      id: json['id'],
      displayName: json['displayName'],
      role: Role.fromJson(json['role']),
      freeTime: json['freeTime'],
      action1: json['action1'],
      action2: json['action2'],
      action3: json['action3'],
      action4: json['action4'],
      action5: json['action5'],
      freeTimeReady: json['freeTimeReady'],
      orderingReady: json['orderingReady'],
      positionReady: json['positionReady'],
      hourEnded: json['hourEnded']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'displayName': displayName,
      'role': role,
      'freeTime': freeTime,
      'action1': action1,
      'action2': action2,
      'action3': action3,
      'action4': action4,
      'action5': action5,
      'freeTimeReady': freeTimeReady,
      'orderingReady': orderingReady,
      'positionReady': positionReady,
      'hourEnded': hourEnded
    };
  }

  PlayerInvestigationData toPlayerData(){
    return PlayerInvestigationData(initials: displayName, 
    locations: {}, 
    actions: {}
    );
  }

  String getInitials(String str) => str.isNotEmpty
    ? str.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
    : '';
}