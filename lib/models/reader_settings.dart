enum ReaderThemeMode {
  creamPaper,
  warmSepia,
  nightIndigo,
  darkAmoled,
}

enum ReaderFontFamily {
  literata,
  bricolage,
  sansSerif,
}

class ReaderSettings {
  double fontSize;
  double lineHeight;
  double horizontalMargin;
  ReaderThemeMode themeMode;
  ReaderFontFamily fontFamily;
  bool showReadingTimeEstimate;

  ReaderSettings({
    this.fontSize = 17.0,
    this.lineHeight = 1.65,
    this.horizontalMargin = 20.0,
    this.themeMode = ReaderThemeMode.creamPaper,
    this.fontFamily = ReaderFontFamily.literata,
    this.showReadingTimeEstimate = true,
  });

  ReaderSettings copyWith({
    double? fontSize,
    double? lineHeight,
    double? horizontalMargin,
    ReaderThemeMode? themeMode,
    ReaderFontFamily? fontFamily,
    bool? showReadingTimeEstimate,
  }) {
    return ReaderSettings(
      fontSize: fontSize ?? this.fontSize,
      lineHeight: lineHeight ?? this.lineHeight,
      horizontalMargin: horizontalMargin ?? this.horizontalMargin,
      themeMode: themeMode ?? this.themeMode,
      fontFamily: fontFamily ?? this.fontFamily,
      showReadingTimeEstimate:
          showReadingTimeEstimate ?? this.showReadingTimeEstimate,
    );
  }
}
