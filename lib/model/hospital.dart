// To parse this JSON data, do
//
//     final hospital = hospitalFromJson(jsonString);

import 'dart:convert';

List<Hospital> hospitalFromJson(String str) => List<Hospital>.from(json.decode(str).map((x) => Hospital.fromJson(x)));

String hospitalToJson(List<Hospital> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Hospital {
    String? name;
    String? address;
    String? region;
    String? phone;
    String? province;

    Hospital({
        this.name,
        this.address,
        this.region,
        this.phone,
        this.province,
    });

    factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
        name: json["name"],
        address: json["address"],
        region: json["region"],
        phone: json["phone"],
        province: json["province"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "region": region,
        "phone": phone,
        "province": province,
    };
}
