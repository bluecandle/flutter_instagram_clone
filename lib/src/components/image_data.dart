import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageData extends StatelessWidget {
  String icon;
  final double width;
  // ImageData 앞에 const 를 붙이려면, 생성자로 생성하는 값이 모두 final 이어야 한다.
  // const, final 둘 다 고정된 값. 근데, const 는 빌드 타임에 값을 알고 있어야 함. 근데 final 은 몰라도 된다. 그거랑 관련이 있을듯?
  // 일단 const 를 붙이면 고정된 값이라는 의미잖아? 근데 non-final 필드가 있으면, 값이 바뀔 수도 있다는 의미잖아! > 생성자 값이 고정되어 있지 않다!
  // 근데, 모든 field 가 final 이면, 어쨌든 고정이라는 의미잖아. 그래서 생성자가 고정 값인 const 가 될 수 있는거고. final이 아니라 const 인 이유는
  // 생성자는 빌드 타임에 값을 알고 있어야 하는 존재니까 그런거고. 대충 그런거 아닐까?
  // https://dart.dev/tools/diagnostic-messages?utm_source=dartdev&utm_medium=redir&utm_id=diagcode&utm_content=const_constructor_with_non_final_field#const_constructor_with_non_final_field

  ImageData(this.icon, {Key? key, this.width = 55}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(icon,
        // mediaQuery 를 GetX 를 통해서도 사용할 수 있다!
        // width: width / MediaQuery.of(context).devicePixelRatio);
        width: width / Get.mediaQuery.devicePixelRatio);
  }
}

class IconsPath {
  // svg 파일로 하면 색깔 변경해주면 되는건데, 이미지 파일 쓰고 있으니, 토글 형태로 이렇게 사용
  static String get homeOff => 'assets/images/bottom_nav_home_off_icon.jpg';
  static String get homeOn => 'assets/images/bottom_nav_home_on_icon.jpg';
  static String get searchOff => 'assets/images/bottom_nav_search_off_icon.jpg';
  static String get searchOn => 'assets/images/bottom_nav_search_on_icon.jpg';
  static String get uploadIcon => 'assets/images/bottom_nav_upload_icon.jpg';
  static String get activeOff => 'assets/images/bottom_nav_active_off_icon.jpg';
  static String get activeOn => 'assets/images/bottom_nav_active_on_icon.jpg';
  static String get logo => 'assets/images/logo.jpg';
  static String get directMessage => 'assets/images/direct_msg_icon.jpg';
  static String get plusIcon => 'assets/images/plus_icon.png';
  static String get postMoreIcon => 'assets/images/more_icon.jpg';
  static String get likeOffIcon => 'assets/images/like_off_icon.jpg';
  static String get likeOnIcon => 'assets/images/like_on_icon.jpg';
  static String get replyIcon => 'assets/images/reply_icon.jpg';
  static String get bookMarkOffIcon => 'assets/images/book_mark_off_icon.jpg';
  static String get bookMarkOnIcon => 'assets/images/book_mark_on_icon.jpg';
  static String get backBtnIcon => 'assets/images/back_icon.jpg';
  static String get menuIcon => 'assets/images/menu_icon.jpg';
  static String get addFriend => 'assets/images/add_friend_icon.jpg';
  static String get gridViewOff => 'assets/images/grid_view_off_icon.jpg';
  static String get gridViewOn => 'assets/images/grid_view_on_icon.jpg';
  static String get myTagImageOff => 'assets/images/my_tag_image_off_icon.jpg';
  static String get myTagImageOn => 'assets/images/my_tag_image_on_icon.jpg';
  static String get nextImage => 'assets/images/upload_next_icon.jpg';
  static String get closeImage => 'assets/images/close_icon.jpg';
  static String get imageSelectIcon => 'assets/images/image_select_icon.jpg';
  static String get cameraIcon => 'assets/images/camera_icon.jpg';
  static String get uploadComplete => 'assets/images/upload_complete_icon.jpg';
  static String get mypageBottomSheet01 =>
      'assets/images/mypage_bottom_sheet_01.jpg';
  static String get mypageBottomSheet02 =>
      'assets/images/mypage_bottom_sheet_02.jpg';
  static String get mypageBottomSheet03 =>
      'assets/images/mypage_bottom_sheet_03.jpg';
  static String get mypageBottomSheet04 =>
      'assets/images/mypage_bottom_sheet_04.jpg';
  static String get mypageBottomSheet05 =>
      'assets/images/mypage_bottom_sheet_05.jpg';
  static String get mypageBottomSheetSetting01 =>
      'assets/images/mypage_bottom_sheet_setting_01.jpg';
  static String get mypageBottomSheetSetting02 =>
      'assets/images/mypage_bottom_sheet_setting_02.jpg';
  static String get mypageBottomSheetSetting03 =>
      'assets/images/mypage_bottom_sheet_setting_03.jpg';
  static String get mypageBottomSheetSetting04 =>
      'assets/images/mypage_bottom_sheet_setting_04.jpg';
  static String get mypageBottomSheetSetting05 =>
      'assets/images/mypage_bottom_sheet_setting_05.jpg';
  static String get mypageBottomSheetSetting06 =>
      'assets/images/mypage_bottom_sheet_setting_06.jpg';
  static String get mypageBottomSheetSetting07 =>
      'assets/images/mypage_bottom_sheet_setting_07.jpg';
}
