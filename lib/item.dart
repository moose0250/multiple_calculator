import 'dart:math';
import 'package:flutter/material.dart';

// 表示用のテキストフィールド
class Item {
  Item({
    required this.id,
    required this.controller,
    required this.focusNode,
  });
  int id;
  TextEditingController controller;
  FocusNode focusNode;

  factory Item.create(String text) {
    return Item(
      id: Random().nextInt(99999),
      controller: TextEditingController(text: text),
      focusNode: FocusNode(),
    );
  }

  Item change() {
    return Item(
      id: id,
      controller: controller,
      focusNode: focusNode,
    );
  }

  void dispose() {
    controller.dispose();
  }
}