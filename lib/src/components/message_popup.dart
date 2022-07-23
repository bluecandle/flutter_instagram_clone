import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagePopup extends StatelessWidget {
  final String title;
  final String messsage;
  final Function() okCallback;
  final Function()? cancelCallback;

  const MessagePopup(
      {Key? key,
      required this.title,
      required this.messsage,
      required this.okCallback,
      this.cancelCallback})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // 스타일을 입혀야 하기 때문에 Material 이라는 위젯을 먼저 감싼다.
    return Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 좀 둥글둥글한 시스템창을 만들기 위한 디자인 요소
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                // Get 에 width 값이 있다!
                width: Get.width * 0.7,
                child: Column(
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.black)),
                    Text(messsage,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black)),
                    // 여백을 넣기 위한 위젯!
                    const SizedBox(height: 7),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      ElevatedButton(
                          onPressed: okCallback, child: const Text('확인')),
                      const SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: cancelCallback,
                          child: const Text('취소'),
                          style:
                              ElevatedButton.styleFrom(primary: Colors.grey)),
                    ])
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
