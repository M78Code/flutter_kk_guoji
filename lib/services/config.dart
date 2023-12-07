class HttpConfig {
  static const String baseURL = "https://testh5.759pc.com";
  static const int timeout = 1000;

  static const getCode = "/api/public/captcha";
  static const registerByAccount = "/api/public/register_account";
  static const sendCodeToEmail = "/api/public/sendEmailCode";
  static const registerByEmail = "/api/public/register_email";
  static const getMarqueeNotice = "/api/public/getMarqueeNotice";
  static const getJCPGameList = "/api/game/getJCPGameList";
  static const getBannerList = "/api/page/getBanner";
  static const login = "/api/public/login";
  static const getGameByCompanyCode = "/api/game/getGameByCompanyCode";
  static const loginGame = "/api/game/login";
  static const gameLoginCallback  = "/api/game/loginCallback";

  // 用户
  static const getUserMoney = "/api/user/getUserMoney";   // 用户余额
  // 游戏
  static const getGroupGameList = "/api/game/getGroupGameList";   // 所有游戏分组数据
}