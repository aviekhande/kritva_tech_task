// import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;

// class HydratedBlocConfig {
//   /// Initialize the HydratedBloc storage system.
//   /// This must be called before any HydratedBloc is instantiated.
//   static Future<void> initialize() async {
//     HydratedBloc.storage = await HydratedStorage.build(
//       storageDirectory:
//           kIsWeb
//               ? HydratedStorageDirectory.web
//               : HydratedStorageDirectory((await getTemporaryDirectory()).path),
//     );
//   }
// }
