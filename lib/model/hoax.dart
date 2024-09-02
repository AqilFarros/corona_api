// To parse this JSON data, do
//
//     final hoax = hoaxFromJson(jsonString);

import 'dart:convert';

List<Hoax> hoaxFromJson(String str) => List<Hoax>.from(json.decode(str).map((x) => Hoax.fromJson(x)));

String hoaxToJson(List<Hoax> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Hoax {
    String? title;
    String? url;
    int? timestamp;

    Hoax({
        this.title,
        this.url,
        this.timestamp,
    });

    factory Hoax.fromJson(Map<String, dynamic> json) => Hoax(
        title: json["title"],
        url: json["url"],
        timestamp: json["timestamp"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "url": url,
        "timestamp": timestamp,
    };
}
