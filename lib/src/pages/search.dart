// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/pages/serach/search_focus.dart';
import 'package:get/get.dart';
import 'package:quiver/iterables.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<List<int>> groupBox = [[], [], []];
  List<int> groupIndex = [0, 0, 0];

  @override
  void initState() {
    // 여기서 그리드 틀을 만들고, 이후에 이미지를 넣어주는 방식으로 구성.
    super.initState();
    for (int i = 0; i < 100; i++) {
      // 첫 번째, 세 번째 컬럼에는 랜덤하게 두 칸 짜리 그리드가 들어가도록 만들기.
      int gi = groupIndex.indexOf(min<int>(groupIndex)!);
      int size = 1;
      if (gi != 1) {
        size = Random().nextInt(100) % 2 == 0 ? 1 : 2;
      }
      groupBox[i % 3].add(size);
      groupIndex[gi] += size;
    }
    print(groupBox);
  }

  Widget _appbar() {
    return Row(children: [
      Expanded(
        child: GestureDetector(
          onTap: () {
            // Navigator 를 사용하기 때문에, 기존 방식의 라우팅을 해줘야한다.
            // Get.to(SearchFocus());
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchFocus()));
          },
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              margin: const EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0xffefefef)),
              child: Row(children: [
                const Icon(Icons.search),
                const Text('검색',
                    style:
                        TextStyle(fontSize: 15, color: const Color(0xff838383)))
              ])),
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(10.0),
        child: Icon(Icons.location_pin),
      )
    ]);
  }

  Widget _body() {
    /* 
    특정 부분에는 두 칸을 차지하고, 나머지는 한 칸을 채워주는 형태의 gridview 를 만든다!
    그냥 한 칸 한 칸 동일하다면 gridview 쓰면 간단.
     */
    return SingleChildScrollView(
        child: Row(
            // Row top 시작 지점이 같도록 지정해주는 옵션
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                groupBox.length,
                (index) => Expanded(
                    child: Column(
                        children: List.generate(
                            groupBox[index].length,
                            (innerIdx) => Container(
                                  height: Get.width *
                                      0.33 *
                                      groupBox[index][innerIdx],
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    color: Colors.primaries[Random()
                                        .nextInt(Colors.primaries.length)],
                                  ),
                                  child: CachedNetworkImage(
                                      imageUrl:
                                          'https://images.theconversation.com/files/443350/original/file-20220131-15-1ndq1m6.jpg?ixlib=rb-1.1.0&rect=0%2C0%2C3354%2C2464&q=45&auto=format&w=926&fit=clip',
                                      fit: BoxFit.cover),
                                ))))).toList()
            // children: [
            //   // 하나의 column 이 열을 구성하고, 열 영역을 세개 모아서 하나의 그리드뷰처럼 사용.
            //   Expanded(
            //       child: Column(
            //     // 하나의 영역이 두 개 칸 만큼의 높이를 차지한다면, 하나의 긴 영역처럼 보일 수 있다.
            //     children: [
            //       Container(height: 280, color: Colors.red),
            //       Container(height: 140, color: Colors.blue)
            //     ],
            //   )),
            //   Expanded(
            //       child: Column(
            //     children: [
            //       Container(height: 140, color: Colors.blue),
            //       Container(height: 140, color: Colors.green),
            //       Container(height: 140, color: Colors.yellow)
            //     ],
            //   )),
            //   Expanded(
            //       child: Column(
            //     children: [
            //       Container(
            //         height: 140,
            //         color: Colors.grey,
            //       ),
            //       Container(height: 140, color: Colors.blue),
            //       Container(
            //         height: 140,
            //         color: Colors.grey,
            //       ),
            //     ],
            //   )),
            // ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    /* 
    Scaffold 자체의 appBar 영역을 쓰지 않고, column 에 넣는 이유?
    슬라이드 할 때 appBar 부분 (검색 영역)이 사라지도록 만들기 위함. 그냥 Scaffold appBar 사용하면 화면 상단 고정!
    */

    return Scaffold(
      // 상단 상태표시줄, 밑으로 쓸어올리는 bar 영역을 벗어나지 않도록 안전하게 지켜주는 역할
      body: SafeArea(
        child: Column(
          children: [_appbar(), Expanded(child: _body())],
        ),
      ),
    );
  }
}
