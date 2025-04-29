
import 'package:flutter/cupertino.dart';

double getExpandedHeight(BuildContext context) {
  // Get the physical size of the device
  Size screenSize = MediaQuery.of(context).size;

  // Adjust expanded height based on device type
  if (screenSize.width < 600 && screenSize.height < 600) {
    return 0.55; // Small screen devices
  } else if (screenSize.width < 800 && screenSize.height < 800) {
    return 0.40; // Medium screen devices //Emulator
  } else if (screenSize.width < 900 && screenSize.height < 900) {
    return 0.40; // Medium screen devices
  } else {
    return 0.40; // Large screen devices
  }
}