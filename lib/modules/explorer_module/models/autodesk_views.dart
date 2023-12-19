class AutodeskView {
  String name;
  String guid;

  AutodeskView({
    required this.name, //to get the asset path, switch the blank spaces for under slashes "_"
    required this.guid,
  });

  factory AutodeskView.fromJson(Map<String, dynamic> json) =>
      AutodeskView(name: json["name"], guid: json["guid"]);

  Map<String, dynamic> toJson() {
    return {"name": name, "guid": guid};
  }
}
