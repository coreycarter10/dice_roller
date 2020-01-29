import 'package:dice_roller/models/dice_expression.dart';
import 'package:meta/meta.dart' show required;

class RollResult {
  final DiceExpression exp;
  final List<int> rolls;
  final int total;

  const RollResult({@required this.exp, @required this.rolls, @required this.total});

  @override
  String toString() => "($exp) $rolls : $total";
}