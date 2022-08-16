import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/components/avatar_widget.dart';

class ActiveHistory extends StatelessWidget {
  const ActiveHistory({Key? key}) : super(key: key);

  Widget _activeItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          AvatarWidget(
            type: AvatarType.TYPE2,
            size: 40,
            thumbPath:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgbHKCvVwI1otDjPaLdJnp3yKzpfYtIaUWMA&usqp=CAU',
          ),
          const SizedBox(
            width: 10,
          ),
          const Expanded(
            child: Text.rich(TextSpan(
                text: 'blucandle',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                      text: "님이 회원님의 게시물을 좋아합니다. 님이 회원님의 게시물을 좋아합니다.",
                      style: TextStyle(fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: ' 5일전',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                          color: Colors.black54))
                ])),
          )
        ],
      ),
    );
  }

  Widget _newRecentlyActiveView(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          _activeItem(),
          _activeItem(),
          _activeItem(),
          _activeItem(),
          _activeItem(),
          _activeItem(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          '활동',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          // 그룹을 세 개로 나눠보자.
          _newRecentlyActiveView('오늘'),
          _newRecentlyActiveView('이번주'),
          _newRecentlyActiveView('이번달'),
        ],
      )),
    );
  }
}
