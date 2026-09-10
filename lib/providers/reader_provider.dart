import 'package:flutter/foundation.dart';
import '../models/book.dart';
import '../models/reader_settings.dart';

class ReaderProvider extends ChangeNotifier {
  ReaderSettings _settings = ReaderSettings();
  int _currentChapterIndex = 0;
  final List<BookHighlight> _sessionHighlights = [];

  ReaderSettings get settings => _settings;
  int get currentChapterIndex => _currentChapterIndex;
  List<BookHighlight> get sessionHighlights => _sessionHighlights;

  void updateSettings(ReaderSettings newSettings) {
    _settings = newSettings;
    notifyListeners();
  }

  void setThemeMode(ReaderThemeMode mode) {
    _settings = _settings.copyWith(themeMode: mode);
    notifyListeners();
  }

  void setFontSize(double size) {
    _settings = _settings.copyWith(fontSize: size);
    notifyListeners();
  }

  void setLineHeight(double height) {
    _settings = _settings.copyWith(lineHeight: height);
    notifyListeners();
  }

  void setFontFamily(ReaderFontFamily family) {
    _settings = _settings.copyWith(fontFamily: family);
    notifyListeners();
  }

  void setChapterIndex(int index) {
    _currentChapterIndex = index;
    notifyListeners();
  }

  void toggleChapterBookmark(Book book, int chapterNum) {
    if (book.bookmarkedChapters.contains(chapterNum)) {
      book.bookmarkedChapters.remove(chapterNum);
    } else {
      book.bookmarkedChapters.add(chapterNum);
    }
    notifyListeners();
  }

  void addHighlight(Book book, String text, int chapterNum, {String? note}) {
    final highlight = BookHighlight(
      id: 'hl-${DateTime.now().millisecondsSinceEpoch}',
      bookId: book.id,
      chapterNumber: chapterNum,
      text: text,
      note: note,
      createdAt: DateTime.now(),
    );
    book.highlights.add(highlight);
    _sessionHighlights.add(highlight);
    notifyListeners();
  }
}
