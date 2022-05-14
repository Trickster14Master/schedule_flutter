import 'dart:convert';

List<Statistic> statisticFromJson(String str) =>
    List<Statistic>.from(json.decode(str).map((x) => Statistic.fromJson(x)));

String statisticToJson(List<Statistic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Statistic {
  Statistic({
    required this.status1,
    required this.status2,
    required this.status3,
  });

  int status1;
  int status2;
  int status3;

  factory Statistic.fromJson(Map<String, dynamic> json) => Statistic(
        status1: json["status 1"],
        status2: json["status 2"],
        status3: json["status 3"],
      );

  Map<String, dynamic> toJson() => {
        "status 1": status1,
        "status 2": status2,
        "status 3": status3,
      };
}
