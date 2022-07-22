///旅拍类别模型
class TravelTabModel {
  Map? params;
  String? url;
  late List<TravelTab> tabs;

  TravelTabModel({this.url, required this.tabs});

  TravelTabModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    params = json['params'];
    if (json['tabs'] != null) {
      tabs = <TravelTab>[];
      json['tabs'].forEach((v) {
        tabs.add(TravelTab.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['tabs'] = tabs.map((v) => v.toJson()).toList();
    return data;
  }
}

class TravelTab {
  String? labelName;
  String? groupChannelCode;

  TravelTab({this.labelName, this.groupChannelCode});

  TravelTab.fromJson(Map<String, dynamic> json) {
    labelName = json['labelName'];
    groupChannelCode = json['groupChannelCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['labelName'] = this.labelName;
    data['groupChannelCode'] = this.groupChannelCode;
    return data;
  }
}
