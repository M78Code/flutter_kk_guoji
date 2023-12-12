class GetGameModel {
  int? id;
  int? gamePlatformId;
  int? gameCompanyId;
  String? gameCompanyCode;
  String? code;
  String? h5Code;
  int? type;
  int? cateType;
  String? name;
  String? image;
  int? sort;
  int? isHot;
  String? gamePlatformName;

  GetGameModel(
      {this.id,
        this.gamePlatformId,
        this.gameCompanyId,
        this.gameCompanyCode,
        this.code,
        this.h5Code,
        this.type,
        this.cateType,
        this.name,
        this.image,
        this.sort,
        this.isHot,
        this.gamePlatformName});

  GetGameModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gamePlatformId = json['game_platform_id'];
    gameCompanyId = json['game_company_id'];
    gameCompanyCode = json['game_company_code'];
    code = json['code'];
    h5Code = json['h5_code'];
    type = json['type'];
    cateType = json['cate_type'];
    name = json['name'];
    image = json['image'];
    sort = json['sort'];
    isHot = json['is_hot'];
    gamePlatformName = json['game_platform_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['game_platform_id'] = this.gamePlatformId;
    data['game_company_id'] = this.gameCompanyId;
    data['game_company_code'] = this.gameCompanyCode;
    data['code'] = this.code;
    data['h5_code'] = this.h5Code;
    data['type'] = this.type;
    data['cate_type'] = this.cateType;
    data['name'] = this.name;
    data['image'] = this.image;
    data['sort'] = this.sort;
    data['is_hot'] = this.isHot;
    data['game_platform_name'] = this.gamePlatformName;
    return data;
  }
}