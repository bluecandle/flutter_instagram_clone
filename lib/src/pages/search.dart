// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  Widget _appbar() {
    return Row(children: [
      Expanded(
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
      const Padding(
        padding: EdgeInsets.all(10.0),
        child: Icon(Icons.location_pin),
      )
    ]);
  }

  Widget _body(){
    /* 
    특정 부분에는 두 칸을 차지하고, 나머지는 한 칸을 채워주는 형태의 gridview 를 만든다!
    그냥 한 칸 한 칸 동일하다면 gridview 쓰면 간단.
     *
    return SingleChildScrollView(
      child:
    )
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
          children: [
            _appbar(),
            Expanded(child:_body())            
          ],
        ),
      ),
    );
  }
}
