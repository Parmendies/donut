void main(List<String> args) {
  double i = 100000;
  for (var a = 0; a < 25; a++) {
    if (a.isEven) {
      i += (i / 100 * 2.99);
    }
  }
  print(i);
}
