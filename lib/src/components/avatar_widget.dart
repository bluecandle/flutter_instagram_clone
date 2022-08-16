import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum AvatarType { TYPE1, TYPE2, TYPE3 }

class AvatarWidget extends StatelessWidget {
  bool? hasStory;
  String thumbPath;
  String? nickname;
  AvatarType type;
  double? size;

  AvatarWidget(
      {Key? key,
      this.hasStory,
      required this.thumbPath,
      this.nickname,
      required this.type,
      this.size})
      : super(key: key);

  Widget type1Widget() {
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              // 대각선 그라데이션 넣기.
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.purple, Colors.orange]),
          shape: BoxShape.circle),
      child: type2Widget(),
    );
  }

  Widget type2Widget() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(size ?? 65),
          child: SizedBox(
              width: size ?? 65,
              height: size ?? 65,
              child:
                  CachedNetworkImage(imageUrl: thumbPath, fit: BoxFit.cover))),
    );
  }

  Widget type3Widget() {
    return Row(
      children: [
        type1Widget(),
        Text(nickname ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AvatarType.TYPE1:
        return type1Widget();
      case AvatarType.TYPE2:
        return type2Widget();
      case AvatarType.TYPE3:
        return type3Widget();
    }
  }
}
