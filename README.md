# 플러터 인스타 클론 프로젝트

## 강의 2 BottomNavigation + History
[링크](https://www.youtube.com/watch?v=CoKWB5gYosI&list=PLgRxBCVPaZ_1iBe1v3-ZSSzHGdQo7AZPq&index=2)

- 프로젝트 생성 옵션 오호!

```dart
flutter create --org com.instaclone --platforms android,ios flutter_clone_inst
agram
```

- 디버거 사이드바에서 중단점 부분 설정
- Uncaught Exception 옵션 체크 해제해주면, 에러 발생 부분 찾아가주는 기능 없어짐.
    - 근데 나는 그냥 있는게 편해서 놔둠.
- 생성자 앞에 const 를 붙이려면, 모든 값이 final 로 선언되어야 한다.
- [https://dart.dev/tools/diagnostic-messages?utm_source=dartdev&utm_medium=redir&utm_id=diagcode&utm_content=const_constructor_with_non_final_field#const_constructor_with_non_final_field](https://dart.dev/tools/diagnostic-messages?utm_source=dartdev&utm_medium=redir&utm_id=diagcode&utm_content=const_constructor_with_non_final_field#const_constructor_with_non_final_field)
- BottomNavigationBar > BottomNavigationBarItem 이런 구조로 위젯 구성.
    - 이런거 보면, 아는 사람 입장에서는 정말 위젯만으로 편하게 앱 빠르게 만들 수 있다는 말이 무슨 말인지 알거같음! 근데, 모르는 사람 입장에서는 이게 뭐지…? 이런 느낌!

- 오... list 의 마지막 값을 이렇게 조회할 수 있군
    - `var index = bottomHistory.last;`
- 스타일을 입혀야 하기 때문에 Material 이라는 위젯을 먼저 감싼다.
    - popup widget 만드는 중…
- [https://dart-lang.github.io/linter/lints/sort_child_properties_last.html](https://dart-lang.github.io/linter/lints/sort_child_properties_last.html)
    - 이거 계속 뜨네;
    - // ignore: sort_child_properties_last 이런식으로 무시 가능
- 위젯 쉽게 래핑하기
    - Wrap with Column 처럼 자주 쓰이는 위젯들은 자동으로 추천해주기도 함.
    - 근데, `ClipRRect` 같이 잘 쓰이지 않는데 한 번 쓰려고 하는 애들은 widget 으로 감싸기 해서 자리 만든 다음에, 그 자리에 쓰고싶은거 넣어주면 됨.
    
- 참고로 저 전구는 `cmd + .` 하면 열림.
- 여백을 넣기 위한 위젯
```dart
const SizedBox(height: 7),
```

## 강의 3 홈화면 UI
[링크](https://www.youtube.com/watch?v=IWdHaU2NMu0&list=PLgRxBCVPaZ_1iBe1v3-ZSSzHGdQo7AZPq&index=3)

- 화면 UI 만들기 중심.
- crossAxisAlignment > How the children should be placed along the cross axis in a flex layout.
- expandable_text
    - 유용한 패키지! (접기 가능한 텍스트 영역)
- GestureDetector
    
    ```dart
    GestureDetector(
        onTap: () {},
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(IconsPath.directMessage, width: 50)),
      )
    ```
    
    - 제스처 감지하고 싶은 영역을 GestureDetector 로 감싸고, onTap 등의 eventListener 함수에 원하는 동작을 집어넣는 패턴인듯.

## 강의 4 검색 UI 크기가 다른 이미지 gridview?
[링크](https://youtu.be/s5CblO_hsf8)

- gridview 인데, 두 가지 칸을 동시에 차지하는 구역을 어떻게 만들 것인가?
- search 영역 누르면 화면 전환되는 부분도 구현.
- bottom navigation 이 살아있는 상태임 > **nested routing** > search 영역 안에서 별도의 routing 이 존재하는 것!
- quiver lib
- List.generate -> map 함수랑 같은 기능으로 보임.

## 강의 5 중첩 라우팅 관리
[링크](https://www.youtube.com/watch?v=zJBWAGnUgK4&list=PLgRxBCVPaZ_1iBe1v3-ZSSzHGdQo7AZPq&index=5)

- Getx + Navigator

- UI 구성할때, 어떤 부분에서 빈 공간을 많이 차지하고 있는지 확인하고 싶다??
    - 의심되는 부분을 Container widget 으로 감싼 후에, 색깔을 빨간색같은 눈에 띄는 색으로 변경해서 차지하는 영역이 어떤지 확인하면 도움이 된다.
- appBar
    - leading
        - 뒤로가기 버튼처럼, 앞에 붙는 무언가 넣을 때 사용.
    - titleSpacing: 0,
        - 타이틀 영역에 뭔가 빈 공간이 많은 것 같다 싶을 때 사용해보자.
- this 키워드를 사용하기 위해서 TickerProviderStateMixin 를 넣으면 된다!
- TabBar 에서 하나의 탭마다 터치할 수 있는 공간이 보이는 것과 다르게 좁은 경우가 있음 → 패딩을 부여해서 해결할 수 있음!
- Scaffold 에서 appBar 를 사용하면, 이미 상단 공간을 appBar 가 고정으로 차지하기 때문에, Body 에서 SafeArea 위젯을 사용할 필요가 없다!
- TabBarController , TabBarView 는 한 쌍으로 쓰이는 경우가 많겠구나
    - Tab 이 눌리는 상태를 TabBarView 에 자동으로 전달해주는 뭐 그런 역할.
- Search 상세 페이지에서도 bottom navigation 을 유지 해보자 (GetX 사용하지 않고!)
    - GetX 사용하는 방법도 있다고는 하는데, 버그있는듯?
    - bottom nav controller 에서 구현했던 willPopAction 함수의 활용
        - 검색 페이지가 편재 페이지일때, pop 할 페이지가 있다? (검색 페이지의 route history 가 존재한다 > 그리고 이건 Navigator + Navigator GlobalKey 에 의해 관리됨) > willPopAction 함수 다른 로직 타지 않고 화면 이동만 진행.
        - 검색 페이지가 편재 페이지일때, pop 할 페이지가 없다? (검색 페이지의 route history 존재 x ) > willPopAction 함수의 다른 로직 타고, 화면 이동도 진행.

## 강의 6 업로드 화면 구성
[https://www.youtube.com/watch?v=nHo6DozCG_g&list=PLgRxBCVPaZ_1iBe1v3-ZSSzHGdQo7AZPq&index=6](https://www.youtube.com/watch?v=nHo6DozCG_g&list=PLgRxBCVPaZ_1iBe1v3-ZSSzHGdQo7AZPq&index=6)

- 그리드뷰 생성 코드 (with builder, SliverGridDelegateWithFixedCrossAxisCount)

```dart
return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1),
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return Container(color: Colors.red);
        });
```

- GridView 도 스크롤이 기본적으로 지원됨, 근데 GridView 를 SingleChildScrollView 안에다가 사용하다보니까, 스크롤이 충돌이 발생할 수 있음.
    - 그리드뷰가 스크롤을 지원하지 않는 방식으로 전환하면 해결할 수 있음.
        - `physics: const NeverScrollableScrollPhysics(),`
        - `shrinkWrap: true,`

## 강의 7 업로드 화면 기능 개발
https://www.youtube.com/watch?v=1gLukLy2LJ0&list=PLgRxBCVPaZ_1iBe1v3-ZSSzHGdQo7AZPq&index=7

- PhotoManager package
    - 예외 발생 : *PlatformException (PlatformException(STORAGE_NOT_LEGACY, Use `requestLegacyExternalStorage` when your project is targeting above Android Q., null, null))* 에러
    - 해결 : AndroidManifest.xml 파일에 application 레벨에 `android:requestLegacyExternalStorage="true”` 지정해주면 됨.
    
    ```xml
    <application
    	~~~
    	~~~
    	android:requestLegacyExternalStorage="true”
    ```
    
- builder 함수를 매개변수로 지정하여 같은 _photoWidet 함수를 호출하지만 조금 다른 결과물이 나오도록 만듦.
- state 업데이트를 할 때마다 화면 전체가 깜빡거리는 (업데이트 되는 것처럼 보이는) 현상은 처리하지 않고 넘어감.
- `showModalBottomSheet`: 화면 아래에서 modal 밀려 올라오는 위젯
- 상단에 드래그가 가능하다는 의미를 나타내는 형태를 이렇게 구현 가능.
    
    ```dart
    Center(
        child: Container(
          margin: const EdgeInsets.only(top: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black54,
          ),
          width: 40,
          height: 4,
        ),
      )
    ```
    

```dart
// showModalBottomSheet 에서
// 화면 전체를 꽉 채우지만, 화면 상단을 벗어나지는 않는 정도로 화면을 두기 위한 옵션 설정 요령
constraints: BoxConstraints(
maxHeight: MediaQuery.of(context).size.height -
MediaQuery.of(context).padding.top),
```
## 강의 8 활동 페이지 화면 UI
https://www.youtube.com/watch?v=y6SgDMFg-Yw&list=PLgRxBCVPaZ_1iBe1v3-ZSSzHGdQo7AZPq&index=8