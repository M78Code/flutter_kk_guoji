class HttpConfig {
  static const String baseURL = "https://testh5.759pc.com";
  static const int timeout = 1000;

  static const getCode = "/api/public/captcha";
  static const registerByAccount = "/api/public/register_account";
  static const sendCodeToEmail = "/api/public/sendEmailCode";
  static const bindEmail = "/api/user/bindEmail";
  static const registerByEmail = "/api/public/register_email";
  static const getMarqueeNotice = "/api/public/getMarqueeNotice";
  static const getJCPGameList = "/api/game/getJCPGameList";
  static const getBannerList = "/api/page/getBanner";
  static const login = "/api/public/login";
  static const getGameByCompanyCode = "/api/game/getGameByCompanyCode";
  static const loginGame = "/api/game/login";
  static const gameLoginCallback = "/api/game/loginCallback";
  // 用户
  static const getUserMoney = "/api/user/getUserMoney";   // 用户余额
  static const getUserMoneyDetails = "/api/user/getUserMoneyDetails";   // 用户资金明细
  static const getUserMoneyDetailsSearch = "/api/user/getUserMoneyDetailsSearch";   // 获取用户资金明细-筛选
  // 游戏
  static const getGroupGameList = "/api/game/getGroupGameList"; // 所有游戏分组数据

  //获取用户信息
  static const getUserInfo = "/api/user/getInfo";

  //客服中心
  static const getCustomer = "/api/public/customer";
  //我的推广
  static const getAgentTeam = "/api/agent/team";
  static const getMessageList = '/api/notice/list'; //公告信息查询
  static const readNotice = '/api/notice/readNotice'; //系统公告设置已读
}
