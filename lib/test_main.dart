void main() {
  List<int> numbers = [1, 2, 3, 4, 5];

  int divideByZero() {
    return 10 ~/ 0;
  }

  String? nullString;
  
  print(nullString!.length);

  print(numbers[10]);

  print(divideByZero());
}
