class AppUrl {
  // this is our base url
  static const String baseurl = 'https://disease.sh/v3/covid-19/';

  // fetch world covid state
  static const String worldStateApi = '${baseurl}all';
  static const String countriesList = '${baseurl}countries';

  // Random User Url
  static const String randomBaseUrl = 'https://randomuser.me/api/?results=10';
}
