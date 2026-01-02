/// Model representing a segment of text (for future advanced analysis)
/// Currently not used – kept for scalability (e.g., local grammar highlighting)
class TextSegment {
  final String text;
  final bool hasIssue;
  final String issueType;

  const TextSegment({
    required this.text,
    this.hasIssue = false,
    this.issueType = '',
  });
}
