import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_calculator/calculation.dart';
import 'package:multiple_calculator/item.dart';

final itemModelProvider = ChangeNotifierProvider((ref) => ItemModel());

// テキストフィールドの状態を管理する
class ItemModel extends ChangeNotifier {
  List<String> cSymbols = ["+", "-", "x", "÷"];

  // ここにitemクラスが追加(削除)される
  List<Item> items = [
    Item.create(""), // 起動時に作成するため
  ];

  // TextEditingControllerを持っているので, 不要になったらdiposeする必要がある
  // dispose() クラスが不要になったときに呼び出すことで不要なリソースが解放される
  @override
  void dispose() {
    items.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  // itemクラスを作成する
  void addItem() {
    items.add(Item.create(""));
    notifyListeners();
  }

  // テキストフィールドに入力された文字を反映させる
  void changeItem(int id, String text) {
    items.map((item) => item.id == id ? item.change() : item,).toList();
    if (text == "-") {
      // テキストフィールドの1番目の文字に"-"が入った場合、取り消す
      items.map((item) => item.id == id ? item.controller.text = "" : item,).toList();
    } else if (text.length > 1) {
      // 四則記号が2連続で入力された場合、取り消す
      String laststr = text.substring(text.length -1);
      String laststr2 = text.substring(text.length -2, text.length -1);
      if (laststr == "-" && cSymbols.contains(laststr2)) {
        items.map((item) => item.id == id ? item.controller.text = text.substring(0, text.length -1) : item,).toList();
      }
    }
    notifyListeners();
  }

  // itemクラスを削除する
  void removeItem(int id) {
    final removeItem = items.firstWhere((element) => element.id == id);
    items.removeWhere((element) => element.id == id);
    // 時間を遅らせないとエラーになるため
    Future.delayed(const Duration(seconds: 1)).then((value) => removeItem.dispose());
    notifyListeners();
  }

  // 四則記号のキーボードアクションをテキストフィールドに反映させる
  void addSymbol(int id, String symbol) {
    final item = items.firstWhere((element) => element.id == id);
    // テキストフィールドの1番目の文字に四則演算を追加しない
    if (item.controller.text != "") {
      // 四則演算が2連続で追加される場合、追加しない
      var laststr = item.controller.text.substring(item.controller.text.length - 1);
      if (!cSymbols.contains(laststr)) {
        item.controller.text += symbol;
        notifyListeners();
      }
    }
  }

  // 計算結果をテキストフィールドに反映させる
  void answer(int id) {
    final item = items.firstWhere((element) => element.id == id);
    item.controller.text = Calculation().calculate(item.controller.text);
    notifyListeners();
  }
}
