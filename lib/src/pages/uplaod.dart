import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/components/image_data.dart';
import 'package:photo_manager/photo_manager.dart';

// Getx 사용하지 않고, flutter stateful widget 사용
// Getx 사용하지 않는 프로젝트에서도 모듈처럼 사용할 수 있도록!
class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  var albums = <AssetPathEntity>[];
  String headerTitle = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPhotos();
  }

  void _loadPhotos() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      var albums = await PhotoManager.getAssetPathList(
          type: RequestType.image,
          filterOption: FilterOptionGroup(
              imageOption: const FilterOption(
                  sizeConstraint:
                      SizeConstraint(minHeight: 100, minWidth: 100)),
              orders: [
                // 최신 이미지를 먼저 보도록 (asc: false 니까 desc 로 나와서.)
                const OrderOption(type: OrderOptionType.createDate, asc: false)
              ]));
      _loadData();
    } else {
      // message 권한 요청
    }
  }

  void _loadData() async {
    headerTitle = albums.first.name;
    await _pagingPhotos();
    update();
  }

  Future<void> _pagingPhotos() async{
    await albums.first.getAssetListPaged(page: 0, size: 30)
  }

  // 매번 setState 안에 업데이트 내용 넣기 번거로워서 update 함수 만들어서 사용.
  void update() => setState((() {}));

  Widget _imagePreview() {
    // width, height 같게 추출해서 정사각형 형태 만들기
    double width = MediaQuery.of(context).size.width;
    return Container(
        // Get 사용하지 않기 위해서 변경
        // width: Get.width,
        // height: Get.width,
        width: width,
        height: width,
        color: Colors.grey);
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Text(headerTitle,
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                  color: Color(0xff808080),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  ImageData(IconsPath.imageSelectIcon),
                  const SizedBox(width: 7),
                  const Text('여러 항목 선택',
                      style: TextStyle(color: Colors.white, fontSize: 14))
                ],
              ),
            ),
            const SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff808080),
              ),
              child: ImageData(IconsPath.cameraIcon),
            )
          ],
        )
      ]),
    );
  }

  Widget _imageSelect() {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(IconsPath.closeImage),
            ),
          ),
          title: const Text(
            "New Post",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
          actions: [
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ImageData(
                  IconsPath.nextImage,
                  width: 50,
                ),
              ),
            )
          ]),
      body: SingleChildScrollView(
          child: Column(
        children: [_imagePreview(), _header(), _imageSelect()],
      )),
    );
  }
}
