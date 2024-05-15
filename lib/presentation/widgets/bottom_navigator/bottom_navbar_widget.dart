import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../ui_kit/app_color.dart';

class BottomNavbarWidget extends StatefulWidget {
  final TabsRouter router;

  const BottomNavbarWidget({super.key, required this.router});
  @override
  State<StatefulWidget> createState() => _BottomNavbarWidgetState();
}

class _BottomNavbarWidgetState extends State<BottomNavbarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withOpacity(0.03),
            offset: const Offset(0, -2),
            blurRadius: 5,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: widget.router.activeIndex == 0 ? AppColor.primary : Colors.transparent,
                    radius: 2,
                  ),
                  const SizedBox(height: 3),
                  GestureDetector(
                    onTap: () {
                      widget.router.setActiveIndex(0);
                    },
                    child: SvgPicture.asset(
                      'assets/icons/home.svg',
                      height: 26,
                      color: widget.router.activeIndex == 0 ? AppColor.primary : AppColor.black,
                    ),
                  ),
                  const SizedBox(height: 7),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: widget.router.activeIndex == 1 ? AppColor.primary : Colors.transparent,
                    radius: 2,
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      widget.router.setActiveIndex(1);
                    },
                    child: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: widget.router.activeIndex == 1 ? AppColor.primary : AppColor.black,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.add_rounded,
                        size: 20,
                        color: widget.router.activeIndex == 1 ? AppColor.primary : AppColor.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 9),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: widget.router.activeIndex == 2 ? AppColor.primary : Colors.transparent,
                    radius: 2,
                  ),
                  const SizedBox(height: 3),
                  GestureDetector(
                    onTap: () {
                      widget.router.setActiveIndex(2);
                    },
                    child: Container(
                      color: AppColor.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/profile.svg',
                            height: 26,
                            color: widget.router.activeIndex == 2 ? AppColor.primary : Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 7),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
