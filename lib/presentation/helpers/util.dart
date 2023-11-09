import 'dart:math';

class Util {
  static String randomChar(String string) {
    String aux = '';
    string = string.trim();

    do {
      aux = string[Random().nextInt(string.length)];
      aux = aux.trim();
    } while(aux.isEmpty);

    return aux.toUpperCase();
  }

  static int randomColor() {
    return Random().nextInt(0xffffffff);
  }
}
