

import 'dart:collection';
import 'dart:math';

class KeyGenerator {
  int _nextKey = 0;

  int get nextKey => _nextKey++;
}

void addItems({Map<int, int> map, int number, KeyGenerator keyGenerator}) {
  for (var i = 0; i < number; ++i) {
    map.putIfAbsent(keyGenerator.nextKey, () => i);
  }
}

Duration timeFunction(void Function() function) {
  final start = DateTime.now();
  function();
  return DateTime.now().difference(start);
}

void main(List<String> arguments) {
  final i = 24;
  for (var j = 0; j < 10; j++) {
    final map = LinkedHashMap<int, int>(hashCode: (i) => i);

    final count = pow(2, i);
    var time = timeFunction(() =>
        addItems(map: map, number: count, keyGenerator: KeyGenerator()));
    print('$i, $count, ${time}');
  }
  print('---------');
  for (var j = 0; j < 10; j++) {
    final map = LinkedHashMap<int, int>();

    final count = pow(2, i);
    var time = timeFunction(() =>
        addItems(map: map, number: count, keyGenerator: KeyGenerator()));
    print('$i, $count, ${time}');
  }
}
