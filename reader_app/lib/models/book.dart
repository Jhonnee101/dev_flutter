import 'dart:typed_data';

class Book {
  final String id;
  final String title;
  final String? author;
  final String? publisher;
  final DateTime? publicationDate;
  final String filePath;
  final double progress;
  final Uint8List? coverImage;
  final String? language;
  final List<String>? subjects;
  final String? description;

  Book({
    required this.id,
    required this.title,
    this.author,
    this.publisher,
    this.publicationDate,
    required this.filePath,
    this.progress = 0.0,
    this.coverImage,
    this.language,
    this.subjects,
    this.description,
  });

  // Método para criar um Book a partir de um mapa (útil para persistência)
  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as String,
      title: map['title'] as String,
      author: map['author'] as String?,
      publisher: map['publisher'] as String?,
      publicationDate: map['publicationDate'] != null
          ? DateTime.parse(map['publicationDate'] as String)
          : null,
      filePath: map['filePath'] as String,
      progress: (map['progress'] as num?)?.toDouble() ?? 0.0,
      coverImage: map['coverImage'] as Uint8List?,
      language: map['language'] as String?,
      subjects: map['subjects'] != null
          ? List<String>.from(map['subjects'] as List)
          : null,
      description: map['description'] as String?,
    );
  }

  // Método para converter um Book em mapa (útil para persistência)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'publisher': publisher,
      'publicationDate': publicationDate?.toIso8601String(),
      'filePath': filePath,
      'progress': progress,
      'coverImage': coverImage,
      'language': language,
      'subjects': subjects,
      'description': description,
    };
  }

  // Cópia do livro com possibilidade de alterar alguns campos
  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? publisher,
    DateTime? publicationDate,
    String? filePath,
    double? progress,
    Uint8List? coverImage,
    String? language,
    List<String>? subjects,
    String? description,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      publisher: publisher ?? this.publisher,
      publicationDate: publicationDate ?? this.publicationDate,
      filePath: filePath ?? this.filePath,
      progress: progress ?? this.progress,
      coverImage: coverImage ?? this.coverImage,
      language: language ?? this.language,
      subjects: subjects ?? this.subjects,
      description: description ?? this.description,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Book &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Book{title: $title, author: $author, progress: $progress}';
  }
}