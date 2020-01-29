import 'package:meta/meta.dart' show required;

class DiceExpression {
  final int qty;
  final int sides;

  const DiceExpression({@required this.qty, @required this.sides});

  @override
  String toString() => "${qty}d$sides";
}