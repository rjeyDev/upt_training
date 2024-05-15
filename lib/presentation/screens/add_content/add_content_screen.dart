import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upt_training/presentation/navigation/navigators/bottom_navigator.dart';
import 'package:upt_training/presentation/widgets/buttons/primary_button.dart';
import 'package:upt_training/ui_kit/app_color.dart';
import 'package:upt_training/ui_kit/app_text_style.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';

@RoutePage()
class AddContentScreen extends StatefulWidget {
  const AddContentScreen({super.key});

  @override
  State<AddContentScreen> createState() => _AddContentScreenState();
}

class _AddContentScreenState extends State<AddContentScreen> {
  TextEditingController captionController = TextEditingController();
  XFile? file;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.action == AuthAction.createPost) {
          file = null;
          captionController.clear();
          tabsRouter.setActiveIndex(2);
          setState(() {});
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Create Post',
              style: AppTextStyle.s18w600Black(context),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select image or video',
                  style: AppTextStyle.s14w500Black(context),
                ),
                const SizedBox(height: 5),
                Container(
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColor.secondary.withOpacity(0.10),
                    image: file != null
                        ? DecorationImage(
                            image: FileImage(
                              File(file!.path),
                            ),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  alignment: file == null ? Alignment.center : Alignment.topRight,
                  child: file != null
                      ? IconButton(
                          onPressed: () {
                            file = null;
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.close_rounded,
                            color: AppColor.primary,
                          ),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Choose Image/Video or take one\nto create a post',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 200,
                              height: 40,
                              child: Center(
                                child: PrimaryButton(
                                  onPressed: () async {
                                    file = await ImagePicker().pickMedia();
                                    setState(() {});
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.image_outlined,
                                        color: AppColor.white,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Choose from Gallery',
                                        style: AppTextStyle.s14w500White(context),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: 150,
                              height: 40,
                              child: Center(
                                child: PrimaryButton(
                                  onPressed: () async {
                                    file = await ImagePicker().pickImage(source: ImageSource.camera);
                                    setState(() {});
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.camera_alt_outlined,
                                        color: AppColor.white,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Use Camera',
                                        style: AppTextStyle.s14w500White(context),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Caption',
                        style: AppTextStyle.s14w500Black(context),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.secondary.withOpacity(0.03),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextFormField(
                          maxLines: 4,
                          controller: captionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: AppColor.primary),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 40,
                        child: PrimaryButton(
                          onPressed: () {
                            createPost(file?.path ?? '', captionController.text);
                          },
                          child: Text(
                            'Create',
                            style: AppTextStyle.s14w500White(context),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  createPost(String media, String caption) {
    context.read<AuthBloc>().add(AuthEvent.createPost(media, caption));
  }
}
