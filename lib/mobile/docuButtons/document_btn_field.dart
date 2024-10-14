library registration_pkg;

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MFileButton extends ConsumerWidget {
  // Form key
  final GlobalKey<FormState> formKey;
  // Name File
  final String widgetName;
  final String fileName;
  // Widgets

  // Data
  final file;

  // Libraries
  final Color colorPrimary;

  // Controllers
  final String authCtrlr;
  // Booleans
  final isFileToPost;
  final isFileAlreadyPosted;
  final isFileToUpload;
  final isAuthToPatch;

  // Variables
  final Size screenSize;

  // Providers
  final void Function(bool) isDocuFileToUploadProvider;
  final void Function(bool) isDocuFileAlreadyPostedProvider;
  final void Function(bool) isDocuFileToPostProvider;
  final void Function(bool) isDocuFileToPatchProvider;
  final void Function(String, String, String)
      driverApplicationPatchControllerProvider;
  final void Function(String, String, String)
      driverApplicationPostControllerProvider;
  final void Function(dynamic) invalidateProvider;
  final void Function(dynamic) getDocumentFileProvider;
  final void Function(dynamic) fetchDocumentFileProvider;

  // Path file
  // Path String
  final String authStringToPatch;
  final String authStringToPost;

  // Dialogs
  final Future<void> Function(BuildContext) showUtolLoadingDialog;
  final Future<void> Function(BuildContext, Size, WidgetRef, String)
      showDocUpdateSuccess;
  final Future<void> Function(BuildContext, Size, WidgetRef, String)
      showDocSavedSuccess;
  // ========================================== BUTTON ===================================== //
  const MFileButton({
    super.key,

    // Form Key
    required this.formKey,
    // Name File
    required this.widgetName,
    required this.fileName,

    // Data
    required this.file,
    // Libraries
    required this.colorPrimary,
    // Controllers
    required this.authCtrlr,
    // Boleans
    required this.isFileToPost,
    required this.isFileAlreadyPosted,
    required this.isFileToUpload,
    required this.isAuthToPatch,

    // Variables
    required this.screenSize,

    // Providers
    required this.isDocuFileToUploadProvider,
    required this.isDocuFileAlreadyPostedProvider,
    required this.isDocuFileToPostProvider,
    required this.isDocuFileToPatchProvider,
    required this.driverApplicationPatchControllerProvider,
    required this.driverApplicationPostControllerProvider,
    required this.invalidateProvider,
    required this.getDocumentFileProvider,
    required this.fetchDocumentFileProvider,
    // Path String
    required this.authStringToPatch,
    required this.authStringToPost,
    // Dialogs
    required this.showUtolLoadingDialog,
    required this.showDocUpdateSuccess,
    required this.showDocSavedSuccess,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // read data
    return // Save Button
        SizedBox(
      height: 48,
      width: 48,
      child: InkWell(
        onTap: isFileToUpload == true
            ? () async {
                if (formKey.currentState!.validate()) {
                  showUtolLoadingDialog(context);

                  // Check if File is already posted
                  if (isFileAlreadyPosted == true) {
                    driverApplicationPatchControllerProvider(
                      authStringToPatch,
                      authCtrlr,
                      fileName,
                    );
                    if (Navigator.of(context).mounted) {
                      Navigator.of(context).pop(true);
                      showDocUpdateSuccess(
                          context, screenSize, ref, widgetName);
                    }
                  }

                  // Check if Authorization Letter  is to post
                  if (isFileToPost == true) {
                    driverApplicationPostControllerProvider(
                      authStringToPost,
                      authCtrlr,
                      fileName,
                    );

                    // set is to post to false
                    isDocuFileToPostProvider(false);

                    // set is already posted to true
                    isDocuFileAlreadyPostedProvider(true);

                    // set to upload to false
                    isDocuFileToUploadProvider(false);

                    // set istopatch to true
                    isDocuFileToPatchProvider(true);

                    // fetch the document
                    invalidateProvider(getDocumentFileProvider);
                    fetchDocumentFileProvider(fileName);
                    if (Navigator.of(context).mounted) {
                      Navigator.of(context).pop(true);
                      showDocSavedSuccess(
                        context,
                        screenSize,
                        ref,
                        widgetName,
                      );
                    }
                  }

                  // Check if Authorization Letter is to patch
                  if (isAuthToPatch == true) {
                    driverApplicationPatchControllerProvider(
                      authStringToPatch,
                      authCtrlr,
                      fileName,
                    );

                    // set to upload to false
                    isDocuFileToUploadProvider(false);

                    // fetch the document
                    invalidateProvider(getDocumentFileProvider);
                    fetchDocumentFileProvider(fileName);
                    if (Navigator.of(context).mounted) {
                      Navigator.of(context).pop(true);
                      showDocUpdateSuccess(
                          context, screenSize, ref, widgetName);
                    }
                  }
                }
              }
            : null,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: isFileToUpload == true ? colorPrimary : Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.upload,
            size: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
