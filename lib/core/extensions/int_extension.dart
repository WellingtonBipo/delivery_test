extension IntExtension on int {
  List<T> generate<T>(T Function(int index) generator) {
    return List<T>.generate(this, generator);
  }
}
