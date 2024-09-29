library registration_pkg;

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final onPressed;
  final Widget child;
  final style;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: getAuth.when(
        // Loading
        loading: () => buildLoadingSkeleton(),

        // Data
        data: (auth) {
          Future.delayed(Duration.zero, () {
            if (isAuthSetted == false) {
              // Check if there are any existing datas
              if (auth.data?.fileName == null) {
                // Set is Authorization Letter  to post to true
                ref.read(isDocuAuthToPostProvider.notifier).isValue(true);

                // Set is Authorization Letter  to patch and viewable and upload to false
                ref.read(isDocuAuthToPatchProvider.notifier).isValue(false);
                ref.read(isDocuAuthViewableProvider.notifier).isValue(false);
                ref.read(isDocuAuthToUploadProvider.notifier).isValue(false);

                // Set the is setted to true to avoid refreshing values
                ref.read(docuAuthSettedProvider.notifier).isValue(true);
              } else {
                // Set is Authorization Letter  to post false
                ref.read(isDocuAuthToPostProvider.notifier).isValue(false);

                // Set is Authorization Letter  to patch and viewable to true
                ref.read(isDocuAuthToPatchProvider.notifier).isValue(true);
                ref.read(isDocuAuthViewableProvider.notifier).isValue(true);

                // set to upload to false
                ref.read(isDocuAuthToUploadProvider.notifier).isValue(false);

                // Set is verified depending to the value
                ref
                    .read(isDocuAuthVerifiedProvider.notifier)
                    .setValue(auth.data!.isApproved!);

                // Set text field texts
                String url = auth.data!.fileName!;
                Uri uri = Uri.parse(url);
                String fileName = uri.pathSegments.last;
                authCtrlr.setText(fileName);

                // Set the is setted to true to avoid refreshing values
                ref.read(docuAuthSettedProvider.notifier).isValue(true);
              }
            }
          });

          // ============================= UI ============================= //
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' Authorization Letter ',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 12,
                      color: color_constants.mainText,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Row(
                children: [
                  // Field
                  Expanded(
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
                              color: color_constants.mainText,
                              fontSize: 12,
                            ),
                        decoration: InputDecoration(
                          fillColor: isAuthVerified == false
                              ? color_constants.mainFieldColor
                              : const Color(0xFFCCCCCC),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          hintText: "Authorization Letter ",
                          hintStyle:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: color_constants.subText,
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
                                            showDocImageDialog(context,
                                                screenSize, ref, authImgToPost);
                                          }
                                          // Check if Authorization Letter is already posted
                                          else if (isAuthAlreadyPosted ==
                                              true) {
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
                                                context,
                                                screenSize,
                                                ref,
                                                authImgToPatch);
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
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
                                  margin:
                                      const EdgeInsets.only(left: 10, right: 8),
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
                                          else if (isAuthAlreadyPosted ==
                                              true) {
                                            // set text to empty
                                            authCtrlr.clear();

                                            // set upload to true
                                            ref
                                                .read(isDocuAuthToUploadProvider
                                                    .notifier)
                                                .isValue(true);

                                            // set viewable to false
                                            ref
                                                .read(isDocuAuthViewableProvider
                                                    .notifier)
                                                .isValue(false);

                                            // set is already posted to false
                                            ref
                                                .read(
                                                    isDocuAuthAlreadyPostedProvider
                                                        .notifier)
                                                .isValue(false);
                                          }
                                          // Check if Authorization Letter  is to upload
                                          else if (isAuthToUpload == false) {
                                            // set text to empty
                                            authCtrlr.clear();

                                            // set upload to true
                                            ref
                                                .read(isDocuAuthToUploadProvider
                                                    .notifier)
                                                .isValue(true);

                                            // set viewable to false
                                            ref
                                                .read(isDocuAuthViewableProvider
                                                    .notifier)
                                                .isValue(false);
                                          } else {
                                            selectAuthFile();
                                          }
                                        }
                                      : null,
                                  child: isAuthToPost == true ||
                                          isAuthToUpload == true
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(right: 2),
                                          child: Icon(
                                            Icons.photo_library,
                                            size: 18,
                                            color: Colors.blueAccent
                                                .withOpacity(0.9),
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
                  ),

                  const SizedBox(width: 6),

                  // Save Button
                  SizedBox(
                    height: 48,
                    width: 48,
                    child: InkWell(
                      onTap: isAuthToUpload == true
                          ? () async {
                              if (formKey.currentState!.validate()) {
                                showUtolLoadingDialog(context);

                                // Check if Authorization Letter is already posted
                                if (isAuthAlreadyPosted == true) {
                                  await ref
                                      .read(driverApplicationControllerProvider
                                          .notifier)
                                      .patchAuthLetter(
                                        authStringToPatch!,
                                        authCtrlr.text,
                                      );

                                  if (context.mounted) {
                                    context.pop(true);
                                    showDocUpdateSuccess(context, screenSize,
                                        ref, 'authorization letter');
                                  }
                                }

                                // Check if Authorization Letter  is to post
                                if (isAuthToPost == true) {
                                  await ref
                                      .read(driverApplicationControllerProvider
                                          .notifier)
                                      .postAuthLetter(
                                        authStringToPost!,
                                        authCtrlr.text,
                                      );

                                  // set is to post to false
                                  ref
                                      .read(isDocuAuthToPostProvider.notifier)
                                      .isValue(false);

                                  // set is already posted to true
                                  ref
                                      .read(isDocuAuthAlreadyPostedProvider
                                          .notifier)
                                      .isValue(true);

                                  // set to upload to false
                                  ref
                                      .read(isDocuAuthToUploadProvider.notifier)
                                      .isValue(false);

                                  // set istopatch to true
                                  ref
                                      .read(isDocuAuthToPatchProvider.notifier)
                                      .isValue(true);

                                  // fetch the document
                                  ref.invalidate(getDocuAuthImageProvider);
                                  await ref
                                      .read(getDocuAuthImageProvider.notifier)
                                      .fetchAuthImage();

                                  if (context.mounted) {
                                    context.pop(true);
                                    showDocSavedSuccess(context, screenSize,
                                        ref, 'authorization letter');
                                  }
                                }

                                // Check if Authorization Letter is to patch
                                if (isAuthToPatch == true) {
                                  await ref
                                      .read(driverApplicationControllerProvider
                                          .notifier)
                                      .patchAuthLetter(
                                        authStringToPatch!,
                                        authCtrlr.text,
                                      );

                                  // set to upload to false
                                  ref
                                      .read(isDocuAuthToUploadProvider.notifier)
                                      .isValue(false);

                                  // fetch the document
                                  ref.invalidate(getDocuAuthImageProvider);
                                  await ref
                                      .read(getDocuAuthImageProvider.notifier)
                                      .fetchAuthImage();

                                  if (context.mounted) {
                                    context.pop(true);
                                    showDocUpdateSuccess(context, screenSize,
                                        ref, 'authorization letter');
                                  }
                                }
                              }
                            }
                          : null,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: isAuthToUpload == true
                              ? color_constants.primary
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.upload,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // =================================================================================
              //  Display but hide Picture so that the authorization for the link wont expire
              // =================================================================================
              SizedBox(
                height: 0,
                child: auth.data?.fileName != null
                    ? Image.network(
                        auth.data!.fileName!,
                      )
                    : Container(),
              ),
            ],
          );
        },

        // Error
        error: (err, stack) => Text('Error: $err'),
      ),
    );
}
