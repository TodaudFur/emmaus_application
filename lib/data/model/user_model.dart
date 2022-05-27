class UserModel {
  String id;
  String name;
  String cell;
  String team;
  String term;
  String isFirst;
  int special;
  int normal;

  UserModel(
      {required this.id,
      required this.name,
      required this.cell,
      required this.team,
      required this.term,
      required this.isFirst,
      required this.special,
      required this.normal});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      cell: json['cell'],
      team: json['team'],
      term: json['term'],
      isFirst: json['isFirst'],
      special: int.parse(json['special']),
      normal: int.parse(json['normal']),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'cell': cell,
        'team': team,
        'term': term,
        'isFirst': isFirst,
        'special': special,
        'normal': normal,
      };
}
