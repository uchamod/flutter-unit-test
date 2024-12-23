import 'package:flutter_test/flutter_test.dart';
import 'package:unit_test/counter/counter.dart';

void main() {
  late Counter counter;
  //set up function
  //run before each test
  setUp(() {
    counter = Counter();
  });
  //run after each test

  tearDown(() {
    counter = Counter();
  });
  test("initial counter value should be zero", () {
    expect(counter.value, 0);
  });

  test("the value should be incremant by 1", () {
    counter.increment();
    expect(counter.value, 1);
  });
  test("the value should be decrement by 1", () {
    counter.decrement();
    expect(counter.value, -1);
  });
}
