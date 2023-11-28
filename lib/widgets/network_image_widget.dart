import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rpm/Views/Utils/app_colors.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width, height, borderRadius, iconSize;
  const NetworkImageWidget(
      {Key? key,
      required this.imageUrl,
      this.width = 40,
      this.height = 40,
      this.borderRadius = 18,
      this.iconSize = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: imageUrl == '' || imageUrl == "null"
          ? Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: AppColors.grayText,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                Icons.person_outline,
                size: iconSize,
              ))
          : CachedNetworkImage(
              imageUrl: imageUrl,
              width: width,
              height: height,
              imageBuilder: (context, imageProvider) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: AppColors.grayText,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: LoadingWidget(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: AppColors.grayText,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(
                    Icons.error_outline,
                    size: iconSize,
                  )),
            ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  final double size;

  const LoadingWidget({Key? key, this.size = 36.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: Platform.isIOS
            ? const CupertinoActivityIndicator(
                color: Colors.blue,
              )
            : const CircularProgressIndicator(
                strokeWidth: 2.0,
                color: Colors.blue,
              ),
      ),
    );
  }
}
