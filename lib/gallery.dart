import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/asset_thumbnail.dart';
import 'package:image/cubit/image_cubit.dart';
import 'package:image/main.dart';
import 'package:photo_manager/photo_manager.dart';

class Gallery extends StatelessWidget {
  GlobalKey keyForBack = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageCubit()..getAlbums(),
      child: BlocConsumer<ImageCubit, ImageStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ImageCubit cubit = ImageCubit().get(context);
          return SafeArea(
            child: Scaffold(
              body: NestedScrollView(
                floatHeaderSlivers: true,
                physics: NeverScrollableScrollPhysics(),
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: Colors.white,
                      forceElevated: true,
                      elevation: 0.5,
                      centerTitle: true,
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      title: Text(
                        "Add Post",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      actions: [
                        TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                              Color.fromRGBO(26, 35, 126, 1).withOpacity(0.1),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "NEXT",
                            style: TextStyle(
                              color: Color.fromRGBO(26, 35, 126, 1),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SliverAppBar(
                      // pinned: true,
                      floating: true,

                      // snap: true,
                      key: keyForBack,
                      excludeHeaderSemantics: true,
                      expandedHeight: 295,
                      forceElevated: true,
                      elevation: 0.5,
                      backgroundColor: Colors.white,
                      automaticallyImplyLeading: false,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Padding(
                          padding: EdgeInsets.all(20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: state is ImageGetCurrentImageInitialState ||
                                    state is ImageGetAlbumsSucssesState
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : cubit.currentImage != null
                                    ? Image.file(
                                        cubit.currentImage!,
                                        fit: BoxFit.cover,
                                        width: 329,
                                        height: 295,
                                      )
                                    : SizedBox(
                                        width: 329,
                                        height: 295,
                                        child: Center(
                                          child: Text(
                                              'Oops There are no pictures in this Album'),
                                        ),
                                      ),
                          ),
                        ),
                      ),
                    ),
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: Colors.white,
                      forceElevated: true,
                      elevation: 0.5,
                      automaticallyImplyLeading: false,
                      actions: [
                        IconButton(
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            color: Color.fromRGBO(26, 35, 126, 1),
                          ),
                          onPressed: () {},
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                      titleSpacing: 0,
                      title: Row(
                        children: [
                          SizedBox(width: 10),
                          DropdownButton<String>(
                            value: cubit.currentdropdownValue,
                            items: cubit.nameAlbums!
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              if (state
                                  is! ImageCurrentdropdownValueInitialState)
                                cubit.getdropdownValue(value);
                            },
                          ),
                        ],
                      ),
                    ),
                  ];
                },
                body: Center(
                  child: cubit.imageFromAlbum!.isEmpty
                      ? CircularProgressIndicator()
                      : GridView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          // shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemCount: cubit.imageFromAlbum!.length,
                          itemBuilder: (context, index) {
                            return AssetThumbnail(
                              asset: cubit.imageFromAlbum![index],
                              keyForBack: keyForBack,
                            );
                          },
                        ),
                ),
              ),

              // body:
            ),
          );
        },
      ),
    );
  }
}
