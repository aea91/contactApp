class BaseLocal {
  DateTime? time;
  dynamic model;

  BaseLocal({this.model, this.time});

  BaseLocal.fromJson(Map<dynamic, dynamic> json) {
    time = DateTime.parse(json['time']);
    model = json['model'];
  }

  Map<dynamic, dynamic>? toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['time'] = time.toString();
    data['model'] = model;
    return data;
  }
}
