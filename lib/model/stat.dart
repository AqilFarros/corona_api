// To parse this JSON data, do
//
//     final stat = statFromJson(jsonString);

import 'dart:convert';

Stat statFromJson(String str) => Stat.fromJson(json.decode(str));

String statToJson(Stat data) => json.encode(data.toJson());

class Stat {
  String? type;
  String? name;
  int? timestamp;
  Numbers? numbers;
  List<Region>? regions;

  Stat({
    this.type,
    this.name,
    this.timestamp,
    this.numbers,
    this.regions,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        type: json["type"],
        name: json["name"],
        timestamp: json["timestamp"],
        numbers:
            json["numbers"] == null ? null : Numbers.fromJson(json["numbers"]),
        regions: json["regions"] == null
            ? []
            : List<Region>.from(
                json["regions"]!.map((x) => Region.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "timestamp": timestamp,
        "numbers": numbers?.toJson(),
        "regions": regions == null
            ? []
            : List<dynamic>.from(regions!.map((x) => x.toJson())),
      };
}

class Numbers {
  double? infected;
  double? recovered;
  double? fatal;

  Numbers({
    this.infected,
    this.recovered,
    this.fatal,
  });

  factory Numbers.fromJson(Map<String, dynamic> json) => Numbers(
        infected: json["infected"],
        recovered: json["recovered"],
        fatal: json["fatal"],
      );

  Map<String, dynamic> toJson() => {
        "infected": infected,
        "recovered": recovered,
        "fatal": fatal,
      };
}

class Region {
  Type? type;
  String? name;
  Numbers? numbers;

  Region({
    this.type,
    this.name,
    this.numbers,
  });

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        type: typeValues.map[json["type"]]!,
        name: json["name"],
        numbers:
            json["numbers"] == null ? null : Numbers.fromJson(json["numbers"]),
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "name": name,
        "numbers": numbers?.toJson(),
      };
}

enum Type { PROVINCE }

final typeValues = EnumValues({"province": Type.PROVINCE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
