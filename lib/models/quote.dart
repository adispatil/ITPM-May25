class Quote {
  final String id;
  final String text;
  final String date;

  Quote({
    required this.id,
    required this.text,
    required this.date,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'] ?? '',
      text: json['text'] ?? '',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'date': date,
    };
  }
}

class QuoteResponse {
  final bool success;
  final String message;
  final Quote data;

  QuoteResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory QuoteResponse.fromJson(Map<String, dynamic> json) {
    return QuoteResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: Quote.fromJson(json['data'] ?? {}),
    );
  }
} 