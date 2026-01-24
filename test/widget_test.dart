import 'package:flutter_test/flutter_test.dart';

void main() async {
 test("incremet should be increase", () {
    counter count = counter();

    count.increment();
    expect(count.count, 1);
  });
}

class counter {
  int count = 0;

  void increment() {
    count++;
  }

  void decrement() {
    count--;
  }
}