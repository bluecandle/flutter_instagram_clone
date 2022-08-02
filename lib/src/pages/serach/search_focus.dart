import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/components/image_data.dart';
import 'package:flutter_clone_instagram/src/controller/bottom_nav_controller.dart';
import 'package:get/get.dart';

class SearchFocus extends StatefulWidget {
  const SearchFocus({
    Key? key,
  }) : super(key: key);

  @override
  _SearchFocusState createState() => _SearchFocusState();
}

// this 키워드를 사용하기 위해서 TickerProviderStateMixin 를 넣으면 된다!
class _SearchFocusState extends State<SearchFocus>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _tabMenuOne(String menu) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Text(
        menu,
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ),
    );
  }

  PreferredSizeWidget _tabMenu() {
    return PreferredSize(
      // ignore: sort_child_properties_last, sized_box_for_whitespace
      child: Container(
          // appBar 와 같은 높이를 차지하고 싶다.
          height: AppBar().preferredSize.height,
          // 전체 너비를 차지하고싶다.
          width: Size.infinite.width,
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xffe4e4e4)))),
          child: TabBar(
              controller: tabController,
              indicatorColor: Colors.black,
              tabs: [
                _tabMenuOne('인기'),
                _tabMenuOne('계정'),
                _tabMenuOne('오디오'),
                _tabMenuOne('태그'),
                _tabMenuOne('장소')
              ])),
      // preferredSize: Size.fromHeight(50),
      // 앱 바 만큼의 사이즈를 차지하겠다.
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
    );
  }

  Widget _body() {
    return Container(
      child: TabBarView(
        controller: tabController,
        // TabBar 에서 tabs 항목에 입력한 것과 index 가 일치된다.
        children: const [
          Center(child: Text('인기페이지')),
          Center(child: Text('계정페이지')),
          Center(child: Text('오디오페이지')),
          Center(child: Text('태그페이지')),
          Center(child: Text('장소페이지')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            leading: GestureDetector(
                // onTap: Get.back,
                // Navigator 를 사용하여 라우팅 > 뒤로가기 눌렀을 때 상태 관리하던 willPopAction 함수를 여기서 사용.
                onTap: BottomNavController.to.willPopAction,
                // BottomNavController 를 static 으로 선언해줘서, 아래 코드처럼 Get.find 이렇게 안해도됨.
                // Get.find<BottomNavController>().willPopAction();
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ImageData(IconsPath.backBtnIcon),
                )),
            titleSpacing: 0,
            title: Container(
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0xffefefef)),
              child: const TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "검색",
                      contentPadding:
                          EdgeInsets.only(left: 15, top: 7, bottom: 7),
                      isDense: true)),
            ),
            // height 가 지정된 위젯을 넣어줘야한다!
            bottom: _tabMenu()),
        body: _body());
  }
}
