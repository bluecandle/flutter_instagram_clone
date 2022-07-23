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

## 강의 3
[링크](https://www.youtube.com/watch?v=IWdHaU2NMu0&list=PLgRxBCVPaZ_1iBe1v3-ZSSzHGdQo7AZPq&index=3)