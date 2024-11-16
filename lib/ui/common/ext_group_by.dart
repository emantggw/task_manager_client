extension ExtIterable<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
  E? findOne<K>(bool Function(E) keyFunction) {
    List<E> res = where((element) => keyFunction(element)).toList();
    if (res.isEmpty) {
      return null;
    } else {
      return res.first;
    }
  }

  K sum<K>(K Function(E) keyFunction) {
    dynamic total = 0.0;
    for (E element in this) {
      total += keyFunction(element);
    }
    return total;
  }

  double average<K>(K Function(E) keyFunction) {
    dynamic total = 0.0;
    for (E element in this) {
      total += keyFunction(element);
    }
    return total / length;
  }
}
