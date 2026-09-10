import 'package:flutter/foundation.dart';
import '../models/book.dart';
import '../models/reading_goal.dart';
import '../data/mock_books_data.dart';

class LibraryProvider extends ChangeNotifier {
  final List<Book> _books = List.from(mockBooksCatalog);
  final ReadingGoal _goal = ReadingGoal();
  String _selectedGenreFilter = 'All';
  String _searchQuery = '';

  List<Book> get allBooks => _books;
  ReadingGoal get goal => _goal;
  String get selectedGenreFilter => _selectedGenreFilter;
  String get searchQuery => _searchQuery;

  // Shelf Getters
  List<Book> get currentlyReading =>
      _books.where((b) => b.shelfStatus == ShelfStatus.currentlyReading).toList();

  List<Book> get wantToRead =>
      _books.where((b) => b.shelfStatus == ShelfStatus.wantToRead).toList();

  List<Book> get completed =>
      _books.where((b) => b.shelfStatus == ShelfStatus.completed).toList();

  List<Book> get wishlist =>
      _books.where((b) => b.shelfStatus == ShelfStatus.wishlist).toList();

  List<Book> get favorites => _books.where((b) => b.isFavorite).toList();

  Book? get priorityBook {
    final reading = currentlyReading;
    if (reading.isNotEmpty) {
      // Return most recently read book
      reading.sort((a, b) {
        final aTime = a.lastReadAt ?? DateTime(2000);
        final bTime = b.lastReadAt ?? DateTime(2000);
        return bTime.compareTo(aTime);
      });
      return reading.first;
    }
    return _books.isNotEmpty ? _books.first : null;
  }

  // Genre Filters
  List<String> get availableGenres {
    final genres = {'All'};
    for (var b in _books) {
      genres.add(b.genre);
    }
    return genres.toList();
  }

  List<Book> get filteredBooks {
    return _books.where((b) {
      final matchesGenre =
          _selectedGenreFilter == 'All' || b.genre == _selectedGenreFilter;
      final matchesQuery = _searchQuery.isEmpty ||
          b.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          b.author.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          b.tags.any((t) => t.toLowerCase().contains(_searchQuery.toLowerCase())) ||
          b.isbn.contains(_searchQuery);
      return matchesGenre && matchesQuery;
    }).toList();
  }

  void setGenreFilter(String genre) {
    _selectedGenreFilter = genre;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void toggleFavorite(String bookId) {
    final index = _books.indexWhere((b) => b.id == bookId);
    if (index != -1) {
      _books[index].isFavorite = !_books[index].isFavorite;
      notifyListeners();
    }
  }

  void updateShelfStatus(String bookId, ShelfStatus newStatus) {
    final index = _books.indexWhere((b) => b.id == bookId);
    if (index != -1) {
      _books[index].shelfStatus = newStatus;
      if (newStatus == ShelfStatus.completed) {
        _books[index].currentPage = _books[index].totalPages;
        _goal.booksCompletedThisYear += 1;
      }
      notifyListeners();
    }
  }

  void updateReadingProgress(String bookId, int newPage) {
    final index = _books.indexWhere((b) => b.id == bookId);
    if (index != -1) {
      _books[index].currentPage = newPage.clamp(0, _books[index].totalPages);
      _books[index].lastReadAt = DateTime.now();
      if (_books[index].currentPage >= _books[index].totalPages) {
        _books[index].shelfStatus = ShelfStatus.completed;
      } else {
        _books[index].shelfStatus = ShelfStatus.currentlyReading;
      }
      notifyListeners();
    }
  }

  void addMinutesReadToday(int minutes) {
    _goal.minutesReadToday += minutes;
    notifyListeners();
  }

  void addBookToNest(Book newBook) {
    if (!_books.any((b) => b.id == newBook.id)) {
      _books.insert(0, newBook);
      notifyListeners();
    }
  }

  Book? getBookById(String id) {
    try {
      return _books.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }
}
