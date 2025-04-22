class VersionDetails {
  VersionDetails({
      this.androidPrompt, 
      this.iosVersionName, 
      this.isAndroidForceUpdate, 
      this.isIosForceUpdate, 
      this.androidLink, 
      this.androidShowPrompt, 
      this.iosVersionCode, 
      this.iosPrompt, 
      this.androidVersionName, 
      this.iosShowPrompt, 
      this.androidVersionCode,});

  VersionDetails.fromJson(dynamic json) {
    androidPrompt = json['android_prompt'];
    iosVersionName = json['ios_version_name'];
    isAndroidForceUpdate = json['is_android_force_update'];
    isIosForceUpdate = json['is_ios_force_update'];
    androidLink = json['android_link'];
    androidShowPrompt = json['android_show_prompt'];
    iosVersionCode = json['ios_version_code'];
    iosPrompt = json['ios_prompt'];
    androidVersionName = json['android_version_name'];
    iosShowPrompt = json['ios_show_prompt'];
    androidVersionCode = json['android_version_code'];
  }
  String? androidPrompt;
  String? iosVersionName;
  bool? isAndroidForceUpdate;
  bool? isIosForceUpdate;
  String? androidLink;
  bool? androidShowPrompt;
  num? iosVersionCode;
  String? iosPrompt;
  String? androidVersionName;
  bool? iosShowPrompt;
  num? androidVersionCode;
VersionDetails copyWith({  String? androidPrompt,
  String? iosVersionName,
  bool? isAndroidForceUpdate,
  bool? isIosForceUpdate,
  String? androidLink,
  bool? androidShowPrompt,
  num? iosVersionCode,
  String? iosPrompt,
  String? androidVersionName,
  bool? iosShowPrompt,
  num? androidVersionCode,
}) => VersionDetails(  androidPrompt: androidPrompt ?? this.androidPrompt,
  iosVersionName: iosVersionName ?? this.iosVersionName,
  isAndroidForceUpdate: isAndroidForceUpdate ?? this.isAndroidForceUpdate,
  isIosForceUpdate: isIosForceUpdate ?? this.isIosForceUpdate,
  androidLink: androidLink ?? this.androidLink,
  androidShowPrompt: androidShowPrompt ?? this.androidShowPrompt,
  iosVersionCode: iosVersionCode ?? this.iosVersionCode,
  iosPrompt: iosPrompt ?? this.iosPrompt,
  androidVersionName: androidVersionName ?? this.androidVersionName,
  iosShowPrompt: iosShowPrompt ?? this.iosShowPrompt,
  androidVersionCode: androidVersionCode ?? this.androidVersionCode,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['android_prompt'] = androidPrompt;
    map['ios_version_name'] = iosVersionName;
    map['is_android_force_update'] = isAndroidForceUpdate;
    map['is_ios_force_update'] = isIosForceUpdate;
    map['android_link'] = androidLink;
    map['android_show_prompt'] = androidShowPrompt;
    map['ios_version_code'] = iosVersionCode;
    map['ios_prompt'] = iosPrompt;
    map['android_version_name'] = androidVersionName;
    map['ios_show_prompt'] = iosShowPrompt;
    map['android_version_code'] = androidVersionCode;
    return map;
  }

}