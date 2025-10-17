class FcmPayload {
  String? body;
  String? title;
  String? priority;

  FcmPayload({
    this.body,
    this.title,
    this.priority,
  });

  FcmPayload.fromJsonMap(Map<String, dynamic> map) {
    body = map["body"];
    title = map["title"];
    priority = map["priority"];
  }

  Map<String, dynamic> toJson() => {
        "body": body,
        "title": title,
        "priority": priority,
      };
}