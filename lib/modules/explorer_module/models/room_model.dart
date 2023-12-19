class Room {
  String name;
  int id;
  List<dynamic>
      props; //we need to dig into this one to see which viewables links with the room id!
  Room({
    required this.name,
    required this.id,
    required this.props,
  });

  factory Room.fromJson(Map<String, dynamic> json) =>
      Room(name: json["name"], id: json["id"], props: json["props"]);
}
