class ReadingGoal {
  final int dailyTargetMinutes;
  int minutesReadToday;
  final int currentStreakDays;
  final int yearlyBookTarget;
  int booksCompletedThisYear;
  final List<int> weeklyMinutesHistory; // Last 7 days [Mon, Tue, ...]

  ReadingGoal({
    this.dailyTargetMinutes = 45,
    this.minutesReadToday = 32,
    this.currentStreakDays = 14,
    this.yearlyBookTarget = 25,
    this.booksCompletedThisYear = 9,
    List<int>? weeklyMinutesHistory,
  }) : weeklyMinutesHistory = weeklyMinutesHistory ?? [35, 45, 50, 40, 60, 45, 32];

  double get dailyProgressPercentage {
    if (dailyTargetMinutes == 0) return 0.0;
    return (minutesReadToday / dailyTargetMinutes).clamp(0.0, 1.0);
  }

  double get yearlyProgressPercentage {
    if (yearlyBookTarget == 0) return 0.0;
    return (booksCompletedThisYear / yearlyBookTarget).clamp(0.0, 1.0);
  }
}
