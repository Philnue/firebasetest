class License {
  final String name;
  final int available;
  final int registered;
  final String license;
  final String shortPrefix;
  final int initCount;

  License(
    this.name,
    this.available,
    this.registered,
    this.license,
    this.shortPrefix,
    this.initCount,
  );

  factory License.fromJson(Map<dynamic, dynamic> json) {
    return License(
      json["name"],
      json["available"],
      json["registered"],
      json["license"],
      json["shortPrefix"],
      json["initCount"],
    );
  }

  static List<License> userDataListFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return License.fromJson(data.data());
    }).toList();
  }
}
