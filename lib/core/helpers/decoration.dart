import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Decoration decoration = Decoration();

class Decoration {
  allBorderRadius(radius) {
    return BorderRadius.all(Radius.circular(radius));
  }

  singleBorderRadius(List selectedSide, radius) {
    List topLR = [1, 2];
    List topLBottomR = [1, 3];
    List bottomLR = [3, 4];
    List topRTopR = [2, 4];
    if (listEquals(selectedSide, topLR) == true) {
      selectedSide = [1, 2, null, null];
    } else if (listEquals(selectedSide, bottomLR) == true) {
      selectedSide = [null, null, 3, 4];
    } else if (listEquals(selectedSide, topLBottomR) == true) {
      selectedSide = [1, null, 3, null];
    } else if (listEquals(selectedSide, topRTopR) == true) {
      selectedSide = [null, 2, null, 4];
    }
    return BorderRadius.only(
      topLeft: Radius.circular(selectedSide[0] != null ? radius : 0),
      topRight: Radius.circular(selectedSide[1] != null ? radius : 0),
      bottomLeft: Radius.circular(selectedSide[2] != null ? radius : 0),
      bottomRight: Radius.circular(selectedSide[3] != null ? radius : 0),
    );
  }
}
