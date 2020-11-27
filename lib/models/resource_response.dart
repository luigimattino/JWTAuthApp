class ResourcesResponse {
  final List<ResourceModel> resources;
  ResourcesResponse({this.resources});

  int length() {
    if (resources != null) return resources.length;
    return 0;
  }

  factory ResourcesResponse.fromJson(List<dynamic> parsedJson) {
    List<ResourceModel> resources = new List<ResourceModel>();
    resources = parsedJson.map((i) => ResourceModel.fromJson(i)).toList();
    return new ResourcesResponse(resources: resources);
  }
}

class ResourceModel {
  final String username;
  final String name;
  final String surname;

  ResourceModel({this.username, this.name, this.surname});

  Map<String, dynamic> toJson() =>
      {'username': username, 'name': name, 'surname': surname};

  factory ResourceModel.fromJson(Map<String, dynamic> json) {
    return ResourceModel(
        name: json['name'],
        username: json['username'],
        surname: json['surname']);
  }
}
