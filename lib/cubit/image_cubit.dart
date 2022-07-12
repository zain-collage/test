import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageStates> {
  ImageCubit() : super(ImageInitialState());
  ImageCubit get(context) => BlocProvider.of(context);

  List<AssetPathEntity>? albums = [];
  List<String>? nameAlbums = [];
  String? currentdropdownValue;
  int? currentIndexAlbum = 0;
  AssetPathEntity? currentAlbum;
  List<AssetEntity>? imageFromAlbum = [];
  File? currentImage;
  void getAlbums() {
    emit(ImageGetAlbumsInitialState());

    PhotoManager.getAssetPathList().then((value) {
      // !get All Albums
      albums = value;
      // !get DropDoun first value
      currentdropdownValue = albums!.first.name;
      // !Get Album index
      // currentIndexAlbum = nameAlbums!.indexOf(currentdropdownValue!) + 1;
      // !get List All Albums Name
      for (int i = 0; i < albums!.length; i++) {
        if (nameAlbums!.contains(albums![i].name)) {
          nameAlbums!.add("$i${albums![i].name}");
        } else {
          nameAlbums!.add(albums![i].name);
        }
      }

      // !Get Current Album
      currentAlbum = albums![currentIndexAlbum!];
      // ! Get All Images from Album
      getAllImagesFromAlbum();
      emit(ImageGetAlbumsSucssesState());
    }).catchError((e) {
      emit(ImageGetAlbumsErorrState());
    });
  }

  void getdropdownValue(String? albumName) {
    emit(ImageCurrentdropdownValueInitialState());

    currentdropdownValue = albumName!;
    currentIndexAlbum = nameAlbums!.indexOf(albumName);
    currentAlbum = albums![currentIndexAlbum!];
    getAllImagesFromAlbum();
    emit(ImageCurrentdropdownValueState());
  }

  void getAllImagesFromAlbum() {
    emit(ImageGetAllImagesFromAlbumInitialState());
    imageFromAlbum = [];
    currentAlbum!
        .getAssetListRange(
      start: 0,
      end: 1000000,
    )
        .then((value) {
      for (var element in value) {
        if (element.type.name == AssetType.image.name) {
          imageFromAlbum!.add(element);
        }
      }
      // imageFromAlbum = value;
      getCurrentImage();
      emit(ImageGetAllImagesFromAlbumSucssesState());
    }).catchError((onError) {
      emit(ImageGetAllImagesFromAlbumErorrState());
    });
  }

  void getCurrentImage({File? newImage}) {
    emit(ImageGetCurrentImageInitialState());
    if (newImage != null) {
      currentImage = newImage;
      emit(ImageGetCurrentImageSucssesState());
    } else {
      // TODO: imageFromAlbum is Null

      if (imageFromAlbum!.isEmpty) {
        print('ssssssssssssssssssssssss');
        currentImage = null;
        emit(ImageGetCurrentImageSucssesState());
      } else {
        imageFromAlbum!.first.file.then((file) {
          currentImage = file;
          emit(ImageGetCurrentImageSucssesState());
        }).catchError((e) {
          emit(ImageGetcurrentImageErorrState());
        });
      }
    }
  }
}
