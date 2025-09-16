class QuoteModel {
  final String quote;
  final String? author;

  const QuoteModel({required this.quote, this.author});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'quote': quote, 'author': author};
  }

  factory QuoteModel.fromMap(Map<String, dynamic> map) {
    return QuoteModel(
      // The API uses 'text' for the quote content.
      quote: map['quote'] as String,
      // The author can be null, so we handle that.
      author: map['author'] as String?,
    );
  }

  @override
  String toString() => 'QuoteModel(quote: $quote, author: $author)';

  @override
  bool operator ==(covariant QuoteModel other) {
    if (identical(this, other)) return true;

    return other.quote == quote && other.author == author;
  }

  @override
  int get hashCode => quote.hashCode ^ author.hashCode;
}
