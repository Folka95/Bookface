enum Sender {
  me,
  friend,
}

class Message {
  final Sender sender;
  final String content;
  final DateTime time;

  Message({
    required this.sender,
    required this.content,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'sender': sender.name,
      'content': content,
      'time': time.toIso8601String(),
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sender: Sender.values.firstWhere(
            (value) => value.name == json['sender'],
      ),
      content: json['content'] as String,
      time: DateTime.parse(json['time'] as String),
    );
  }
}
