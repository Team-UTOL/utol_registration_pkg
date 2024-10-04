# Driver Registration Package

#### **Driver Registration Package** is a package designed to minimize code redundancy in the app and help maintain code cleanliness.


## Usage

#### Copy the url link
![image](https://github.com/user-attachments/assets/7e657147-2ffe-4877-9d0a-adc607d12e01)
##

#### pubsec.yaml
#### Add registration package under dependencies.
````dart

  dependencies:
    flutter:
      sdk: flutter
    # Driver Registration Package
    registration_pkg:
      git: https://github.com/Team-UTOL/utol_registration_pkg.git

````

## Example
  ## Mobile
  Upload Documents UI Fields
  ```dart
  MFileForm(
                      widgetName: "Authorization Letter",
                      showDocImageDialog: showDocImageDialog,
                      showDocImageGettedDialog: showDocImageGettedDialog,
                      file: auth,
                      colorMaintext: color_constants.mainText,
                      colorMainFieldColor: color_constants.mainFieldColor,
                      colorSubtext: color_constants.subText,
                      colorPrimary: color_constants.primary,
                      fileCtrlr: authCtrlr,
                      isFileVerified: isAuthVerified,
                      isFileViewable: isAuthViewable,
                      isFileToPost: isAuthToPost,
                      isFileAlreadyPosted: isAuthAlreadyPosted,
                      isFileToUpload: isAuthToUpload,
                      screenSize: screenSize,
                      isDocuFileToUploadProvider: (value) => ref
                          .read(isDocuAuthToUploadProvider.notifier)
                          .isValue(value),
                      isDocuFileViewableProvider: (value) => ref
                          .read(isDocuAuthViewableProvider.notifier)
                          .isValue(value),
                      isDocuFileAlreadyPostedProvider: (value) => ref
                          .read(isDocuAuthAlreadyPostedProvider.notifier)
                          .isValue(value),
                      fileImgToPost: authImgToPost,
                      fileImgToPatch: authImgToPatch,
                      selectFile: selectAuthFile,
                    ),
  ```
