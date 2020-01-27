

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
  // First one seems to take longer, so let the VM wake up.
  final map = LinkedHashMap<int, int>(hashCode: (i) => i);
  timeFunction(() =>
      addItems(map: map, number: 10, keyGenerator: KeyGenerator()));

  final i = 24;
  for (var j = 0; j < 15; j++) {
    final map = LinkedHashMap<int, int>(hashCode: (i) => i);

    final count = pow(2, i);
    var time = timeFunction(() =>
        addItems(map: map, number: count, keyGenerator: KeyGenerator()));
    print('$i, $count, ${time.inMilliseconds}');
  }
  print('---------');
  for (var j = 0; j < 15; j++) {
    final map = LinkedHashMap<int, int>();

    final count = pow(2, i);
    var time = timeFunction(() =>
        addItems(map: map, number: count, keyGenerator: KeyGenerator()));
    print('$i, $count, ${time.inMilliseconds}');
  }
}
