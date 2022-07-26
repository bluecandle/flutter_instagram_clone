import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/components/image_data.dart';
import 'package:flutter_clone_instagram/src/controller/bottom_nav_controller.dart';
import 'package:flutter_clone_instagram/src/pages/home.dart';
import 'package:get/get.dart';

// 이렇게 지정하면, 해당 클래스 안에서 BottomNavController 에 대해 controller 라는 값으로 접근할 수 있게 됨.
// 이렇게 편하게 쓰는 방법도 있는거 GetX 설명쪽에서 배웠음.
// 근데, 이렇게 쓰더라도 BottomNavController 자체는 인스턴스화 (Get.put) 해줘야함!
// 앱이 실행되는 바로 그 시점에 등록이 되기 때문에, main 에서 initBinding 을 통해 해주면 좋다.
class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // WillPopScope : back button controller 을 위해 사용
    // history 를 추적해서, 적당한 history 가 없는 상황이라면 앱 종료하는 역할. (History 관리하는건 따로 구현.)
    return WillPopScope(
        // ignore: sort_child_properties_last
        child:
            // onTap 에서 BottomNavController 의 changeBottomNav 함수를 통해 BottomNavController pageIndex 값을 변화시키는 중.
            // 그래서, 그거 반영하려면 Obx 로 Scaffold 를 감싸줘야함.
            Obx(() => Scaffold(
                  // backgroundColor: Colors.red,
                  // appBar: AppBar(),
                  // body: Container(),
                  // 여러 페이지 전환을 편하게 하기 위함.
                  body: IndexedStack(
                    // controller.pageIndex 여기까지만 하면 안되고, 꼭 .value 찍어줘야 값이 나온다.
                    index: controller.pageIndex.value,
                    children: [
                      const Home(),
                      Container(child: Center(child: Text('SEARCH'))),
                      Container(child: Center(child: Text('UPLOAD'))),
                      Container(child: Center(child: Text('ACTIVITY'))),
                      Container(child: Center(child: Text('MYPAGE'))),
                    ],
                  ),

                  // BottomNavigationBar > BottomNavigationBarItem 이런 구조로 위젯 구성.
                  bottomNavigationBar: BottomNavigationBar(
                    // active 되었을 때, 네비게이션 아이템이 다른 아이템들과 높이가 맞기 않고 위로 올라가버리는 현상 막기 위한 옵션
                    type: BottomNavigationBarType.fixed,
                    // label 값 안 보여주려고 쓰는 옵션
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    // 현재 활성화된 nav item index
                    currentIndex: controller.pageIndex.value,
                    // 뭔가 이상한 음영 있는거 제거.
                    elevation: 0,
                    // 터치 이벤트
                    // currentIndex 의 변경된 값 관리.
                    onTap: controller.changeBottomNav,
                    // 배경색
                    // backgroundColor: Colors.red,
                    items: [
                      BottomNavigationBarItem(
                          icon: ImageData(IconsPath.homeOff),
                          activeIcon: ImageData(IconsPath.homeOn),
                          label: 'home'),
                      BottomNavigationBarItem(
                          icon: ImageData(IconsPath.searchOff),
                          activeIcon: ImageData(IconsPath.searchOn),
                          label: 'search'),
                      BottomNavigationBarItem(
                          icon: ImageData(IconsPath.uploadIcon),
                          label: 'upload'),
                      BottomNavigationBarItem(
                          icon: ImageData(IconsPath.activeOff),
                          activeIcon: ImageData(IconsPath.activeOn),
                          label: 'active'),
                      BottomNavigationBarItem(
                          icon: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.grey)),
                          label: 'home'),
                    ],
                  ),
                )),
        onWillPop: controller.willPopAction);
  }
}
