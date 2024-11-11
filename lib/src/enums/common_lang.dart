// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Dart/Flutter (DF) Packages by DevCetra.com & contributors. The use of this
// source code is governed by an MIT-style license described in the LICENSE
// file located in this project's root directory.
//
// See: https://opensource.org/license/mit
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:df_string/df_string.dart';
import 'package:path/path.dart' as p;

import '/df_gen_core.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// An enumeration of commonly used languages.
enum CommonLang {
  DART(extName: 'dart'),
  TYPESCRIPT(extName: 'ts'),
  JAVASCRIPT(extName: 'js'),
  PYTHON(extName: 'py'),
  RUST(extName: 'rs'),
  JAVA(extName: 'java'),
  KOTLIN(extName: 'kt'),
  C(extName: 'c'),
  CPP(extName: 'cpp'),
  CSHARP(extName: 'cs'),
  SWIFT(extName: 'swift'),
  GO(extName: 'go'),
  RUBY(extName: 'rb'),
  PHP(extName: 'php'),
  HTML(extName: 'html'),
  CSS(extName: 'css'),
  SQL(extName: 'sql'),
  POWERSHELL(extName: 'ps1'),
  SHELL(extName: 'sh');

  /// The file extension name most commonly associated with the language.
  final String extName;

  const CommonLang({
    required this.extName,
  });

  /// The file extension associated with the language, e.g. '.dart'.
  String get ext => '.${this.extName}';

  /// The generated file extension associated with the language, e.g. '.g.dart'.
  String get genExt => '.g.${this.extName}';

  /// The template file extension associated with the language, e.g. '.dart.md'.
  String get tmplExt => '$ext.md';

  /// Whether [filePath] is a valid generated file path for the language.
  bool isValidGenFilePath(String filePath) {
    return filePath.toLowerCase().endsWith(this.genExt);
  }

  /// Whether [filePath] is a valid source file path for the language, i.e.
  /// a valid file path that is not a generated file path.
  bool isValidSrcFilePath(String filePath) {
    return this._isValidFilePath(filePath) && !this.isValidGenFilePath(filePath);
  }

  /// Whether [filePath] is a valid file path for the language.
  bool _isValidFilePath(String filePath) {
    return filePath.toLowerCase().endsWith(this.ext);
  }

  /// Whether [filePath] is a valid template file path for the language.
  bool isValidTplFilePath(String filePath) {
    return filePath.toLowerCase().endsWith(this.tmplExt);
  }

  /// Returns corresponding source file path for [filePath] or `null` if the
  /// [filePath] is invalid for this language.
  ///
  /// **Example for CommonLang.DART:**
  /// ```txt
  /// 'hello.dart' returns 'hello.dart'
  /// 'hello.g.dart' returns 'hello.dart'
  /// 'hello.world' returns null, since 'world' is not valid for CommonLang.DART.
  /// ```
  String? getCorrespondingSrcPathOrNull(String filePath) {
    final localSystemFilePath = toLocalSystemPathFormat(filePath);
    final dirName = p.dirname(localSystemFilePath);
    final baseName = p.basename(localSystemFilePath);
    final valid = this.isValidGenFilePath(localSystemFilePath);
    if (valid) {
      final baseNameNoExt = baseName.substring(0, baseName.length - this.genExt.length);
      final srcBaseName = '$baseNameNoExt${this.ext}';
      final result = p.join(dirName, srcBaseName);
      return result;
    }
    if (baseName.endsWith(this.ext)) {
      return localSystemFilePath;
    }
    return null;
  }

  /// Returns corresponding generated file path for [filePath] or `null` if
  /// [filePath] is invalid for this language.
  ///
  /// **Example for CommonLang.DART:**
  /// ```txt
  /// 'hello.g.dart' returns 'hello.g.dart'
  /// 'hello.dart' returns 'hello.g.dart'
  /// 'hello.g.world' returns null, since 'world' is not valid for CommonLang.DART.
  /// ```
  String? getCorrespondingGenPathOrNull(String filePath) {
    final localSystemFilePath = toLocalSystemPathFormat(filePath);
    final dirName = p.dirname(localSystemFilePath);
    final baseName = p.basename(localSystemFilePath);
    final valid = this.isValidSrcFilePath(localSystemFilePath);
    if (valid) {
      final baseNameNoExt = baseName.substring(0, baseName.length - this.ext.length);
      final srcBaseName = '$baseNameNoExt${this.ext}';
      final result = p.join(dirName, srcBaseName);
      return result;
    }
    if (baseName.endsWith(this.ext)) {
      return localSystemFilePath;
    }
    return null;
  }

  /// Whether the source-and-generated pair exists for the file at [filePath]
  /// or not.
  ///
  /// This means, if [filePath] exists and points to a source file, it also
  /// checks if its generated file exists at the same location. The reverse
  /// also holds true.
  Future<bool> srcAndGenPairExistsFor(String filePath) async {
    final a = await FileSystemUtility.i.localFileExists(filePath);
    if (!a) {
      return false;
    }
    if (this.isValidSrcFilePath(filePath)) {
      final b = await FileSystemUtility.i.localFileExists(
        '${filePath.substring(0, filePath.length - this.ext.length)}${this.genExt}',
      );
      return b;
    } else if (this.isValidGenFilePath(filePath)) {
      final b = await FileSystemUtility.i.localFileExists(
        '${filePath.substring(0, filePath.length - this.genExt.length)}${this.ext}',
      );
      return b;
    } else {
      return false;
    }
  }

  /// Deletes all source files from [dirPath] that match any of the provided
  /// [pathPatterns].
  ///
  /// If [pathPatterns] is not specified, all generated files will be deleted.
  /// The [onDelete] callback is called for each file after it is deleted.
  Future<void> deleteAllSrcFiles(
    String dirPath, {
    Set<String> pathPatterns = const {},
    Future<void> Function(String filePath)? onDelete,
  }) async {
    final filePaths = await FileSystemUtility.i.listLocalFilePaths(dirPath);
    if (filePaths != null) {
      final genFilePaths = filePaths.where(
        (e) => this.isValidSrcFilePath(e) && matchesAnyPathPattern(e, pathPatterns),
      );
      for (final filePath in genFilePaths) {
        await this.deleteSrcFile(filePath);
        await onDelete?.call(filePath);
      }
    }
  }

  /// Deletes the source file corresponding to [filePath] if it exists.
  ///
  /// Returns `true` if the file was successfully deleted, otherwise returns
  /// `false`.
  Future<bool> deleteSrcFile(String filePath) async {
    if (this.isValidSrcFilePath(filePath)) {
      try {
        await FileSystemUtility.i.deleteLocalFile(filePath);
        return true;
      } catch (_) {}
    }
    return false;
  }

  /// Deletes all generated files from [dirPath] that match any of the
  /// provided [pathPatterns].
  ///
  /// If [pathPatterns] is not specified, all generated files will be deleted.
  /// The [onDelete] callback is called for each file after it is deleted.
  Future<void> deleteAllGenFiles(
    String dirPath, {
    Set<String> pathPatterns = const {},
    Future<void> Function(String filePath)? onDelete,
  }) async {
    final filePaths = await FileSystemUtility.i.listLocalFilePaths(dirPath);
    if (filePaths != null) {
      final genFilePaths = filePaths.where(
        (e) => this.isValidGenFilePath(e) && matchesAnyPathPattern(e, pathPatterns),
      );
      for (final filePath in genFilePaths) {
        await this.deleteGenFile(filePath);
        await onDelete?.call(filePath);
      }
    }
  }

  /// Deletes the generated file corresponding to  [filePath] if it exists.
  ///
  /// Returns `true` if the file was successfully deleted, otherwise returns
  /// `false`.
  Future<bool> deleteGenFile(String filePath) async {
    if (this.isValidGenFilePath(filePath)) {
      try {
        await FileSystemUtility.i.deleteLocalFile(filePath);
        return true;
      } catch (_) {}
    }
    return false;
  }

  /// Converts [srcFileName] to a gen file name, e.g. 'hello.dart' -> '_hello.g.dart';
  String convertToGenFileName(String srcFileName) {
    final a = p.basename(srcFileName).toLowerCase().replaceLast(this.ext, this.genExt);
    final b = a.startsWith('_') ? a : '_$a';
    return b;
  }

  /// Converts [genFileName] to a src file name, e.g. '_hello.g.dart' -> 'hello.dart';
  String convertToSrcFileName(String genFileName) {
    final a = p.basename(genFileName).toLowerCase().replaceLast(this.genExt, this.ext);
    final b = a.startsWith('_') && a.length > 1 ? a.substring(1) : a;
    return b;
  }
}
