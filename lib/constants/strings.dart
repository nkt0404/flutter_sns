// packages
import 'package:uuid/uuid.dart';

// titles
const String appTitle = "SNS";
const String signupTitle = "新規登録";
const String loginTitle = "ログイン";
const String accountTitle = "アカウント";
const String themeTitle = "テーマ";
const String profileTitle = "プロフィール";
// texts
const String mailAddressText = "メールアドレス";
const String passwordText = "パスワード";
const String signupText = "新規登録を行う";
const String cropperTitle = "Cropper";
const String loginText = "ログインする";
const String logoutText = "ログアウトを行う";
const String loadingText = "Loading";
const String uploadText = "アップロードする";
// FieldKey
const String usersFieldKey = "users";
// message
const String userCreatedMsg = "ユーザーが作成できました";
const String noAccountMsg = "アカウントをお持ちでない場合";
// prefs key
const String isDarkThemePrefsKey = "isDarkTheme";
// bottom navigation bar
const String homeText = "Home";
const String searchText = "Search";
const String profileText = "Profile";
String returnUuidV4() {
  const Uuid uuid = Uuid();
  return uuid.v4();
}

String returnJpgFileName() => "${returnUuidV4()}.jpg";
