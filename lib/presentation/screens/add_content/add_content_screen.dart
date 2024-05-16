import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upt_training/presentation/navigation/navigators/bottom_navigator.dart';
import 'package:upt_training/presentation/widgets/buttons/primary_button.dart';
import 'package:upt_training/ui_kit/app_color.dart';
import 'package:upt_training/ui_kit/app_text_style.dart';
import 'package:video_player/video_player.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';

@RoutePage()
class AddContentScreen extends StatefulWidget {
  const AddContentScreen({super.key});

  @override
  State<AddContentScreen> createState() => _AddContentScreenState();
}

class _AddContentScreenState extends State<AddContentScreen> {
  TextEditingController captionController = TextEditingController();
  late VideoPlayerController videoController;
  XFile? image;
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.action == AuthAction.createPost) {
          image = null;
          video = null;
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
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColor.secondary.withOpacity(0.10),
                  ),
                  child: image != null || video != null
                      ? Stack(
                          children: [
                            if (image != null)
                              Positioned.fill(
                                child: Image.file(
                                  File(image!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            if (video != null)
                              Positioned.fill(
                                child: VideoPlayer(videoController),
                              ),
                            if (video != null)
                              Positioned(
                                top: 0,
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    if (videoController.value.isPlaying) {
                                      videoController.pause();
                                      setState(() {});
                                    } else {
                                      if (videoController.value.isCompleted) {
                                        videoController.initialize();
                                      }
                                      videoController.play();
                                      setState(() {});
                                    }
                                  },
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    reverseDuration: const Duration(milliseconds: 300),
                                    child: videoController.value.isPlaying && !videoController.value.isCompleted
                                        ? const Icon(
                                            Icons.pause_rounded,
                                            size: 60,
                                            color: AppColor.primary,
                                          )
                                        : const Icon(
                                            Icons.play_arrow_rounded,
                                            size: 60,
                                            color: AppColor.primary,
                                          ),
                                  ),
                                ),
                              ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                onPressed: () {
                                  image = null;
                                  video = null;
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.close_rounded,
                                  color: AppColor.primary,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Column(
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
                                width: 150,
                                height: 40,
                                child: Center(
                                  child: PrimaryButton(
                                    onPressed: () async {
                                      //TODO
                                      video = await ImagePicker().pickVideo(source: ImageSource.gallery);
                                      videoController = VideoPlayerController.file(File(video?.path ?? ''))
                                        ..initialize().then((_) {
                                          setState(() {});
                                        });
                                      videoController.addListener(() {
                                        if (videoController.value.isCompleted) {
                                          setState(() {});
                                        }
                                      });
                                    },
                                    child: Text(
                                      'Select Video',
                                      style: AppTextStyle.s14w500White(context),
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
                                      image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                      setState(() {});
                                    },
                                    child: Text(
                                      'Select Image',
                                      style: AppTextStyle.s14w500White(context),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                            createPost(
                                image?.path ?? video?.path ?? '',
                                image != null
                                    ? 'image'
                                    : video != null
                                        ? 'video'
                                        : '',
                                captionController.text);
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

  createPost(String media, String mediaType, String caption) {
    context.read<AuthBloc>().add(AuthEvent.createPost(media, mediaType, caption));
  }
}
