// To parse this JSON data, do
//
//     final personModel = personModelFromJson(jsonString);

import 'dart:convert';

PersonModel personModelFromJson(String str) => PersonModel.fromJson(json.decode(str));

String personModelToJson(PersonModel data) => json.encode(data.toJson());

class PersonModel {
    PersonModel({
        required this.document,
        required this.firstName,
        required this.lastName,
        required this.birthDate,
        required this.isMarried,
        required this.height,
        required this.houses,
    });

    String document;
    String firstName;
    String lastName;
    DateTime birthDate;
    bool isMarried;
    int? height;
    List<House> houses;

    factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
        document: json["document"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        birthDate: DateTime.parse(json["birthDate"]),
        isMarried: json["isMarried"],
        height: json["height"],
        houses: List<House>.from(json["houses"].map((x) => House.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "document": document,
        "firstName": firstName,
        "lastName": lastName,
        "birthDate": birthDate.toIso8601String(),
        "isMarried": isMarried,
        "height": height,
        "houses": List<dynamic>.from(houses.map((x) => x.toJson())),
    };
}

class House {
    House({
        this.description = "",
        this.address = "",
        this.ownerId = 0,
        this.owner = "",
    });

    String description;
    String address;
    int ownerId;
    String owner;

    factory House.fromJson(Map<String, dynamic> json) => House(
        description: json["description"] ?? "",
        address: json["address"] ?? "",
        ownerId: json["ownerID"] ?? 0,
        owner: json["owner"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "address": address,
        "ownerID": ownerId,
        "owner": owner,
    };
}
