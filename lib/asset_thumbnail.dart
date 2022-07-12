import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/cubit/image_cubit.dart';
import 'package:image/cubit/image_cubit.dart';
import 'package:image/image_screen.dart';
import 'package:image/video_screen.dart';
import 'package:photo_manager/photo_manager.dart';

class AssetThumbnail extends StatelessWidget {
  final AssetEntity? asset;
  GlobalKey? keyForBack;

  AssetThumbnail({required this.asset, required this.keyForBack});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImageCubit, ImageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ImageCubit cubit = ImageCubit().get(context);
        return FutureBuilder<File?>(
          future: asset!.file,
          builder: (context, snapshot) {
            File? fileImage = snapshot.data;

            if (fileImage == null) {
              return Container(
                color: Colors.amber,
              );
              // Center(
              //   child: CircularProgressIndicator(),
              // );
            }

            return InkWell(
              onTap: () {
                cubit.getCurrentImage(newImage: fileImage);
                Scrollable.ensureVisible(
                  keyForBack!.currentContext!,
                  duration: Duration(milliseconds: 300),
                );
              },
              child: cubit.currentImage!.path == fileImage.path
                  ? Image.file(
                      fileImage,
                      fit: BoxFit.cover,
                      color: Colors.white.withOpacity(0.5),
                      colorBlendMode: BlendMode.xor,
                    )
                  : Image.file(
                      fileImage,
                      fit: BoxFit.cover,
                    ),
            );

            // return Image.memory(bytes, fit: BoxFit.cover);
          },
        );
      },
    );
  }
}
