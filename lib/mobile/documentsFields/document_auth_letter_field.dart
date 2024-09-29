library registration_pkg;

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class MAuthForm extends ConsumerWidget {
  // Widgets

  // Libraries
  final color_constants;

  // Controllers
  final TextEditingController authCtrlr;

  // Booleans
  final isAuthVerified;
  final isAuthViewable;
  final isAuthToPost;

  const MAuthForm({
    super.key,

    // Widgets

    // Libraries
    required this.color_constants,

    // Controllers
    required this.authCtrlr,

    // Boleans
    required this.isAuthVerified,
    required this.isAuthViewable,
    required this.isAuthToPost,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // read data
    return Expanded(
      child: SizedBox(
        child: TextFormField(
          controller: authCtrlr,
          obscureText: false,
          readOnly: true,

          // validation
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please prvoide Authorization Letter ';
            }

            return null;
          },

          // Decorations
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: color_constants?.mainText,
                fontSize: 12,
              ),
          decoration: InputDecoration(
            fillColor: isAuthVerified == false
                ? color_constants?.mainFieldColor
                : const Color(0xFFCCCCCC),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            hintText: "Authorization Letter ",
            hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: color_constants?.subText,
                  fontSize: 12,
                ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // View Icon
                  InkWell(
                    onTap: isAuthViewable == true
                        ? () async {
                            // Check if Authorization Letter  is to post
                            if (isAuthToPost == true) {
                              showDocImageDialog(
                                  context, screenSize, ref, authImgToPost);
                            }
                            // Check if Authorization Letter is already posted
                            else if (isAuthAlreadyPosted == true) {
                              showDocImageGettedDialog(
                                context,
                                screenSize,
                                ref,
                                auth.data!.fileName,
                              );
                            }
                            // Check if Authorization Letter  is to upload
                            else if (isAuthToUpload == true) {
                              showDocImageDialog(
                                  context, screenSize, ref, authImgToPatch);
                            } else {
                              showDocImageGettedDialog(
                                context,
                                screenSize,
                                ref,
                                auth.data!.fileName,
                              );
                            }
                          }
                        : null,
                    child: Text(
                      'View',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: isAuthViewable == true
                                ? color_constants.primary
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                    ),
                  ),

                  // Divider
                  Container(
                    height: 30,
                    width: 1,
                    color: color_constants.mainText,
                    margin: const EdgeInsets.only(left: 10, right: 8),
                  ),

                  // Clear / Gallery icon
                  InkWell(
                    onTap: isAuthVerified == false
                        ? () async {
                            // Check if Authorization Letter  is to post
                            if (isAuthToPost == true) {
                              selectAuthFile();
                            }
                            // Check if Authorizataion Letter is alreadyh posted
                            else if (isAuthAlreadyPosted == true) {
                              // set text to empty
                              authCtrlr.clear();

                              // set upload to true
                              ref
                                  .read(isDocuAuthToUploadProvider.notifier)
                                  .isValue(true);

                              // set viewable to false
                              ref
                                  .read(isDocuAuthViewableProvider.notifier)
                                  .isValue(false);

                              // set is already posted to false
                              ref
                                  .read(
                                      isDocuAuthAlreadyPostedProvider.notifier)
                                  .isValue(false);
                            }
                            // Check if Authorization Letter  is to upload
                            else if (isAuthToUpload == false) {
                              // set text to empty
                              authCtrlr.clear();

                              // set upload to true
                              ref
                                  .read(isDocuAuthToUploadProvider.notifier)
                                  .isValue(true);

                              // set viewable to false
                              ref
                                  .read(isDocuAuthViewableProvider.notifier)
                                  .isValue(false);
                            } else {
                              selectAuthFile();
                            }
                          }
                        : null,
                    child: isAuthToPost == true || isAuthToUpload == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.photo_library,
                              size: 18,
                              color: Colors.blueAccent.withOpacity(0.9),
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.close,
                              size: 18,
                              color: color_constants.mainText,
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
}
