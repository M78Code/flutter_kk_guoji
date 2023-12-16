class MyAccountModel {}

class AwsS3Model {
  String? action;
  String? name;
  String? path;
  String? url;
  Args? args;

  AwsS3Model({this.action, this.name, this.path, this.url, this.args});

  AwsS3Model.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    name = json['name'];
    path = json['path'];
    url = json['url'];
    args = json['args'] != null ? Args.fromJson(json['args']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['action'] = action;
    data['name'] = name;
    data['path'] = path;
    data['url'] = url;
    if (args != null) {
      data['args'] = args!.toJson();
    }
    return data;
  }
}

class Args {
  String? key;
  String? acl;
  String? successActionStatus;
  String? xAmzCredential;
  String? xAmzAlgorithm;
  String? xAmzDate;
  String? policy;

  Args({this.key, this.acl, this.successActionStatus, this.xAmzCredential, this.xAmzAlgorithm, this.xAmzDate, this.policy});

  Args.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    acl = json['acl'];
    successActionStatus = json['success_action_status'];
    xAmzCredential = json['X-Amz-Credential'];
    xAmzAlgorithm = json['X-Amz-Algorithm'];
    xAmzDate = json['X-Amz-Date'];
    policy = json['Policy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['acl'] = acl;
    data['success_action_status'] = successActionStatus;
    data['X-Amz-Credential'] = xAmzCredential;
    data['X-Amz-Algorithm'] = xAmzAlgorithm;
    data['X-Amz-Date'] = xAmzDate;
    data['Policy'] = policy;
    return data;
  }
}
