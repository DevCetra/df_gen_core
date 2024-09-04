//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Dart/Flutter (DF) Packages by DevCetra.com & contributors. The use of this
// source code is governed by an MIT-style license described in the LICENSE
// file located in this project's root directory.
//
// See: https://opensource.org/license/mit
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

final class CategorizedPattern<TCategory extends Enum> {
  //
  //
  //

  final String pattern;
  final TCategory? category;

  //
  //
  //

  const CategorizedPattern({
    required this.pattern,
    this.category,
  });

  //
  //
  //

  RegExp get regExp => RegExp(this.pattern);

  //
  //
  //

  static TCategory? categorize<TCategory extends Enum>(
    String value,
    Iterable<CategorizedPattern<TCategory>> patterns,
  ) {
    for (final e in patterns) {
      final expression = RegExp(e.pattern, caseSensitive: false);
      if (expression.hasMatch(value)) {
        return e.category;
      }
    }
    return null;
  }

  //
  //
  //

  static const DEFAULT = _DefaultCategory.DEFAULT;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

enum _DefaultCategory {
  DEFAULT,
}
