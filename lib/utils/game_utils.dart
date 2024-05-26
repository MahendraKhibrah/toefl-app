class GameUtils {
  List<String> splitStringWithoutCaps(String input, String keyword) {
    List<String> substrings = [];

    RegExp regExp =
        RegExp('\\b' + RegExp.escape(keyword) + '\\b', caseSensitive: false);

    Iterable<Match> matches = regExp.allMatches(input);

    int previousEnd = 0;
    for (Match match in matches) {
      substrings.add(input.substring(previousEnd, match.start));
      previousEnd = match.end;
    }

    substrings.add(input.substring(previousEnd));

    return substrings;
  }

  String joinSubstrings(List<String> substrings, int len) {
    return substrings.join('_' * len);
  }
}
