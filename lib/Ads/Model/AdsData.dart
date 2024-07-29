class AdsData {
  AdsData({
      this.admobfull, 
      this.admobbanner, 
      this.admobopen, 
      this.admobnative,
      this.fbfull, 
      this.fbbanner, 
      this.fbnative,
      this.click, 
      this.clickflag, 
      this.adflag, 
      this.adstyle, 
      this.adtime, 
      this.splash, 
      this.adstatus, 
      this.front,
      this.pp,});

  AdsData.fromJson(dynamic json) {
    admobfull = json['splashFull'];
    admobbanner = json['googleBanner'];
    admobopen = json['googleOpen'];
    admobnative = json['googleNative'];
    fbfull = json['fb-full'];
    fbbanner = json['fb-banner'];
    fbnative = json['fb-native'];
    click = json['click'];
    clickflag = json['clickFlag'];
    adflag = json['adFlag'];
    adstyle = json['adStyle'];
    adtime = json['adTime'];
    splash = json['splash'];
    adstatus = json['adStatus'];
    front = json['front'];
    pp = json['pp'];
  }
  String? admobfull;
  String? admobbanner;
  String? admobopen;
  String? admobnative;
  String? fbfull;
  String? fbbanner;
  String? fbnative;
  String? click;
  String?clickflag;
  String? adflag;
  String? adstyle;
  String? adtime;
  String? splash;
  String? adstatus;
  String? front;
  String? pp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['splashFull'] = admobfull;
    map['googleBanner'] = admobbanner;
    map['googleOpen'] = admobopen;
    map['googleNative'] = admobnative;
    map['fb-full'] = fbfull;
    map['fb-banner'] = fbbanner;
    map['fb-native'] = fbnative;
    map['click'] = click;
    map['clickFlag'] = clickflag;
    map['adFlag'] = adflag;
    map['Adstyle'] = adstyle;
    map['Adtime'] = adtime;
    map['splash'] = splash;
    map['adStatus'] = adstatus;
    map['front'] = front;
    map['pp'] = pp;
    return map;
  }

}