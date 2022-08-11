import 'dart:typed_data';

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
  var imageList = <AssetEntity>[];

  String headerTitle = '';
  AssetEntity? selectedImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPhotos();
  }

  void _loadPhotos() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      albums = await PhotoManager.getAssetPathList(
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

  Future<void> _pagingPhotos() async {
    var photos = await albums.first.getAssetListPaged(page: 0, size: 30);
    imageList.addAll(photos);

    selectedImage = imageList.first;
  }

  // 매번 setState 안에 업데이트 내용 넣기 번거로워서 update 함수 만들어서 사용.
  void update() => setState((() {}));

  /* 선택된 이미지 프리뷰로 보이도록 하는 영역. */
  Widget _imagePreview() {
    // width, height 같게 추출해서 정사각형 형태 만들기
    double width = MediaQuery.of(context).size.width;
    return Container(
        // Get 사용하지 않기 위해서 변경
        // width: Get.width,
        // height: Get.width,
        width: width,
        height: width,
        color: Colors.grey,
        child: selectedImage != null
            ? _photoWidget(selectedImage!, width.toInt(), builder: (data) {
                return Image.memory(data, fit: BoxFit.cover);
              })
            : Container());
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
                  style: const TextStyle(color: Colors.black, fontSize: 18)),
              const Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                  color: const Color(0xff808080),
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

  Widget _imageSelectList() {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1),
        itemCount: imageList.length,
        itemBuilder: (BuildContext context, int index) {
          // 근데 여기서 data 로 들어가는 내용이 뭐지??? 실제 함수가 실행되는 _photoWidget 에서 주입되는건가?
          return _photoWidget(imageList[index], 200, builder: (data) {
            // 선택된 이미지가 selectedImage 에
            return Opacity(
                opacity: imageList[index] == selectedImage ? 0.3 : 1,
                child: Image.memory(data, fit: BoxFit.cover));
          });
        });
  }

  /*
  AssetEntity 객체에서 파일 추출하기
  근데, 여기서 객체 변수 selectedImage 와 argument 로 들어오는 asset 의 값이 같으면, 선택된 이미지로 보여주면 되겠지!
  */
  Widget _photoWidget(AssetEntity asset, int size,
      // Widget 을 return 하는 함수가 매개변수로 선언됨.
      {required Widget Function(Uint8List) builder}) {
    // future 로 감싸져 있기 때문에, future builder 사용
    return FutureBuilder(
        future: asset.thumbnailDataWithSize(ThumbnailSize(size, size)),
        builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
          if (snapshot.hasData) {
            return builder(snapshot.data!);
          } else {
            return Container();
          }
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
        children: [_imagePreview(), _header(), _imageSelectList()],
      )),
    );
  }
}
