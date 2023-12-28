import 'dart:io';
import 'dart:convert';
import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/utils/aws_policy.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

// import 'package:test/test.dart';
// import 'package:amazon_cognito_identity_dart/sig_v4.dart';

class AwsService {
  static const _accessKeyId = "AKxxxxx";
  static const _secretKeyId = "xxxxx/xxxx";
  static const _region = "ap-southeast-1";
  static const _s3Endpoint = "https://bucketname.s3-ap-southeast-1.amazonaws.com";

  void test() async {
    // final file = File(path.join('/path/to/file', 'square-cinnamon.jpg'));
    // final stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
    // final length = await file.length();
    //
    // final uri = Uri.parse(_s3Endpoint);
    // final req = http.MultipartRequest("POST", uri);
    // final multipartFile = http.MultipartFile('file', stream, length, filename: path.basename(file.path));
    //
    // final policy = AwsPolicy.fromS3PresignedPost('uploaded/square-cinnamon.jpg', 'bucketname', _accessKeyId, 15, length, region: _region);
    // final key = SigV4.calculateSigningKey(_secretKeyId, policy.datetime, _region, 's3');
    // final signature = SigV4.calculateSignature(key, policy.encode());
    //
    // req.files.add(multipartFile);
    // req.fields['key'] = policy.key;
    // req.fields['acl'] = 'public-read';
    // req.fields['X-Amz-Credential'] = policy.credential;
    // req.fields['X-Amz-Algorithm'] = 'AWS4-HMAC-SHA256';
    // req.fields['X-Amz-Date'] = policy.datetime;
    // req.fields['Policy'] = policy.encode();
    // req.fields['X-Amz-Signature'] = signature;
    //
    // try {
    //   final res = await req.send();
    //   await for (var value in res.stream.transform(utf8.decoder)) {
    //     print(value);
    //   }
    // } catch (e) {
    //   print(e.toString());
    // }
  }

}
