// import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;

// const deployed = true;
// const serverAddr = 'https://app.doctorservice.ir';

abstract class APP {
  static const String appName = 'Movies List';
  // static const bool isDev = kDebugMode;
  // static const String apiAddress = deployed
  //     ? serverAddr
  //     : (isDev
  //         ? (!kIsWeb ? 'http://10.0.2.2' : 'http://127.0.0.1:3000')
  //         : serverAddr);

  static const String apiAddress = 'https://moviesapi.ir';
}
