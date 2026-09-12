enum PublicationStatus { published, draft, archived }

enum ModerationStatus { pending, approved, flagged, rejected }

enum UserRole { admin, curator, reader }

enum UserAccountStatus { active, suspended }

class ModerationReview {
  final String id;
  final String bookId;
  final String bookTitle;
  final String reviewerName;
  final String reviewerEmail;
  final double rating;
  final String comment;
  final String submittedDate;
  ModerationStatus status;
  final String? flagReason;

  ModerationReview({
    required this.id,
    required this.bookId,
    required this.bookTitle,
    required this.reviewerName,
    required this.reviewerEmail,
    required this.rating,
    required this.comment,
    required this.submittedDate,
    this.status = ModerationStatus.pending,
    this.flagReason,
  });
}

class AdminUserRecord {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  UserRole role;
  final String joinedDate;
  final int booksRead;
  final int reviewsCount;
  UserAccountStatus status;

  AdminUserRecord({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.role,
    required this.joinedDate,
    required this.booksRead,
    required this.reviewsCount,
    this.status = UserAccountStatus.active,
  });
}

class AdminActivityLog {
  final String id;
  final String title;
  final String description;
  final String timestamp;
  final String iconType;

  AdminActivityLog({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.iconType,
  });
}
