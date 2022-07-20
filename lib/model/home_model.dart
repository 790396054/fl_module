
import 'package:fl_module/model/common_model.dart';
import 'package:fl_module/model/config_model.dart';
import 'package:fl_module/model/grid_nav_model.dart';
import 'package:fl_module/model/sales_box_model.dart';

class HomeModel {
  ConfigModel? config;
  List<CommonModel>? bannerList;
  List<CommonModel>? localNavList;
  List<CommonModel>? subNavList;
  GridNavModel? gridNav;
  SalesBoxModel? salesBox;

  HomeModel(
      {this.config,
        this.bannerList,
        this.localNavList,
        this.gridNav,
        this.subNavList,
        this.salesBox});

  factory HomeModel.fromJson(Map<String, dynamic> json) {

    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList = localNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList =
    bannerListJson.map((i) => CommonModel.fromJson(i)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList =
    subNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    return HomeModel(
      localNavList: localNavList,
      bannerList: bannerList,
      subNavList: subNavList,
      config: ConfigModel.fromJson(json['config']),
      gridNav: GridNavModel.fromJson(json['gridNav']),
      salesBox: SalesBoxModel.fromJson(json['salesBox']),
    );
  }
}