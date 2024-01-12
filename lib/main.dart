import 'package:multiple_calculator/item.dart';
import 'package:multiple_calculator/item_model.dart';
import 'package:multiple_calculator/textfielditem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '複数入力計算機'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ItemModel itemModel = ref.watch(itemModelProvider);
    List<Item> items = itemModel.items;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: KeyboardActions(
        config: buildConfig(context, ref, items),
        child: Container(
          padding: const EdgeInsets.all(32),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              // テキストフィールドを展開する
              ...items.map((item) => TextFieldItem(item: item,)).toList(),
            ]
          ),
        ),
      ),
      // テキストフィールド追加ボタン
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          itemModel.addItem();
        },
        tooltip: '追加',
        child: const Icon(Icons.add),
      ),
    );
  }

  // キーボードの上にあるツール(キーボードアクション)
  KeyboardActionsConfig buildConfig(BuildContext context, WidgetRef ref, List<Item> items) {
    final ItemModel itemModel = ref.watch(itemModelProvider);
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey,
      nextFocus: false,
      actions: [
        // 各テキストフィールドに対してキーボードアクションを設定する
        ...items.map((item) => KeyboardActionsItem(
          focusNode: item.focusNode,
          displayDoneButton: false,
          displayArrows: false,
          displayActionBar: false,
          footerBuilder: (_) => PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  onPressed: () {
                    itemModel.addSymbol(item.id, "+");
                  },
                  child: const Text(
                    "+",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  onPressed: () {
                    itemModel.addSymbol(item.id, "-");
                  },
                  child: const Text(
                    "-",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  onPressed: () {
                    itemModel.addSymbol(item.id, "x");
                  },
                  child: const Text(
                    "x",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  onPressed: () {
                    itemModel.addSymbol(item.id, "÷");
                  },
                  child: const Text(
                    "÷",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  onPressed: () {
                    itemModel.answer(item.id);
                  },
                  child: const Text(
                    "=",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            )
          )
        )).toList(),
      ]
    );
  }
}