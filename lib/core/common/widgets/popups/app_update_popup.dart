// import 'dart:developer';
// import 'dart:io';
// import 'dart:ui';
// import 'package:android_intent_plus/android_intent.dart';
// import 'package:caesar_cipher/core/common/widgets/curved_bottom_sheet.dart';
// import 'package:caesar_cipher/core/common/widgets/wide_button_widget.dart';
// import 'package:caesar_cipher/core/constants/app_icons.dart';
// import 'package:caesar_cipher/core/theme/colors.dart';
// import 'package:caesar_cipher/core/theme/text_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:url_launcher/url_launcher.dart';

// class AppUpdatePopUp {
//   //App Update Module
//   checkAppVersion(
//     BuildContext? context,
//     bool mandatoryUpdate,
//     String redirectionUrl,
//   ) {
//     print("UPDATE METHOD ME");

//     if (mandatoryUpdate == true) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _showUpdateBottomSheet(context!, redirectionUrl);
//       });
//     }
//   }

//   // ignore: no_leading_underscores_for_local_identifiers
//   Future<void> _launchUrl(Uri _url) async {
//     if (!await launchUrl(_url)) {
//       throw Exception('Could not launch $_url');
//     }
//   }

//   void _showUpdateBottomSheet(BuildContext context, String redirectionUrl) {
//     showModalBottomSheet(
//       context: context,
//       isDismissible: false,
//       enableDrag: false,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (BuildContext context) {
//         return PopScope(
//           canPop: false,
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),

//             child: ClipPath(
//               clipper: WaveClipper(),
//               child: Container(
//                 // height: height,
//                 color: AppColors.kColorWhite0,
//                 padding: EdgeInsets.only(
//                   left: 20.w,
//                   // right: 20.w,
//                   top: 40, // Increased top padding to account for wave
//                   // bottom: 10,
//                 ),
//                 child: Container(
//                   padding: EdgeInsets.fromLTRB(0, 0, 20.h, 0),
//                   decoration: BoxDecoration(
//                     color: AppColors.kColorPrimaryBg,

//                     // border: Border(top: BorderSide(color: Color(0x26EAEAEA))),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Center(
//                         child: Container(
//                           width: 68.h,
//                           height: 5.h,
//                           decoration: BoxDecoration(
//                             color: AppColors.kTextWhite25,
//                             borderRadius: BorderRadius.circular(100),
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: 20.h),
//                       Row(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.all(12.r),
//                             decoration: BoxDecoration(
//                               color: AppColors.kColorPrimaryBg,
//                               borderRadius: BorderRadius.circular(200),
//                               border: Border.all(color: Color(0x26EAEAEA)),
//                             ),
//                             height: 48.h,
//                             width: 48.h,
//                             child: SvgPicture.asset(
//                               AppIcons.rocketSettIc,
//                               height: 24.h,
//                               width: 24.h,
//                             ),
//                           ),
//                           SizedBox(width: 14.w),
//                           Text(
//                             'Update available',
//                             style: kTextStyleDMSans600.copyWith(
//                               fontSize: 20.sp,
//                               color: AppColors.kColorPrimaryText,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 20.h),
//                       Text(
//                         'A new version is ready! Update now for the latest features and improvements.',
//                         style: kTextStyleDMSans400.copyWith(
//                           fontSize: 16.sp,
//                           color: AppColors.kColorPrimaryText,
//                         ),
//                       ),
//                       SizedBox(height: 30.h),
//                       WideButtonWidget(
//                         title: 'Update Now',
//                         borderColor: AppColors.kColorWideButtonBorder,
//                         backgroundColor: AppColors.kColorPrimary,
//                         onTap: () async {
//                           log("redirectionUrl = $redirectionUrl");
//                           if (Platform.isAndroid) {
//                             final AndroidIntent intent = AndroidIntent(
//                               action: 'action_view',
//                               data: redirectionUrl,
//                             );
//                             await intent.launch();
//                           } else if (Platform.isIOS) {
//                             final Uri url = Uri.parse(redirectionUrl);
//                             await _launchUrl(url);
//                           }
//                         },
//                         textColor: AppColors.kColorPrimaryText,
//                       ),
//                       SizedBox(height: 15.h),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
