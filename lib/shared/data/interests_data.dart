class InterestItem {
  final String value;

  const InterestItem._(this.value);

  String toJson() {
    return value;
  }

  factory InterestItem.fromJson(String json) {
    return InterestItem._(json);
  }
}
class Interests {
  static const gaming = InterestItem._("Gaming");
  static const personal = InterestItem._("Personal");
  static const food = InterestItem._("Food");
  static const programming = InterestItem._("Programming");

  static List<String> getAllStrings() {
    return getAllItems()
        .map((item) => item.value)
        .toList();
  }

  static List<InterestItem> getAllItems() {
    return [
      gaming,
      personal,
      food,
      programming,
    ];
  }
}