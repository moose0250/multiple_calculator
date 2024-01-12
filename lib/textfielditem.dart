import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_calculator/item.dart';
import 'package:multiple_calculator/item_model.dart';

// テキストフィールド
class TextFieldItem extends ConsumerWidget {
  const TextFieldItem({
    Key? key,
    required this.item,
  }) : super(key: key);
  final Item item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ItemModel itemModel = ref.watch(itemModelProvider);
    
    return Row(
      children: [
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: item.controller,
            onChanged: (text) {
              itemModel.changeItem(item.id, text);
            },
            focusNode: item.focusNode,
            inputFormatters: [FilteringTextInputFormatter.deny(
              RegExp(r'[,.\s]')
            )],
          ),
        ),
        IconButton(
          onPressed: () {
            itemModel.removeItem(item.id);
          },
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}