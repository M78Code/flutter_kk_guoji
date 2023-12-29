import 'dart:convert';

import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';

class AwsPolicy {
  String expiration;
  String region;
  String bucket;
  String key;
  String credential;
  String datetime;
  int maxFileSize;

  AwsPolicy(this.key, this.bucket, this.datetime, this.expiration, this.credential, this.maxFileSize, {this.region = 'us-east-1'});

  factory AwsPolicy.fromS3PresignedPost(
    String key,
    String bucket,
    String accessKeyId,
    int expiryMinutes,
    int maxFileSize, {
    required String region,
  }) {
    final datetime = SigV4.generateDatetime();
    final expiration = (DateTime.now()).add(Duration(minutes: expiryMinutes)).toUtc().toString().split(' ').join('T');
    final cred = '$accessKeyId/${SigV4.buildCredentialScope(datetime, region, 's3')}';
    final p = AwsPolicy(key, bucket, datetime, expiration, cred, maxFileSize, region: region);
    return p;
  }

  String encode() {
    final bytes = utf8.encode(toString());
    return base64.encode(bytes);
  }

  @override
  String toString() {
    return '''
{ "expiration": "$expiration",
  "conditions": [
    {"bucket": "$bucket"},
    ["starts-with", "\$key", "$key"],
    {"acl": "public-read"},
    ["content-length-range", 1, $maxFileSize],
    {"x-amz-credential": "$credential"},
    {"x-amz-algorithm": "AWS4-HMAC-SHA256"},
    {"x-amz-date": "$datetime" }
  ]
}
''';
  }
}
