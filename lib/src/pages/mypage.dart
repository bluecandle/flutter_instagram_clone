// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/components/avatar_widget.dart';
import 'package:flutter_clone_instagram/src/components/image_data.dart';
import 'package:flutter_clone_instagram/src/components/user_card.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

// TickerProviderStateMixin : TabController 를 사용하기 위함
class _MyPageState extends State<MyPage> with TickerProviderStateMixin {
  // Tab 을 사용하려면 TabController 를 달아줘야함!
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // vsync 에 TickerProvider 가 주어져야 하는데, 클래스에서 TickerProviderStateMixin 으로 TickerProvider 를 사용할 수 있도록 설정하고 있기 때문에, 그냥 this 로 넣어주면 되는듯?
    tabController = TabController(length: 2, vsync: this);
  }

  Widget _statisticsEach(String title, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 15, color: Colors.black),
        )
      ],
    );
  }

  Widget _information() {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            AvatarWidget(
                thumbPath:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgbHKCvVwI1otDjPaLdJnp3yKzpfYtIaUWMA&usqp=CAU',
                type: AvatarType.TYPE3,
                size: 80),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: _statisticsEach('Post', 999)),
                  Expanded(child: _statisticsEach('Followers', 99999)),
                  Expanded(child: _statisticsEach('Following', 99999))
                ],
              ),
            )
          ],
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Text(
        '인스타그램 클론코딩',
        style: const TextStyle(fontSize: 13, color: Colors.black),
      )
    ]);
  }

  Widget _menu() {
    // 버튼이 두 개니까, row 로 구분해주자.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(children: [
        // 화면 전체를 사용하니까 Expanded
        Expanded(
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: const Color(0xffdedede))),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ))),

        const SizedBox(
          width: 8,
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: const Color(0xffdedede)),
            color: const Color(0xffefefef),
          ),
          child: ImageData(IconsPath.addFriend),
        )
      ]),
    );
  }

  Widget _discoverPeople() {
    // 제목이 있기 때문에, Column 으로 감싸서 세로로 단을 나눠준다.
    // Column 자체를 Padding 으로 감싸면, 스크롤 영역이 화면 밖으로 넘어가지지 않는다. > 전체적으로 Padding 을 주지 않고 Row 부분만 부여
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child:
              // ignore: prefer_const_literals_to_create_immutables
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Discover People",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Text("See All",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 15))
          ]),
        ),
        SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(
                    10,
                    (index) => UserCard(
                        userId: "bluecandle$index",
                        description: "bluecandle$index 님이 팔로우합니다.")).toList())),
      ],
    );
  }

  Widget _tapMenu() {
    return TabBar(
        controller: tabController,
        indicatorColor: Colors.black,
        indicatorWeight: 1,
        tabs: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ImageData(IconsPath.gridViewOn),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ImageData(IconsPath.myTagImageOff),
          )
        ]);
  }

  Widget _tabView() {
    return GridView.builder(
        // builder 는 가장 상위에 스크롤뷰가 있어서, physics 무효화 시켜야함,
        // 오호...이건 무슨 말이지? gridView builder 최상위에 있다는건가 아니면 아래 build 함수에서 _tabView 함수가 호출되는 구조인데
        // 아래 build 함수에서 스크롤뷰로 감싸고 있기 때문에 그렇다는건가?
        // 이거 끄면, 화면 전체 스크롤이 사라짐 -> 사진 내려간 상태에서 다시 화면 올릴 수 없는 상태가 됨. 그리드뷰 쓰는 환경인데, 스크롤뷰를 같이 쓰고있다?? 그러면 아래 옵션 고려!
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 100,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.green,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'bluecandle',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ImageData(
                IconsPath.uploadIcon,
                width: 50,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ImageData(
                IconsPath.menuIcon,
                width: 50,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
          // 다섯 개의 영역을 위에서 아래로 차곡차곡 쌓을건데, 각각의 영역은 가로로 한 줄인 형태니까 Row 사용
          child: Column(
        children: [
          _information(),
          _menu(),
          _discoverPeople(),
          const SizedBox(
            height: 20,
          ),
          _tapMenu(),
          _tabView()
        ],
      )),
    );
  }
}
