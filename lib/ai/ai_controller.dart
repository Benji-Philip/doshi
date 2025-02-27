import 'dart:convert';

import 'package:doshi/ai/chatgpt.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AiController {
  Future<String> getAiJson(String userInput, WidgetRef ref) async {
    List<String> categories = ref.read(categoryDatabaseProvider.notifier).currentCategories.map((e) => e.category).toList();
    List<String> subcategories = ref.read(subCategoryDatabaseProvider.notifier).currentSubCategories.map((e) => '${e.parentCategory},${e.subCategory}').toList();
    String prompt =
        'You are part of an expense tracker app. User input : "$userInput". Without any explanation, give a json containing "expense" a bool, "date" a DateTime, "category" a string from the list:${categories.toString()}, "amount" a double rounded to 2 decimal places, "savings" a bool, "note" a string and "subcategory" a string from the list(parentCategory, subcategory):${subcategories.toString()} where parentCategory == "category".';
    String response = await ChatGptApi().promptChatGptText(prompt, ref);
    if (!_isValidJson(response)) {
      response = jsonEncode({"error": response});
    }
    return response;
  }

  bool _isValidJson(String str) {
    try {
      jsonDecode(str);
    } catch (e) {
      return false;
    }
    return true;
  }
}
