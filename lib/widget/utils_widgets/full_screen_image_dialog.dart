import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

void showFullscreenImageDialog(String imageUrl, {bool isNetworkImage = true}) {
  buildImage() {
    if (isNetworkImage) {
      return CachedNetworkImageProvider(
        imageUrl,
      );
    } else {
      return FileImage(
        File(imageUrl),
      );
    }
  }

  Get.dialog(
    GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        color: Colors.white.withOpacity(0.0),
        child: Material(
          child: Center(
            child: Stack(
              children: [
                Center(
                  child: ClipRect(
                    child: PhotoView(
                      imageProvider: buildImage() as ImageProvider<Object>,
                      backgroundDecoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 2,
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        100,
                      ),
                      color: Colors.black.withOpacity(
                        0.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: InkWell(
                        child: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
