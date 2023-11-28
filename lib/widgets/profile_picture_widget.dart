import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rpm/Views/Utils/app_colors.dart';
import 'package:rpm/controllers/profile_controller.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/widgets/network_image_widget.dart';

class ProfilePictureWidget extends StatelessWidget {
  final dynamic snapshot;
  final String userProfileUid;
  const ProfilePictureWidget({
    super.key,
    required this.snapshot,
    required this.userProfileUid,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(
        builder: (context, provider, child) => SizedBox(
              width: 84,
              height: 76,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          // shape: BoxShape.circle,
                          border: Border.all(
                            color: snapshot.data!.docs[0]['profileImage']
                                        .toString() ==
                                    ""
                                ? AppColors.textFieldBorderColor
                                : Colors.transparent,
                          )),
                      child: provider.image == null
                          ? snapshot.data!.docs[0]['profileImage'].toString() ==
                                  ""
                              ? Icon(
                                  Icons.person,
                                  size: 35,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                )
                              : NetworkImageWidget(
                                  borderRadius: 50,
                                  imageUrl: snapshot
                                      .data!.docs[0]['profileImage']
                                      .toString())
                          : Image.file(File(provider.image!.path).absolute),
                    ),
                  ),
                  userProfileUid == SessionController().userId
                      ? Positioned(
                          bottom: 5,
                          right: 5,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                              child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const AlertDialog(
                                              content: PickImageDailog());
                                        });
                                  },
                                  child: Icon(Icons.add_circle_outline))),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ));
  }
}

class PickImageDailog extends StatelessWidget {
  const PickImageDailog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          ListTile(
            onTap: () {
              ProfileController().pickImage(context, ImageSource.camera);
              Navigator.pop(context);
            },
            leading: Icon(
              Icons.camera,
              color: AppColors.primaryText,
            ),
            title: const Text('Camera'),
          ),
          ListTile(
            onTap: () {
              ProfileController().pickImage(context, ImageSource.gallery);
              Navigator.pop(context);
            },
            leading: Icon(
              Icons.image,
              color: AppColors.primaryText,
            ),
            title: const Text('Gallery'),
          )
        ],
      ),
    );
  }
}
