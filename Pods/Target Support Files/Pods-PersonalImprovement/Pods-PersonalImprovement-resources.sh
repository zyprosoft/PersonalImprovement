#!/bin/sh
set -e

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

XCASSET_FILES=()

case "${TARGETED_DEVICE_FAMILY}" in
  1,2)
    TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
    ;;
  1)
    TARGET_DEVICE_ARGS="--target-device iphone"
    ;;
  2)
    TARGET_DEVICE_ARGS="--target-device ipad"
    ;;
  *)
    TARGET_DEVICE_ARGS="--target-device mac"
    ;;
esac

realpath() {
  DIRECTORY="$(cd "${1%/*}" && pwd)"
  FILENAME="${1##*/}"
  echo "$DIRECTORY/$FILENAME"
}

install_resource()
{
  if [[ "$1" = /* ]] ; then
    RESOURCE_PATH="$1"
  else
    RESOURCE_PATH="${PODS_ROOT}/$1"
  fi
  if [[ ! -e "$RESOURCE_PATH" ]] ; then
    cat << EOM
error: Resource "$RESOURCE_PATH" not found. Run 'pod install' to update the copy resources script.
EOM
    exit 1
  fi
  case $RESOURCE_PATH in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}"
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.xib)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}"
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.framework)
      echo "mkdir -p ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      mkdir -p "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync -av $RESOURCE_PATH ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -av "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH"`.mom\""
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd\""
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm\""
      xcrun mapc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ABSOLUTE_XCASSET_FILE=$(realpath "$RESOURCE_PATH")
      XCASSET_FILES+=("$ABSOLUTE_XCASSET_FILE")
      ;;
    *)
      echo "$RESOURCE_PATH"
      echo "$RESOURCE_PATH" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_resource "AMap3DMap/MAMapKit.framework/Versions/2.5.0.002286d.60159/Resources/AMap.bundle"
  install_resource "AVOSCloud/AVOS/AVOSCloud/AVOSCloud_Art.inc"
  install_resource "ChatKit/ChatKit/Class/Resources/BarButtonIcon.bundle"
  install_resource "ChatKit/ChatKit/Class/Resources/ChatKeyboard.bundle"
  install_resource "ChatKit/ChatKit/Class/Resources/DateTools.bundle"
  install_resource "ChatKit/ChatKit/Class/Resources/Emoji.bundle"
  install_resource "ChatKit/ChatKit/Class/Resources/LCCKPBLocalizations.bundle"
  install_resource "ChatKit/ChatKit/Class/Resources/LCCKPhotoBrowser.bundle"
  install_resource "ChatKit/ChatKit/Class/Resources/MBProgressHUD.bundle"
  install_resource "ChatKit/ChatKit/Class/Resources/MessageBubble.bundle"
  install_resource "ChatKit/ChatKit/Class/Resources/Other.bundle"
  install_resource "ChatKit/ChatKit/Class/Resources/Placeholder.bundle"
  install_resource "ChatKit/ChatKit/Class/Resources/VoiceMessageSource.bundle"
  install_resource "ChatKit/ChatKit/Class/Module/ContactList/View/LCCKContactCell.xib"
  install_resource "DateTools/DateTools/DateTools.bundle"
  install_resource "FTFontSelector/Assets/FTFontSelector.bundle"
  install_resource "InfColorPicker/InfColorPicker/InfColorPickerView.xib"
  install_resource "MJRefresh/MJRefresh/MJRefresh.bundle"
  install_resource "$PODS_CONFIGURATION_BUILD_DIR/MWPhotoBrowser/MWPhotoBrowser.bundle"
  install_resource "SSKeychain/Support/SSKeychain.bundle"
  install_resource "SVProgressHUD/SVProgressHUD/SVProgressHUD.bundle"
  install_resource "SVWebViewController/SVWebViewController/SVWebViewController.bundle/SVWebViewControllerBack.png"
  install_resource "SVWebViewController/SVWebViewController/SVWebViewController.bundle/SVWebViewControllerBack@2x.png"
  install_resource "SVWebViewController/SVWebViewController/SVWebViewController.bundle/SVWebViewControllerNext.png"
  install_resource "SVWebViewController/SVWebViewController/SVWebViewController.bundle/SVWebViewControllerNext@2x.png"
  install_resource "SVWebViewController/SVWebViewController/UIActivities/Chrome/SVWebViewControllerActivityChrome-iPad.png"
  install_resource "SVWebViewController/SVWebViewController/UIActivities/Chrome/SVWebViewControllerActivityChrome-iPad@2x.png"
  install_resource "SVWebViewController/SVWebViewController/UIActivities/Chrome/SVWebViewControllerActivityChrome@2x.png"
  install_resource "SVWebViewController/SVWebViewController/UIActivities/Safari/SVWebViewControllerActivitySafari-iPad.png"
  install_resource "SVWebViewController/SVWebViewController/UIActivities/Safari/SVWebViewControllerActivitySafari-iPad@2x.png"
  install_resource "SVWebViewController/SVWebViewController/UIActivities/Safari/SVWebViewControllerActivitySafari@2x.png"
  install_resource "SVWebViewController/SVWebViewController/SVWebViewController.bundle"
  install_resource "TGCameraViewController/TGCameraViewController/Classes/View/Base.lproj/TGCameraAuthorizationViewController.xib"
  install_resource "TGCameraViewController/TGCameraViewController/Classes/View/Base.lproj/TGCameraViewController.xib"
  install_resource "TGCameraViewController/TGCameraViewController/Classes/View/Base.lproj/TGPhotoViewController.xib"
  install_resource "TGCameraViewController/TGCameraViewController/TGCameraViewController.xcassets"
  install_resource "TGCameraViewController/TGCameraViewController/Resources/TGCameraViewController.bundle"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundError.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundError@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundErrorIcon.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundErrorIcon@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundMessage.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundMessage@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundSuccess.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundSuccess@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundSuccessIcon.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundSuccessIcon@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundWarning.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundWarning@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundWarningIcon.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundWarningIcon@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationButtonBackground.png"
  install_resource "TSMessages/Pod/Assets/NotificationButtonBackground@2x.png"
  install_resource "TSMessages/Pod/Assets/TSMessagesDefaultDesign.json"
  install_resource "TWMessageBarManager/Classes/Icons/icon-error.png"
  install_resource "TWMessageBarManager/Classes/Icons/icon-error@2x.png"
  install_resource "TWMessageBarManager/Classes/Icons/icon-info.png"
  install_resource "TWMessageBarManager/Classes/Icons/icon-info@2x.png"
  install_resource "TWMessageBarManager/Classes/Icons/icon-success.png"
  install_resource "TWMessageBarManager/Classes/Icons/icon-success@2x.png"
  install_resource "TapkuLibrary/src/TapkuLibrary.bundle"
  install_resource "VKFoundation/Assets/VKFoundation_themes.plist"
  install_resource "VKFoundation/Assets/VKPickerButton_bg.png"
  install_resource "VKFoundation/Assets/VKPickerButton_bg@2x.png"
  install_resource "VKFoundation/Assets/VKPickerButton_cross.png"
  install_resource "VKFoundation/Assets/VKPickerButton_cross@2x.png"
  install_resource "VKFoundation/Assets/VKScrubber_max.png"
  install_resource "VKFoundation/Assets/VKScrubber_max@2x.png"
  install_resource "VKFoundation/Assets/VKScrubber_min.png"
  install_resource "VKFoundation/Assets/VKScrubber_min@2x.png"
  install_resource "VKFoundation/Assets/VKScrubber_thumb.png"
  install_resource "VKFoundation/Assets/VKScrubber_thumb@2x.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_close.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_close@2x.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_cross.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_cross@2x.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_next.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_next@2x.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_pause.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_pause@2x.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_pause_big.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_pause_big@2x.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_play.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_play@2x.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_play_big.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_play_big@2x.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_rewind.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_rewind@2x.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_zoom_in.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_zoom_in@2x.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_zoom_out.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_zoom_out@2x.png"
  install_resource "VKVideoPlayer/Classes/ios/VKVideoPlayerView.xib"
  install_resource "VKVideoPlayer/Classes/ios/VKVideoPlayerViewController~ipad.xib"
  install_resource "VKVideoPlayer/Classes/ios/VKVideoPlayerViewController~iphone.xib"
  install_resource "XHImageViewer/Source/Resources/1_1280x800-1.jpeg"
  install_resource "XHImageViewer/Source/Resources/1_1280x800.jpeg"
  install_resource "XHImageViewer/Source/Resources/4_1366x768.jpeg"
  install_resource "XHImageViewer/Source/Resources/5_1280x800.jpeg"
  install_resource "XHImageViewer/Source/Resources/placeholder.jpeg"
  install_resource "XLForm/XLForm/XLForm.bundle"
  install_resource "objectiveflickr/BridgeSupport"
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_resource "AMap3DMap/MAMapKit.framework/Versions/2.5.0.002286d.60159/Resources/AMap.bundle"
  install_resource "AVOSCloud/AVOS/AVOSCloud/AVOSCloud_Art.inc"
  install_resource "ChatKit/ChatKit/Class/Resources/BarButtonIcon.bundle"
  install_resource "ChatKit/ChatKit/Class/Resources/ChatKeyboard.bundle"
  install_resource "ChatKit/ChatKit/Class/Resources/DateTools.bundle"
  install_resource "ChatKit/ChatKit/Class/Resources/Emoji.bundle"
  install_resource "ChatKit/ChatKit/Class/Resources/LCCKPBLocalizations.bundle"
  install_resource "ChatKit/ChatKit/Class/Resources/LCCKPhotoBrowser.bundle"
  install_resource "ChatKit/ChatKit/Class/Resources/MBProgressHUD.bundle"
  install_resource "ChatKit/ChatKit/Class/Resources/MessageBubble.bundle"
  install_resource "ChatKit/ChatKit/Class/Resources/Other.bundle"
  install_resource "ChatKit/ChatKit/Class/Resources/Placeholder.bundle"
  install_resource "ChatKit/ChatKit/Class/Resources/VoiceMessageSource.bundle"
  install_resource "ChatKit/ChatKit/Class/Module/ContactList/View/LCCKContactCell.xib"
  install_resource "DateTools/DateTools/DateTools.bundle"
  install_resource "FTFontSelector/Assets/FTFontSelector.bundle"
  install_resource "InfColorPicker/InfColorPicker/InfColorPickerView.xib"
  install_resource "MJRefresh/MJRefresh/MJRefresh.bundle"
  install_resource "$PODS_CONFIGURATION_BUILD_DIR/MWPhotoBrowser/MWPhotoBrowser.bundle"
  install_resource "SSKeychain/Support/SSKeychain.bundle"
  install_resource "SVProgressHUD/SVProgressHUD/SVProgressHUD.bundle"
  install_resource "SVWebViewController/SVWebViewController/SVWebViewController.bundle/SVWebViewControllerBack.png"
  install_resource "SVWebViewController/SVWebViewController/SVWebViewController.bundle/SVWebViewControllerBack@2x.png"
  install_resource "SVWebViewController/SVWebViewController/SVWebViewController.bundle/SVWebViewControllerNext.png"
  install_resource "SVWebViewController/SVWebViewController/SVWebViewController.bundle/SVWebViewControllerNext@2x.png"
  install_resource "SVWebViewController/SVWebViewController/UIActivities/Chrome/SVWebViewControllerActivityChrome-iPad.png"
  install_resource "SVWebViewController/SVWebViewController/UIActivities/Chrome/SVWebViewControllerActivityChrome-iPad@2x.png"
  install_resource "SVWebViewController/SVWebViewController/UIActivities/Chrome/SVWebViewControllerActivityChrome@2x.png"
  install_resource "SVWebViewController/SVWebViewController/UIActivities/Safari/SVWebViewControllerActivitySafari-iPad.png"
  install_resource "SVWebViewController/SVWebViewController/UIActivities/Safari/SVWebViewControllerActivitySafari-iPad@2x.png"
  install_resource "SVWebViewController/SVWebViewController/UIActivities/Safari/SVWebViewControllerActivitySafari@2x.png"
  install_resource "SVWebViewController/SVWebViewController/SVWebViewController.bundle"
  install_resource "TGCameraViewController/TGCameraViewController/Classes/View/Base.lproj/TGCameraAuthorizationViewController.xib"
  install_resource "TGCameraViewController/TGCameraViewController/Classes/View/Base.lproj/TGCameraViewController.xib"
  install_resource "TGCameraViewController/TGCameraViewController/Classes/View/Base.lproj/TGPhotoViewController.xib"
  install_resource "TGCameraViewController/TGCameraViewController/TGCameraViewController.xcassets"
  install_resource "TGCameraViewController/TGCameraViewController/Resources/TGCameraViewController.bundle"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundError.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundError@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundErrorIcon.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundErrorIcon@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundMessage.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundMessage@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundSuccess.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundSuccess@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundSuccessIcon.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundSuccessIcon@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundWarning.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundWarning@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundWarningIcon.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundWarningIcon@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationButtonBackground.png"
  install_resource "TSMessages/Pod/Assets/NotificationButtonBackground@2x.png"
  install_resource "TSMessages/Pod/Assets/TSMessagesDefaultDesign.json"
  install_resource "TWMessageBarManager/Classes/Icons/icon-error.png"
  install_resource "TWMessageBarManager/Classes/Icons/icon-error@2x.png"
  install_resource "TWMessageBarManager/Classes/Icons/icon-info.png"
  install_resource "TWMessageBarManager/Classes/Icons/icon-info@2x.png"
  install_resource "TWMessageBarManager/Classes/Icons/icon-success.png"
  install_resource "TWMessageBarManager/Classes/Icons/icon-success@2x.png"
  install_resource "TapkuLibrary/src/TapkuLibrary.bundle"
  install_resource "VKFoundation/Assets/VKFoundation_themes.plist"
  install_resource "VKFoundation/Assets/VKPickerButton_bg.png"
  install_resource "VKFoundation/Assets/VKPickerButton_bg@2x.png"
  install_resource "VKFoundation/Assets/VKPickerButton_cross.png"
  install_resource "VKFoundation/Assets/VKPickerButton_cross@2x.png"
  install_resource "VKFoundation/Assets/VKScrubber_max.png"
  install_resource "VKFoundation/Assets/VKScrubber_max@2x.png"
  install_resource "VKFoundation/Assets/VKScrubber_min.png"
  install_resource "VKFoundation/Assets/VKScrubber_min@2x.png"
  install_resource "VKFoundation/Assets/VKScrubber_thumb.png"
  install_resource "VKFoundation/Assets/VKScrubber_thumb@2x.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_close.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_close@2x.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_cross.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_cross@2x.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_next.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_next@2x.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_pause.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_pause@2x.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_pause_big.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_pause_big@2x.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_play.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_play@2x.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_play_big.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_play_big@2x.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_rewind.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_rewind@2x.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_zoom_in.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_zoom_in@2x.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_zoom_out.png"
  install_resource "VKVideoPlayer/Assets/VKVideoPlayer_zoom_out@2x.png"
  install_resource "VKVideoPlayer/Classes/ios/VKVideoPlayerView.xib"
  install_resource "VKVideoPlayer/Classes/ios/VKVideoPlayerViewController~ipad.xib"
  install_resource "VKVideoPlayer/Classes/ios/VKVideoPlayerViewController~iphone.xib"
  install_resource "XHImageViewer/Source/Resources/1_1280x800-1.jpeg"
  install_resource "XHImageViewer/Source/Resources/1_1280x800.jpeg"
  install_resource "XHImageViewer/Source/Resources/4_1366x768.jpeg"
  install_resource "XHImageViewer/Source/Resources/5_1280x800.jpeg"
  install_resource "XHImageViewer/Source/Resources/placeholder.jpeg"
  install_resource "XLForm/XLForm/XLForm.bundle"
  install_resource "objectiveflickr/BridgeSupport"
fi

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]] && [[ "${SKIP_INSTALL}" == "NO" ]]; then
  mkdir -p "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ -n "$XCASSET_FILES" ]
then
  # Find all other xcassets (this unfortunately includes those of path pods and other targets).
  OTHER_XCASSETS=$(find "$PWD" -iname "*.xcassets" -type d)
  while read line; do
    if [[ $line != "`realpath $PODS_ROOT`*" ]]; then
      XCASSET_FILES+=("$line")
    fi
  done <<<"$OTHER_XCASSETS"

  printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
