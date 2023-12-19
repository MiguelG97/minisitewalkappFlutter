class AutodeskCategory {
  String categoryName;
  List<dynamic> items;

  AutodeskCategory({
    required this.categoryName,
    required this.items,
  });
  factory AutodeskCategory.fromJson(Map<String, dynamic> json) =>
      AutodeskCategory(
          categoryName: json["categoryName"], items: json["items"]);
}
