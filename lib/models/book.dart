enum BookFormat { ebook, audiobook, hardcover }

enum ShelfStatus { currentlyReading, wantToRead, completed, wishlist }

class Review {
  final String id;
  final String reviewerName;
  final String? reviewerAvatar;
  final double rating;
  final String date;
  final String comment;
  final int likesCount;

  Review({
    required this.id,
    required this.reviewerName,
    this.reviewerAvatar,
    required this.rating,
    required this.date,
    required this.comment,
    this.likesCount = 0,
  });
}

class Chapter {
  final int number;
  final String title;
  final String content;
  final int estimatedMinutes;

  Chapter({
    required this.number,
    required this.title,
    required this.content,
    required this.estimatedMinutes,
  });
}

class BookHighlight {
  final String id;
  final String bookId;
  final int chapterNumber;
  final String text;
  final String? note;
  final DateTime createdAt;

  BookHighlight({
    required this.id,
    required this.bookId,
    required this.chapterNumber,
    required this.text,
    this.note,
    required this.createdAt,
  });
}

class Book {
  final String id;
  final String title;
  final String author;
  final String authorBio;
  final String coverUrl;
  final double rating;
  final int reviewCount;
  final int totalPages;
  int currentPage;
  final String genre;
  final List<String> tags;
  final String synopsis;
  final String? keyQuote;
  final String publishedYear;
  final String isbn;
  final List<BookFormat> availableFormats;
  ShelfStatus shelfStatus;
  bool isFavorite;
  final List<Chapter> chapters;
  final List<Review> reviews;
  List<int> bookmarkedChapters;
  List<BookHighlight> highlights;
  DateTime? lastReadAt;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.authorBio,
    required this.coverUrl,
    required this.rating,
    required this.reviewCount,
    required this.totalPages,
    this.currentPage = 0,
    required this.genre,
    required this.tags,
    required this.synopsis,
    this.keyQuote,
    required this.publishedYear,
    required this.isbn,
    this.availableFormats = const [BookFormat.ebook, BookFormat.audiobook],
    this.shelfStatus = ShelfStatus.wantToRead,
    this.isFavorite = false,
    this.chapters = const [],
    this.reviews = const [],
    List<int>? bookmarkedChapters,
    List<BookHighlight>? highlights,
    this.lastReadAt,
  })  : bookmarkedChapters = bookmarkedChapters ?? [],
        highlights = highlights ?? [];

  double get progressPercentage {
    if (totalPages == 0) return 0.0;
    return (currentPage / totalPages).clamp(0.0, 1.0);
  }

  int get estimatedRemainingMinutes {
    final remainingPages = (totalPages - currentPage).clamp(0, totalPages);
    // standard reading speed ~ 1.8 mins per page
    return (remainingPages * 1.8).round();
  }
}
