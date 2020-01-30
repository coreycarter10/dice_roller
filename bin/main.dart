import 'dart:math' show Random;

import 'package:console/console.dart' show Console;

import 'package:dice_roller/utils/console_utils.dart';
import 'package:dice_roller/utils//utils.dart';
import 'package:dice_roller/models/dice_expression.dart';
import 'package:dice_roller/models/roll_result.dart';

final random = Random();

void main() {
  Console.init();

  Console.setTextColor(ConsoleColor.blue.index);
  Console.write("\n***********");
  Console.write("\nDICE ROLLER");
  Console.write("\n***********");

  while (true) {
    final input = promptForString("\nEnter a dice formula (e.g. 2d6):  ");

    if (input == null) {
      break;
    }

    final DiceExpression exp = parseFormula3(input);

    printRollResult(rollDice(exp));
  }
}

int rollDie(int sides) => random.nextInt(sides) + 1;

RollResult rollDice(DiceExpression exp) {
  final List<int> rolls = [];

  for (int i = 0; i < exp.qty; i++) {
    rolls.add(rollDie(exp.sides));
  }

  final total = sum(rolls);

  return RollResult(
    exp: exp,
    rolls: rolls,
    total: total,
  );
}

/// This version parses the formula using substrings and explicit steps
DiceExpression parseFormula1(String formula) {
  // sanitize the formula(eliminate spaces and case sensitivity
  formula = formula.replaceAll(' ', '').toLowerCase();

  // locate the D
  final indexOfD = formula.indexOf('d');

  // extract qty
  final qtyStr = formula.substring(0, indexOfD);

  // convert qty to int
  final qty = int.tryParse(qtyStr);

  // extract sides
  final sidesStr = formula.substring(indexOfD + 1);

  // convert sides to int
  final sides = int.tryParse(sidesStr);

  final exp = DiceExpression(qty: qty, sides: sides);

  return exp;
}

/// This version parses the formula using substrings succinctly
DiceExpression parseFormula2(String formula) {
  formula = formula.replaceAll(' ', '').toLowerCase();

  final indexOfD = formula.indexOf('d');

  return DiceExpression(
    qty: int.tryParse(formula.substring(0, indexOfD)),
    sides: int.tryParse(formula.substring(indexOfD + 1)),
  );
}

/// This version parses the formula by splitting into a list
DiceExpression parseFormula3(String formula) {
  formula = formula.replaceAll(' ', '').toLowerCase();

  // split the formula into its parts
  final List<String> parts = formula.split('d');

  return DiceExpression(
    qty: int.tryParse(parts.first),
    sides: int.tryParse(parts.last),
  );
}

void printRollResult(RollResult result) {
  consoleNewLine();

  // print formula
  Console.setTextColor(ConsoleColor.cyan.index);
  Console.write(result.exp.toString());

  printArrow();

  // print rolls
  Console.setTextColor(ConsoleColor.magenta.index);
  Console.write(result.rolls.toString());

  printArrow();

  // print total
  Console.setTextColor(ConsoleColor.yellow.index);
  Console.write(result.total.toString());
}

void printArrow() {
  Console.setTextColor(ConsoleColor.white.index);
  Console.write(" -> ");
}