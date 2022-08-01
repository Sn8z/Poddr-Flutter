import 'package:universal_platform/universal_platform.dart';

String getUserAgent() {
  String uAgent = "Poddr";

  if (UniversalPlatform.isAndroid) {
    uAgent = '$uAgent / Android';
  } else if (UniversalPlatform.isIOS) {
    uAgent = '$uAgent / iOS';
  } else if (UniversalPlatform.isLinux) {
    uAgent = '$uAgent / Linux';
  } else if (UniversalPlatform.isMacOS) {
    uAgent = '$uAgent / MacOS';
  } else if (UniversalPlatform.isWindows) {
    uAgent = '$uAgent / Windows';
  } else if (UniversalPlatform.isWeb) {
    uAgent = '$uAgent / Web';
  }

  return uAgent;
}
