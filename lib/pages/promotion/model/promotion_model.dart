class KKPromotionModel {
  String? inviteCode;
  int? teamTotalCount;
  int? teamOnlineCount;
  String? totalCommission;
  String? teamTotalPerformance;
  String? todayCommission;
  String? todayGameUserBet;
  String? todayTeamTotalPerformance;
  List<Domain>? domain;
  List<String>? image;

  KKPromotionModel(
      {this.inviteCode,
        this.teamTotalCount,
        this.teamOnlineCount,
        this.totalCommission,
        this.teamTotalPerformance,
        this.todayCommission,
        this.todayGameUserBet,
        this.todayTeamTotalPerformance,
        this.domain,
        this.image});

  KKPromotionModel.fromJson(Map<String, dynamic> json) {
    inviteCode = json['inviteCode'];
    teamTotalCount = json['teamTotalCount'];
    teamOnlineCount = json['teamOnlineCount'];
    totalCommission = json['totalCommission'];
    teamTotalPerformance = json['teamTotalPerformance'];
    todayCommission = json['todayCommission'];
    todayGameUserBet = json['todayGameUserBet'];
    todayTeamTotalPerformance = json['todayTeamTotalPerformance'];
    if (json['domain'] != null) {
      domain = <Domain>[];
      json['domain'].forEach((v) {
        domain!.add(Domain.fromJson(v));
      });
    }
    image = json['image'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['inviteCode'] = this.inviteCode;
    data['teamTotalCount'] = this.teamTotalCount;
    data['teamOnlineCount'] = this.teamOnlineCount;
    data['totalCommission'] = this.totalCommission;
    data['teamTotalPerformance'] = this.teamTotalPerformance;
    data['todayCommission'] = this.todayCommission;
    data['todayGameUserBet'] = this.todayGameUserBet;
    data['todayTeamTotalPerformance'] = this.todayTeamTotalPerformance;
    if (this.domain != null) {
      data['domain'] = this.domain!.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    return data;
  }
}

class Domain {
  String? url;

  Domain({this.url});

  Domain.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}
