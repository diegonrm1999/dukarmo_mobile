import 'package:dukarmo_app/core/utils/debouncer.dart';
import 'package:dukarmo_app/domain/user.dart';
import 'package:flutter/material.dart';

class SearchModalController extends ChangeNotifier {
  final textController = TextEditingController();

  final Debouncer _debouncer = Debouncer(
    delay: const Duration(milliseconds: 300),
  );

  List<User> allStylists;
  List<User> stylistItems = [];

  SearchModalController({required this.allStylists}) {
    _onInit();
  }

  Future<void> _onInit() async {
    stylistItems = allStylists;
    notifyListeners();
  }

  void onSearchChanged(String query) {
    _debouncer.run(() {
      final trimmed = query.trim().toLowerCase();
      if (trimmed.isEmpty) {
        stylistItems = allStylists;
      } else {
        stylistItems = allStylists.where((user) {
          final fullName = '${user.firstName} ${user.lastName}'.toLowerCase();
          final reversedFullName = '${user.lastName} ${user.firstName}'
              .toLowerCase();
          return fullName.contains(trimmed) ||
              reversedFullName.contains(trimmed);
        }).toList();
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _debouncer.cancel();
    textController.dispose();
    super.dispose();
  }
}
