import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/components/avatar_widget.dart';
import 'package:flutter_clone_instagram/src/components/image_data.dart';
import 'package:flutter_clone_instagram/src/components/post_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Widget _myStory() {
    return Stack(children: [
      AvatarWidget(
          thumbPath:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSHV3R80yeui3p965gM6I6gw7GQ3CYK7qSYhn_72lYJ_NiTAr0MMcfTT5DChgz33AKuek&usqp=CAU',
          type: AvatarType.TYPE2,
          size: 70),
      // 우하단 버튼
      Positioned(
          right: 10,
          bottom: 10,
          child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  border: Border.all(color: Colors.white, width: 2)),
              child: const Center(
                child: Text("+",
                    style: TextStyle(
                        fontSize: 20, color: Colors.white, height: 1.1)),
              ))),
    ]);
  }

  Widget _storyBoardList() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(children: [
            // 위젯간 공간을 확보하기 위해 SizedBox 이런거 쓰는 것도 좋다!
            SizedBox(width: 20),
            _myStory(),
            SizedBox(width: 5),
            ...List.generate(
                100,
                (index) => AvatarWidget(
                    thumbPath:
                        'https://images.pexels.com/photos/45201/kitty-cat-kitten-pet-45201.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                    type: AvatarType.TYPE1))
          ]),
        ));
  }

  Widget _postList() {
    return Column(
        children: List.generate(50, (index) => const PostWidget()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // appBar 음영 보이는 여부 조절.
          elevation: 0,
          title: ImageData(IconsPath.logo, width: 270),
          actions: [
            GestureDetector(
              onTap: () {},
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ImageData(IconsPath.directMessage, width: 50)),
            )
          ],
        ),
        body: ListView(
          children: [_storyBoardList(), _postList()],
        ));
  }
}
