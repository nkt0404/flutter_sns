// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:flutter_sns/constants/strings.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Text(searchText);
  }
}
