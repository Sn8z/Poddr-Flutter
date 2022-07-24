import 'package:flutter_riverpod/flutter_riverpod.dart';

final userAPI = FutureProvider((ref) async {
  await Future.delayed(const Duration(seconds: 5));
  return "Weeehoooo";
});
