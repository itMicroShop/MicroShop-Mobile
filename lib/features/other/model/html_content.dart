import 'dart:convert';

class HtmlContent {
  final String title;
  final String content;
  HtmlContent({
    required this.title,
    required this.content,
  });

  HtmlContent copyWith({
    String? title,
    String? content,
  }) {
    return HtmlContent(
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
    };
  }

  factory HtmlContent.fromMap(Map<String, dynamic> map) {
    return HtmlContent(
      title: map['title'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HtmlContent.fromJson(String source) =>
      HtmlContent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HtmlContent(title: $title, content: $content)';

  @override
  bool operator ==(covariant HtmlContent other) {
    if (identical(this, other)) return true;

    return other.title == title && other.content == content;
  }

  @override
  int get hashCode => title.hashCode ^ content.hashCode;
}
