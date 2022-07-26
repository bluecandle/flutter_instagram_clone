import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/components/avatar_widget.dart';
import 'package:flutter_clone_instagram/src/components/image_data.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({Key? key}) : super(key: key);

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
          // 왼쪽 끝, 우측 끝으로 각각 붙이도록 만드는 옵션!
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AvatarWidget(
              thumbPath:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSHV3R80yeui3p965gM6I6gw7GQ3CYK7qSYhn_72lYJ_NiTAr0MMcfTT5DChgz33AKuek&usqp=CAU',
              type: AvatarType.TYPE3,
              nickname: 'bluecandle',
              size: 40,
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ImageData(
                  IconsPath.postMoreIcon,
                  width: 30,
                ),
              ),
            )
          ]),
    );
  }

  Widget _image() {
    return CachedNetworkImage(
        imageUrl:
            'https://images.unsplash.com/photo-1568430462989-44163eb1752f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80');
  }

  Widget _infoCount() {
    // 좋아요, 댓글, 메시지 등의 구역이 나눠지기 때문에 Row 두 개로 구성.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            ImageData(IconsPath.likeOffIcon, width: 65),
            const SizedBox(width: 15),
            ImageData(IconsPath.replyIcon, width: 60),
            const SizedBox(width: 15),
            ImageData(IconsPath.directMessage, width: 55),
          ],
        ),
        ImageData(
          IconsPath.bookMarkOffIcon,
          width: 50,
        )
      ]),
    );
  }

  Widget _infoDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Text(
          '좋아요 150개',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ExpandableText(
          '컨텐츠 1 등록\n컨텐츠 1 등록\n컨텐츠 1 등록\n컨텐츠 1 등록\n컨텐츠 1 등록\n컨텐츠 1 등록',
          prefixText: 'bluecandle',
          prefixStyle: TextStyle(fontWeight: FontWeight.bold),
          // prefix 에 적힌 닉네임 클릭하면 해당 사용자 페이지로 이동.
          onPrefixTap: () {
            print('bluecandle 페이지 이동');
          },
          expandText: '더보기',
          collapseText: '접기',
          maxLines: 3,
          // expandOnTextTap: true,
          // collapseOnTextTap: true,
          linkColor: Colors.grey,
        )
      ]),
    );
  }

  Widget _replyTextBtn() {
    return GestureDetector(
        onTap: (() {}),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text('댓글 199개 모두 보기',
              style: TextStyle(color: Colors.grey, fontSize: 13)),
        ));
  }

  Widget _dateAgo() {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Text('1일전', style: TextStyle(color: Colors.grey, fontSize: 11)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      // Column 으로 단계를 나눈다.
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        _header(),
        const SizedBox(height: 15),
        _image(),
        const SizedBox(height: 15),
        _infoCount(),
        const SizedBox(height: 5),
        _infoDescription(),
        const SizedBox(height: 5),
        _replyTextBtn(),
        const SizedBox(height: 5),
        _dateAgo(),
      ]),
    );
  }
}
