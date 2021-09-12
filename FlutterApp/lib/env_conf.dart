class EnvConf {

  static const URL_BASE = String.fromEnvironment(
    'URL_BASE',
    defaultValue: 'http://192.168.10.84:3000'
  );

}