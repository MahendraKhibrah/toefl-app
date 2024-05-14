class Utils {
  Utils._();

  static String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  static String listToStringWithAt(List<String> list) {
    return list.join('@');
  }

  static List<String> stringToListWithAt(String input) {
    return input.split('@');
  }

  static Map<String, dynamic> stringToJson(String jsonString) {
    String cleanedString = jsonString.replaceAll('{', '').replaceAll('}', '');

    List<String> keyValuePairs = cleanedString.split(', ');

    Map<String, dynamic> jsonObject = {};

    for (String pair in keyValuePairs) {
      List<String> keyValue = pair.split(': ');
      jsonObject[keyValue[0]] = keyValue[1];
    }

    return jsonObject;
  }
}
