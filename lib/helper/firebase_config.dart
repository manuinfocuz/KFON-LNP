import 'package:firebase_remote_config/firebase_remote_config.dart';

class FBConfig {
  final remoteConfig = FirebaseRemoteConfig.instance;

  init() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(
          minutes: 1,
        ),
        minimumFetchInterval: const Duration(
          seconds: 1,
        ),
      ),
    );
    await remoteConfig.fetchAndActivate();
    // startListener();
  }

  startListener() async {
    remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.activate();
    });
  }

  RemoteConfigValue getValue(String key) {
    return remoteConfig.getValue(key);
  }
}
