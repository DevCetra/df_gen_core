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

import 'package:df_collection/df_collection.dart';
import 'package:equatable/equatable.dart';

import 'package:path/path.dart' as p;

import '/src/path_utils/path_utils.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Generates a powerset of root and sub-paths that match the given patterns.
class MatchedPathPowerset extends Equatable {
  //
  //
  //

  final Set<String> output;

  //
  //
  //

  MatchedPathPowerset(
    Set<String> rootPaths, {
    Set<String> subPaths = const {},
    Set<String> matchPatterns = const {},
  }) : output = _value([rootPaths, subPaths], matchPatterns);

  //
  //
  //

  static Set<String> _value(
    List<Set<String>> pathSets,
    Set<String> pathMatchers,
  ) {
    return powerset(pathSets, (a, b) => p.normalize(a + b))
        .map((e) => matchesAnyPathPattern(e, pathMatchers) ? e : null)
        .whereType<String>()
        .toSet();
  }

  //
  //
  //

  @override
  List<Object?> get props => this.output.toList();
}
