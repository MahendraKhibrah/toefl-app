extension ListExt<T> on List<T> {
  T? getOrNull(int index) => index < 0 || index >= length ? null : this[index];

  T? getFirstOrNull() => getOrNull(0);

  T? getLastOrNull() => getOrNull(length - 1);

  T? firstWhereOrNull(bool Function(T) test) {
    try {
      return firstWhere(test);
    } catch (_) {
      return null;
    }
  }

  T? removeLastWhere(bool Function(T) condition) {
    try {
      if (isEmpty) {
        return null;
      }

      for (int i = length - 1; i >= 0; i--) {
        if (condition(this[i])) {
          final result = this[i];
          removeAt(i);
          return result;
        }
      }

      return null;
    } on Exception {
      return null;
    }
  }
}
