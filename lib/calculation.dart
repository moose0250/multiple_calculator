import 'package:math_expressions/math_expressions.dart';

// 計算
class Calculation {
  List<String> cSymbols = ["+", "-", "x", "÷"];

  String calculate(String text) {
    // 空欄の場合、空欄を返して処理を終える
    if (text == "") {
      return "";
    }
    // テキストで最後の文字が四則記号であれば、取り除く 例:1+2+ 3+4- など
    var laststr = text.substring(text.length - 1);
    if (cSymbols.contains(laststr)) {
      text = text.substring(0, text.length - 1);
    }
    // テキストの「x」「÷」を演算子に変更する
    text = text.replaceAll("x", "*");
    text = text.replaceAll("÷", "/");

    // テキストを数式として計算される (パッケージ)
    String ansText;
    Parser p = Parser();
    Expression exp = p.parse(text);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    ansText = eval.toString();

    // .0 小数を表示できないため、整数の部分のみ取得する
    var ansList = ansText.split('.');
    if (ansList[1] == '0') {
      ansText = ansList[0];
    }

    return ansText;
  }
}
