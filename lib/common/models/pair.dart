///通用数据键值对类
class Pair<F, S> {
  F first;
  S second;

  Pair(this.first, this.second);

  @override
  String toString() {
    return '{$first:$second}';
  }

  static List<Pair<String, String>> fromStringList(List<String> stringList) {
    return stringList.map((e) => fromString(e)).toList();
  }

  static Pair<String, String> fromString(String res) {
    var resList = res.replaceAll('{', '').replaceAll('}', '').split(':');
    return Pair(resList[0].trim(), resList[1].trim());
  }

  bool operator ==(Object other) {
    if (other is Pair) {
      if (other.first == first && other.second == second) {
        return true;
      }
    }
    return false;
  }
}

class TPair<F, S, TT> {
  F first;
  S second;
  TT third;

  TPair(this.first, this.second, this.third);

  @override
  String toString() {
    // TODO: implement toString
    return '{$first:$second:$third}';
  }
}
