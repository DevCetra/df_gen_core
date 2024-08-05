//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Dart/Flutter (DF) Packages by DevCetra.com & contributors. See LICENSE file
// in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import '/src/_index.g.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class ReplacementProducer<TInsight, TPlaceholder extends Enum> {
  //
  //
  //

  final Future<List<InsightMapper<TInsight, TPlaceholder>>> Function() _getMappers;

  //
  //
  //

  const ReplacementProducer(this._getMappers);

  //
  //
  //

  Future<Map<String, String>> Function(TInsight insight) get produceReplacements =>
      (insight) async {
        final mappers = await this._getMappers();
        final entries = await Future.wait(
          mappers.map(
            (e) async {
              return MapEntry(
                e.placeholder.placeholder,
                await e.mapInsights(insight),
              );
            },
          ),
        );
        return Map.fromEntries(entries);
      };
}
