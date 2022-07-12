import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/cubit/image_cubit.dart';
import 'package:image/gallery.dart';
import 'package:photo_manager/photo_manager.dart';

class Open extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            //! permitted Image
            final permitted = await PhotoManager.requestPermissionExtend();
            if (!permitted.isAuth) return;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Gallery(),
              ),
            );
          },
          child: Text("Open Gallery"),
        ),
      ),
    );
  }
}
