import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // WillPopScope : back button controller 을 위해 사용
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(),
        bottomNavigationBar: BottomNavigationBar(
          icon:Image.asset()
          items: [

          ],
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
