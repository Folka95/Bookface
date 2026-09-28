class Topic {
  final int id;
  final String topic;
  Topic({
    required this.id,
    required this.topic,
  });
}

class Topics {
    final Topic gaming = Topic(id: 0, topic: "Gaming");
    final Topic food = Topic(id: 1, topic: "Food");
    final Topic technology = Topic(id: 2, topic: "Technology");
    final Topic personal = Topic(id: 3, topic: "Personal");
}