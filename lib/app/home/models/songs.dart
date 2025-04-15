class Songs {
  Songs({
    this.success,
    this.data,
  });

  Songs.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  Data? data;

  Songs copyWith({
    bool? success,
    Data? data,
  }) =>
      Songs(
        success: success ?? this.success,
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.total,
    this.start,
    this.results,
  });

  Data.fromJson(dynamic json) {
    total = json['total'];
    start = json['start'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
  }

  num? total;
  num? start;
  List<Results>? results;

  Data copyWith({
    num? total,
    num? start,
    List<Results>? results,
  }) =>
      Data(
        total: total ?? this.total,
        start: start ?? this.start,
        results: results ?? this.results,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['start'] = start;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Results {
  Results({
    this.id,
    this.name,
    this.type,
    this.year,
    this.releaseDate,
    this.duration,
    this.label,
    this.explicitContent,
    this.playCount,
    this.language,
    this.hasLyrics,
    this.lyricsId,
    this.url,
    this.copyright,
    this.album,
    this.artists,
    this.image,
    this.downloadUrl,
  });

  Results.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    year = json['year'];
    releaseDate = json['releaseDate'];
    duration = json['duration'];
    label = json['label'];
    explicitContent = json['explicitContent'];
    playCount = json['playCount'];
    language = json['language'];
    hasLyrics = json['hasLyrics'];
    lyricsId = json['lyricsId'];
    url = json['url'];
    copyright = json['copyright'];
    album = json['album'] != null ? Album.fromJson(json['album']) : null;
    artists = json['artists'] != null ? Artists.fromJson(json['artists']) : null;
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(Image.fromJson(v));
      });
    }
    if (json['downloadUrl'] != null) {
      downloadUrl = [];
      json['downloadUrl'].forEach((v) {
        downloadUrl?.add(DownloadUrl.fromJson(v));
      });
    }
  }

  String? id;
  String? name;
  String? type;
  String? year;
  dynamic releaseDate;
  num? duration;
  String? label;
  bool? explicitContent;
  num? playCount;
  String? language;
  bool? hasLyrics;
  dynamic lyricsId;
  String? url;
  String? copyright;
  Album? album;
  Artists? artists;
  List<Image>? image;
  List<DownloadUrl>? downloadUrl;

  Results copyWith({
    String? id,
    String? name,
    String? type,
    String? year,
    dynamic releaseDate,
    num? duration,
    String? label,
    bool? explicitContent,
    num? playCount,
    String? language,
    bool? hasLyrics,
    dynamic lyricsId,
    String? url,
    String? copyright,
    Album? album,
    Artists? artists,
    List<Image>? image,
    List<DownloadUrl>? downloadUrl,
  }) =>
      Results(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        year: year ?? this.year,
        releaseDate: releaseDate ?? this.releaseDate,
        duration: duration ?? this.duration,
        label: label ?? this.label,
        explicitContent: explicitContent ?? this.explicitContent,
        playCount: playCount ?? this.playCount,
        language: language ?? this.language,
        hasLyrics: hasLyrics ?? this.hasLyrics,
        lyricsId: lyricsId ?? this.lyricsId,
        url: url ?? this.url,
        copyright: copyright ?? this.copyright,
        album: album ?? this.album,
        artists: artists ?? this.artists,
        image: image ?? this.image,
        downloadUrl: downloadUrl ?? this.downloadUrl,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['type'] = type;
    map['year'] = year;
    map['releaseDate'] = releaseDate;
    map['duration'] = duration;
    map['label'] = label;
    map['explicitContent'] = explicitContent;
    map['playCount'] = playCount;
    map['language'] = language;
    map['hasLyrics'] = hasLyrics;
    map['lyricsId'] = lyricsId;
    map['url'] = url;
    map['copyright'] = copyright;
    if (album != null) {
      map['album'] = album?.toJson();
    }
    if (artists != null) {
      map['artists'] = artists?.toJson();
    }
    if (image != null) {
      map['image'] = image?.map((v) => v.toJson()).toList();
    }
    if (downloadUrl != null) {
      map['downloadUrl'] = downloadUrl?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class DownloadUrl {
  DownloadUrl({
    this.quality,
    this.url,
  });

  DownloadUrl.fromJson(dynamic json) {
    quality = json['quality'];
    url = json['url'];
  }

  String? quality;
  String? url;

  DownloadUrl copyWith({
    String? quality,
    String? url,
  }) =>
      DownloadUrl(
        quality: quality ?? this.quality,
        url: url ?? this.url,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quality'] = quality;
    map['url'] = url;
    return map;
  }
}

class Image {
  Image({
    this.quality,
    this.url,
  });

  Image.fromJson(dynamic json) {
    quality = json['quality'];
    url = json['url'];
  }

  String? quality;
  String? url;

  Image copyWith({
    String? quality,
    String? url,
  }) =>
      Image(
        quality: quality ?? this.quality,
        url: url ?? this.url,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quality'] = quality;
    map['url'] = url;
    return map;
  }
}

class Artists {
  Artists({
    this.primary,
    this.featured,
    this.all,
  });

  Artists.fromJson(dynamic json) {
    if (json['primary'] != null) {
      primary = [];
      json['primary'].forEach((v) {
        primary?.add(Primary.fromJson(v));
      });
    }
    if (json['featured'] != null) {
      featured = [];
      /*json['featured'].forEach((v) {
        featured?.add(Dynamic.fromJson(v));
      });*/
    }
    if (json['all'] != null) {
      all = [];
      json['all'].forEach((v) {
        all?.add(All.fromJson(v));
      });
    }
  }

  List<Primary>? primary;
  List<dynamic>? featured;
  List<All>? all;

  Artists copyWith({
    List<Primary>? primary,
    List<dynamic>? featured,
    List<All>? all,
  }) =>
      Artists(
        primary: primary ?? this.primary,
        featured: featured ?? this.featured,
        all: all ?? this.all,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (primary != null) {
      map['primary'] = primary?.map((v) => v.toJson()).toList();
    }
    if (featured != null) {
      map['featured'] = featured?.map((v) => v.toJson()).toList();
    }
    if (all != null) {
      map['all'] = all?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class All {
  All({
    this.id,
    this.name,
    this.role,
    this.image,
    this.type,
    this.url,
  });

  All.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(Image.fromJson(v));
      });
    }
    type = json['type'];
    url = json['url'];
  }

  String? id;
  String? name;
  String? role;
  List<Image>? image;
  String? type;
  String? url;

  All copyWith({
    String? id,
    String? name,
    String? role,
    List<Image>? image,
    String? type,
    String? url,
  }) =>
      All(
        id: id ?? this.id,
        name: name ?? this.name,
        role: role ?? this.role,
        image: image ?? this.image,
        type: type ?? this.type,
        url: url ?? this.url,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['role'] = role;
    if (image != null) {
      map['image'] = image?.map((v) => v.toJson()).toList();
    }
    map['type'] = type;
    map['url'] = url;
    return map;
  }
}


class Primary {
  Primary({
    this.id,
    this.name,
    this.role,
    this.image,
    this.type,
    this.url,
  });

  Primary.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(Image.fromJson(v));
      });
    }
    type = json['type'];
    url = json['url'];
  }

  String? id;
  String? name;
  String? role;
  List<Image>? image;
  String? type;
  String? url;

  Primary copyWith({
    String? id,
    String? name,
    String? role,
    List<Image>? image,
    String? type,
    String? url,
  }) =>
      Primary(
        id: id ?? this.id,
        name: name ?? this.name,
        role: role ?? this.role,
        image: image ?? this.image,
        type: type ?? this.type,
        url: url ?? this.url,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['role'] = role;
    if (image != null) {
      map['image'] = image?.map((v) => v.toJson()).toList();
    }
    map['type'] = type;
    map['url'] = url;
    return map;
  }
}

class Album {
  Album({
    this.id,
    this.name,
    this.url,
  });

  Album.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
  }

  String? id;
  String? name;
  String? url;

  Album copyWith({
    String? id,
    String? name,
    String? url,
  }) =>
      Album(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['url'] = url;
    return map;
  }
}
