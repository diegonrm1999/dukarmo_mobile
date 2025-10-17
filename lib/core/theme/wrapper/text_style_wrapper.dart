import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/theme/font/font_family.dart';
import 'package:dukarmo_app/core/theme/font/font_size.dart';
import 'package:dukarmo_app/core/theme/font/font_weight.dart';

abstract class TextStyleWrapper {
  static const smMedium = TextStyle(
    fontFamily: FontFamily.fontFamilyDefault,
    fontSize: FontSizes.fontSizeSm,
    fontWeight: FontWeights.fontWeightMedium,
  );
  static const mdMedium = TextStyle(
    fontFamily: FontFamily.fontFamilyDefault,
    fontSize: FontSizes.fontSizeMd,
    fontWeight: FontWeights.fontWeightMedium,
  );
  static const lgMedium = TextStyle(
    fontFamily: FontFamily.fontFamilyDefault,
    fontSize: FontSizes.fontSizeLg,
    fontWeight: FontWeights.fontWeightMedium,
  );
  static const xlMedium = TextStyle(
    fontFamily: FontFamily.fontFamilyDefault,
    fontSize: FontSizes.fontSizeXl,
    fontWeight: FontWeights.fontWeightMedium,
  );
  static const smBold = TextStyle(
    fontFamily: FontFamily.fontFamilyDefault,
    fontSize: FontSizes.fontSizeSm,
    color: Colors.black,
    fontWeight: FontWeights.fontWeightBold,
  );
  static const mdBold = TextStyle(
    fontFamily: FontFamily.fontFamilyDefault,
    fontSize: FontSizes.fontSizeMd,
    fontWeight: FontWeights.fontWeightBold,
    color: Color.fromARGB(255, 31, 31, 31),
  );
  static const mdBoldWhite = TextStyle(
    fontFamily: FontFamily.fontFamilyDefault,
    fontSize: FontSizes.fontSizeMd,
    fontWeight: FontWeights.fontWeightBold,
    color: Colors.white,
  );
  static const lgBold = TextStyle(
    fontFamily: FontFamily.fontFamilyDefault,
    fontSize: FontSizes.fontSizeLg,
    color: Colors.black,
    fontWeight: FontWeights.fontWeightBold,
  );
  static const lgWhiteBold = TextStyle(
    fontFamily: FontFamily.fontFamilyDefault,
    fontSize: FontSizes.fontSizeLg,
    color: Colors.white,
    fontWeight: FontWeights.fontWeightBold,
  );
  static const xlBold = TextStyle(
    fontFamily: FontFamily.fontFamilyDefault,
    fontSize: FontSizes.fontSizeXl,
    fontWeight: FontWeights.fontWeightBold,
  );
  static const smRegular = TextStyle(
    fontFamily: FontFamily.fontFamilyDefault,
    fontSize: FontSizes.fontSizeSm,
    fontWeight: FontWeights.fontWeightRegular,
  );
  static const smRegularWhite = TextStyle(
    fontFamily: FontFamily.fontFamilyDefault,
    fontSize: FontSizes.fontSizeSm,
    fontWeight: FontWeights.fontWeightRegular,
    color: Colors.white,
  );
  static const mdRegular = TextStyle(
    fontFamily: FontFamily.fontFamilyDefault,
    fontSize: FontSizes.fontSizeMd,
    fontWeight: FontWeights.fontWeightRegular,
  );
  static const mdRegularWhite = TextStyle(
    fontFamily: FontFamily.fontFamilyDefault,
    fontSize: FontSizes.fontSizeMd,
    fontWeight: FontWeights.fontWeightRegular,
    color: Colors.white,
  );
  static const mdBlackRegular = TextStyle(
    fontFamily: FontFamily.fontFamilyDefault,
    fontSize: FontSizes.fontSizeMd,
    color:  Color(0xFF61758A),
    fontWeight: FontWeights.fontWeightRegular,
  );
  static const mdBlack = TextStyle(
    fontFamily: FontFamily.fontFamilyDefault,
    fontSize: FontSizes.fontSizeMd,
    color:  Color.fromARGB(255, 0, 0, 0),
    fontWeight: FontWeights.fontWeightRegular,
  );
  static const lgRegular = TextStyle(
    fontFamily: FontFamily.fontFamilyDefault,
    fontSize: FontSizes.fontSizeLg,
    fontWeight: FontWeights.fontWeightRegular,
  );
  static const xlRegular = TextStyle(
    fontFamily: FontFamily.fontFamilyDefault,
    fontSize: FontSizes.fontSizeXl,
    fontWeight: FontWeights.fontWeightRegular,
  );
}
