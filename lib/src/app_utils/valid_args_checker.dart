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

import 'package:meta/meta.dart' show nonVirtual;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Provides a mechanism to check if command line args are valid or not.
abstract class ValidArgsChecker {
  //
  //
  //

  const ValidArgsChecker();

  //
  //
  //

  /// The list of arguments to consider for validation.
  List<dynamic> get args;

  //
  //
  //

  /// Returns true if every element in [args] is neither `null` nor empty.
  /// If an argument does not have an `isEmpty` method, it is assumed to be not
  /// empty.
  @nonVirtual
  bool get isValid {
    for (final arg in args) {
      if (arg == null) {
        return false;
      }
      try {
        // Check if the argument is empty; if it is, return false. Otherwise, if
        // isEmpty is not a valid method, continue.
        if (arg.isEmpty == true) {
          return false;
        }
      } catch (_) {
        continue;
      }
    }
    return true;
  }
}
