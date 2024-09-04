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

import 'package:equatable/equatable.dart';

import 'paths.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A mechanism to combine root and subdirectory paths to form combined
/// directory paths that adhere to specific path patterns.
class CombinedPaths extends Equatable {
  //
  //
  //

  final Set<String> paths;

  //
  //
  //

  /// Patterns for filtering paths of interest.
  final Set<String> pathPatterns;

  //
  //
  //

  CombinedPaths(
    Set<String> rootPaths, {
    Set<String> subPaths = const {},
    this.pathPatterns = const {},
  }) : paths = _combine([rootPaths, subPaths], pathPatterns);

  //
  //
  //

  static Set<String> _combine(
    List<Set<String>> pathSets,
    Set<String> pathPatterns,
  ) {
    return combinePathSets(pathSets).where((e) {
      return matchesAnyPathPattern(e, pathPatterns);
    }).toSet();
  }

  //
  //
  //

  @override
  List<Object?> get props => this.paths.toList();
}
