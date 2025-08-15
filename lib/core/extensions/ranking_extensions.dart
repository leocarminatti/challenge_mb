import 'package:flutter/material.dart';

extension RankingExtensions on int {
  Color getRankColor(ThemeData theme) {
    switch (this) {
      case 1:
        return const Color(0xFFFFD700);
      case 2:
        return const Color(0xFFC0C0C0);
      case 3:
        return const Color(0xFFCD7F32);
      default:
        return theme.colorScheme.onSurface;
    }
  }

  String getRankText() => '#$this';
}
