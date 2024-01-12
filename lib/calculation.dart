import 'package:math_expressions/math_expressions.dart';

// 計算
class Calculation {
  List<String> cSymbols = ["+", "-", "x", "÷"];

  String calculate(String text) {
    if (text == "") {
      return "";
    }
    var laststr = text.substring(text.length - 1);
    if (cSymbols.contains(laststr)) {
      text = text.substring(0, text.length - 1);
    }
    text = text.replaceAll("x", "*");
    text = text.replaceAll("÷", "/");
    
    String ansText;
    Parser p = Parser();
    Expression exp = p.parse(text);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    ansText = eval.toString();

    var ansList = ansText.split('.');
    if (ansList[1] == '0') {
      ansText = ansList[0];
    }

    return ansText;
  }
}