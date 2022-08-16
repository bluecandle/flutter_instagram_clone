import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/components/avatar_widget.dart';

class UserCard extends StatelessWidget {
  final String userId;
  final String description;

  UserCard({Key? key, required this.userId, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: 180,
      height: 240,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black12)),
      //
      child: Stack(
        children: [
          Positioned(
            left: 15,
            right: 15,
            bottom: 0,
            top: 0,
            child: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  AvatarWidget(
                    thumbPath:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgbHKCvVwI1otDjPaLdJnp3yKzpfYtIaUWMA&usqp=CAU',
                    type: AvatarType.TYPE2,
                    size: 80,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    userId,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    description,
                    style: TextStyle(fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(onPressed: () {}, child: const Text('Follow'))
                ],
              ),
            ),
          ),
          Positioned(
              right: 5,
              top: 5,
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.close,
                  size: 14,
                  color: Colors.grey,
                ),
              )),
        ],
      ),
    );
  }
}
