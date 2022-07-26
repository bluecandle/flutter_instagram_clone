import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/components/message_popup.dart';
import 'package:flutter_clone_instagram/src/pages/uplaod.dart';
import 'package:get/get.dart';

enum PageName { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE }

/**
 * @note BottomNavigation 동작 전체를 관리.
 */
class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;

  // 스택 구조로 히스토리 구성해보자.
  List<int> bottomHistory = [0];

  // app.dart > Scaffold > BottomNavigationBar > onTap 에서 사용되도록 만들어짐.
  // pageIndex 값을 BottomNavigationBar 에서 currentIndex 로 사용하고 있고, 사용자 동작에 따라 해당 값을 변경시키도록 하는 역할.
  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch (page) {
      // UPLOAD 만 다른 동작이 필요하고, 다른 case 들은 같은 동작이 수행되기 때문에, 아래 구조처럼 하나만 떼어놓고 나머지는 몰아놓는 형태로 구성.
      case PageName.UPLOAD:
        // TODO: Handle this case.
        Get.to(() => Upload());
        break;
      case PageName.HOME:
      case PageName.SEARCH:
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    // hasGesture 값이 false 인 경우
    // 사용자가 back button 을 눌러서 willPopAction 을 호출시킨 경우에는 false 로 넘어옴. 그 경우 잡기.
    // 왜 잡느냐?? 그 때는 history 에 기록을 추가하면 안 되기 때문에, 기껏 willPopAction 함수 안에서 기록 제거해놨는데,
    // 페이지 변경하면서 다시 페이지 기록 추가되면 의미가 없음!
    if (!hasGesture) return;

    // history 중복 추가가 되는 것을 막기 위함. 대신, 하나의 페이지는 한 번의 기록만 남는 형태로 하는 버전
    // 만약 이미 히스토리에 있으면 제거하고, 이후에 다시 추가해주면 됨. 그러면, 스택의 최상위로 다시 올라오는 효과.
    // if (bottomHistory.contains(value)) {
    //   bottomHistory.remove(value);
    // }
    // bottomHistory.add(value);
    // print(bottomHistory);

    // [0,1,3,4] 인 상태에서 [0,1,3,4,0] 이렇게 되도록 하고싶다면
    if (bottomHistory.last != value) {
      bottomHistory.add(value);
      print(bottomHistory);
    }
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1) {
      // 쌓인 기록이 없다 == 여기서 뒤로가기 누르면 앱 끄는거다! (끈다 > true)
      print('exit');
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
                title: "시스템",
                messsage: "종료하시겠습니까?",
                okCallback: () {
                  exit(0);
                },
                cancelCallback: Get.back,
              ));
      return true;
    } else {
      // 쌓인 기록 있다 == 여기서 뒤로가기 누르면 뒤로 간다! (안 끈다 > false)
      print('goto before page');
      // bottomHistory.removeAt(bottomHistory.length - 1);
      bottomHistory.removeLast();

      // 오... list 의 마지막 값을 이렇게 조회할 수 있군
      var index = bottomHistory.last;

      changeBottomNav(index, hasGesture: false);
      print(bottomHistory);
      return false;
    }
  }
}
