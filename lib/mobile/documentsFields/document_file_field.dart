library registration_pkg;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MFileForm extends ConsumerWidget {
  // Name File
  final String widgetName;

  // Widgets
  final Future<void> Function(BuildContext, Size, WidgetRef, File?)
      showDocImageDialog;

  final Future<void> Function(BuildContext, Size, WidgetRef, String?)
      showDocImageGettedDialog;

  // Data
  final file;

  // Libraries
  final Color colorMaintext;
  final Color colorMainFieldColor;
  final Color colorSubtext;
  final Color colorPrimary;

  // Controllers
  final TextEditingController fileCtrlr;

  // Booleans
  final isFileVerified;
  final isFileViewable;
  final isFileToPost;
  final isFileAlreadyPosted;
  final isFileToUpload;

  // Variables
  final Size screenSize;

  // Providers
  final void Function(bool) isDocuFileToUploadProvider;
  final void Function(bool) isDocuFileViewableProvider;
  final void Function(bool) isDocuFileAlreadyPostedProvider;

  // Path file
  final File? fileImgToPost;
  final File? fileImgToPatch;

  // Function
  final Future<void> Function() selectFile;
  const MFileForm({
    super.key,
    // Name File
    required this.widgetName,
    // Widgets
    required this.showDocImageDialog,
    required this.showDocImageGettedDialog,

    // Data
    required this.file,
    // Libraries
    required this.colorMaintext,
    required this.colorMainFieldColor,
    required this.colorSubtext,
    required this.colorPrimary,
    // Controllers
    required this.fileCtrlr,

    // Boleans
    required this.isFileVerified,
    required this.isFileViewable,
    required this.isFileToPost,
    required this.isFileAlreadyPosted,
    required this.isFileToUpload,

    // Variables
    required this.screenSize,

    // Providers
    required this.isDocuFileToUploadProvider,
    required this.isDocuFileViewableProvider,
    required this.isDocuFileAlreadyPostedProvider,
    // Path file
    required this.fileImgToPost,
    required this.fileImgToPatch,
    // Function
    required this.selectFile,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // read data
    return Expanded(
      child: SizedBox(
        child: TextFormField(
          controller: fileCtrlr,
          obscureText: false,
          readOnly: true,

          // validation
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please prvoide ${widgetName} ';
            }

            return null;
          },

          // Decorations
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: colorMaintext,
                fontSize: 12,
              ),
          decoration: InputDecoration(
            fillColor: isFileVerified == false
                ? colorMainFieldColor
                : const Color(0xFFCCCCCC),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            hintText: "${widgetName} ",
            hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: colorSubtext,
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
                    onTap: isFileViewable == true
                        ? () async {
                            // Check if File  is to post
                            if (isFileToPost == true) {
                              showDocImageDialog(
                                  context, screenSize, ref, fileImgToPost);
                            }
                            // Check if File is already posted
                            else if (isFileAlreadyPosted == true) {
                              showDocImageGettedDialog(
                                context,
                                screenSize,
                                ref,
                                file.data!.fileName,
                              );
                            }
                            // Check if File  is to upload
                            else if (isFileToUpload == true) {
                              showDocImageDialog(
                                  context, screenSize, ref, fileImgToPatch);
                            } else {
                              showDocImageGettedDialog(
                                context,
                                screenSize,
                                ref,
                                file.data!.fileName,
                              );
                            }
                          }
                        : null,
                    child: Text(
                      'View',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: isFileViewable == true
                                ? colorPrimary
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
                    color: colorMaintext,
                    margin: const EdgeInsets.only(left: 10, right: 8),
                  ),

                  // Clear / Gallery icon
                  InkWell(
                    onTap: isFileVerified == false
                        ? () async {
                            // Check if File  is to post
                            if (isFileToPost == true) {
                              selectFile();
                            }
                            // Check if File is alreadyh posted
                            else if (isFileAlreadyPosted == true) {
                              // set text to empty
                              fileCtrlr.clear();

                              // set upload to true
                              isDocuFileToUploadProvider(true);

                              // set viewable to false
                              isDocuFileViewableProvider(false);

                              // set is already posted to false
                              isDocuFileAlreadyPostedProvider(false);
                            }
                            // Check if File  is to upload
                            else if (isFileToUpload == false) {
                              // set text to empty
                              fileCtrlr.clear();

                              // set upload to true
                              isDocuFileToUploadProvider(true);

                              // set viewable to false
                              isDocuFileViewableProvider(false);
                            } else {
                              selectFile();
                            }
                          }
                        : null,
                    child: isFileToPost == true || isFileToUpload == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.photo_library,
                              size: 18,
                              color: Colors.blueAccent.withOpacity(0.9),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.close,
                              size: 18,
                              color: colorMaintext,
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
