class GenderItem {
  final String value;
  const GenderItem._(this.value);
  String toJson() {
    return value;
  }
  factory GenderItem.fromJson(String json) {
    return GenderItem._(json);
  }
}

class Genders {
  static const male = GenderItem._("Male");
  static const female = GenderItem._("Female");
  static const preferNotToSay = GenderItem._("Prefer not to say");

  static List<String> getAllStrings() {
    return getAllItems()
        .map((item) => item.value)
        .toList();
  }

  static List<GenderItem> getAllItems() {
    return [
      male,
      female,
      preferNotToSay,
    ];
  }
}