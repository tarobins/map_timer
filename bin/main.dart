

import 'dart:math';

class KeyGenerator {
  int _nextKey = 0;

  int get nextKey => _nextKey++ << 40;
}

void addItems({Map<int, int> map, int number, KeyGenerator keyGenerator}) {
  for (var i = 0; i < number; ++i) {
    map.putIfAbsent(keyGenerator.nextKey, () => i);
  }
}

Duration timeEvent(void Function() predicate) {
  final start = DateTime.now();
  predicate();
  return DateTime.now().difference(start);
}

void main(List<String> arguments) {
  final mapi = <int, int>{};

  var time = timeEvent(() =>
      addItems(map: mapi, number: 1, keyGenerator: KeyGenerator()));
  for (var i = 0; i < 19; i++) {
    final map = <int, int>{};

    final count = pow(2, i);
    var time = timeEvent(() =>
        addItems(map: map, number: count, keyGenerator: KeyGenerator()));
    print('$i, $count, ${time.inMicroseconds}');
  }
}
