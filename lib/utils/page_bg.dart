import 'package:flutter/cupertino.dart';

Widget pageBG({required Widget child, bool showBG = false, String? bgImage}) {
  return Container(
    decoration: BoxDecoration(
    //   gradient: !showBG
    //       ?  LinearGradient(
    //       begin: Alignment.topCenter,
    //       end: Alignment.bottomCenter,
    //       colors: [
    //         Color(0xfffef5db),
    //         Color(0xfffef5db).withOpacity(0.6),
    //         Color(0xfffef5db).withOpacity(0.4),
    //         Color(0xfffef5db).withOpacity(0.1),
    //         Color(0xfffe2f4d9).withOpacity(0.1),
    //         Color(0xfffe2f4d9).withOpacity(0.4),
    //         Color(0xfffe2f4d9).withOpacity(0.6),
    //         Color(0xfffe2f4d9),
    //   ],
    // )
    //     : null,
    image: showBG
        ? DecorationImage(
      image:
      ExactAssetImage(bgImage ?? 'assets/images/bglandingpage.png'),
      fit: BoxFit.cover,
    )
        : null,
  ),child
  :
  child
  ,
  );
}
