import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeTabControllerProvider = Provider<PageController>((ref) {
  return PageController();
});