class ApiResponse {
  bool? success;
  String? msg;
  dynamic data;

  ApiResponse({this.success, this.msg, this.data});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['msg'] = msg;
    data['data'] = this.data;
    return data;
  }
}

// class ApiResponse<ResData> {
//   bool? isSuccess;
//   String? msg;
//   ResData? data;
//
//   ApiResponse({this.isSuccess, this.msg, this.data});
//
//   ApiResponse.fromJson(Map<String, dynamic> json) {
//     isSuccess = json['isSuccess'];
//     msg = json['msg'];
//
//     if (json.containsKey('data')) {
//       data = json['data'] != null ? ResData.fromJson(json['data']) : null;
//     } else {
//       data = null;
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['isSuccess'] = this.isSuccess;
//     data['msg'] = this.msg;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// interface class Response {
//   static fromJson(Map<String, dynamic> json) {}
//
//   Map<String, dynamic> toJson() {
//     return {};
//   }
// }
//
// class ResData implements Response {
//   ResData();
//
//   static fromJson(Map<String, dynamic> json) {}
//
//   Map<String, dynamic> toJson() {
//     return {};
//   }
// }
//
// class AuthRes extends ResData {
//   static fromJson(Map<String, dynamic> json) {}
//
//   @override
//   Map<String, dynamic> toJson() {
//     return {};
//   }
// }
