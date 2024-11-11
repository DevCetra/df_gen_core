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

import 'package:path/path.dart' as p;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Returns the base name of a given file [path].
String getBaseName(String path) {
  final localSystemFilePath = toLocalSystemPathFormat(path);
  return p.basename(localSystemFilePath);
}

/// Returns the directory path of a given file [path].
String getDirPath(String path) {
  final localSystemFilePath = toLocalSystemPathFormat(path);
  return p.dirname(localSystemFilePath);
}

/// Checks if the provided [path] contains any of the specified [components].
/// This operation is case-insensitive.
bool pathContainsComponent(String path, Set<String> components) {
  final localSystemFilePath = toLocalSystemPathFormat(path);
  final a = p.split(localSystemFilePath).map((e) => e.toLowerCase());
  for (final component in components) {
    if (a.contains(component.toLowerCase())) {
      return true;
    }
  }
  return false;
}

/// Checks if the provided [path] matches any of the specified [pathPatterns].
bool matchesAnyPathPattern(String path, Set<String> pathPatterns) {
  if (pathPatterns.isNotEmpty) {
    final localSystemFilePath = toLocalSystemPathFormat(path);
    for (final pattern in pathPatterns) {
      if (RegExp(pattern).hasMatch(localSystemFilePath)) return true;
    }
    return false;
  }
  return true;
}

/// Checks if the provided [filePath] matches any of the specified [extensions].
///
/// Notes:
///
/// - If the [extensions] set is empty, the function will return true.
/// - Specify [caseSensitive] as false to ignore case.
bool matchesAnyExtension(
  String filePath,
  Set<String> extensions, {
  bool caseSensitive = true,
}) {
  if (extensions.isEmpty) return true;
  final extension = p.extension(filePath);
  return extensions.any((e) {
    final a = caseSensitive ? extension : extension.toLowerCase();
    final b = caseSensitive ? e : e.toLowerCase();
    return a == b;
  });
}

/// Converts the given [filePath] to a consistent, local path format.
String getFileNameWithoutExtension(String filePath) {
  final localSystemFilePath = toLocalSystemPathFormat(filePath);
  return p.basenameWithoutExtension(localSystemFilePath);
}

/// Replaces all forward slashes in [path] with the local path separator.
String toLocalSystemPathFormat(String path) {
  return p.split(path).join(p.separator);
}

/// Replaces all backslashes in [path] with forward slashes.
String toUnixSystemPathFormat(String path) {
  return p.split(path).join('/');
}

/// Replaces all forward slashes in [path] with backslashes.
String toWindowsSystemPathFormat(String path) {
  return p.split(path).join('\\');
}

/// Checks if the provided [filePath] starts with an underscore or not. This
/// is commonly used to denote private files.
bool doesFileNameStartWithUnderscore(String filePath) {
  return getBaseName(filePath).startsWith('_');
}

/// Checks if the file name extracted from [filePath] matches the specified
/// beginning type [begType] and ending type [endType].
///
/// Returns a tuple with the match status and the file name.
({bool status, String fileName}) isMatchingFileName(
  String filePath,
  String begType,
  String endType,
) {
  final fileName = getBaseName(filePath);
  final a =
      begType.isEmpty ? true : fileName.startsWith('${begType.toLowerCase()}_');
  final b =
      endType.isEmpty ? true : fileName.endsWith('.$endType'.toLowerCase());
  final c = a && b;
  return (status: c, fileName: fileName);
}
