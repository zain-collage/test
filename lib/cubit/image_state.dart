part of 'image_cubit.dart';

@immutable
abstract class ImageStates {}

class ImageInitialState extends ImageStates {}

//! Get Albubs
class ImageGetAlbumsInitialState extends ImageStates {}

class ImageGetAlbumsSucssesState extends ImageStates {}

class ImageGetAlbumsErorrState extends ImageStates {}

// ! Get All Imges From Albums
class ImageGetAllImagesFromAlbumInitialState extends ImageStates {}

class ImageGetAllImagesFromAlbumSucssesState extends ImageStates {}

class ImageGetAllImagesFromAlbumErorrState extends ImageStates {}

// ! Get Current Image
class ImageGetCurrentImageInitialState extends ImageStates {}

class ImageGetCurrentImageSucssesState extends ImageStates {}

class ImageGetcurrentImageErorrState extends ImageStates {}

// ! Get Current Drop Down Value
class ImageCurrentdropdownValueInitialState extends ImageStates {}

class ImageCurrentdropdownValueState extends ImageStates {}
