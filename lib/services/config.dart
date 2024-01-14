class HttpConfig {
  static const String baseURL = "https://testh5.759pc.com";
  static const int timeout = 1000;

  static const getPopupNotice = "/api/public/getPopupNotice";
  static const publicInit = "/api/public/init";
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
  static const getUserInfo = "/api/user/getInfo"; //获取用户信息
  static const updateContact = "/api/user/updateContact"; //修改联系方式
  static const getUserMoney = "/api/user/getUserMoney"; // 用户余额
  static const getUserMoneyDetails = "/api/user/getUserMoneyDetails"; // 用户资金明细
  static const getUserMoneyDetailsSearch =
      "/api/user/getUserMoneyDetailsSearch"; // 获取用户资金明细-筛选
  static const getUserRechargeList = "/api/userRecharge/list"; // 充值信息查询
  static const getUserWithdrawList = "/api/userWithdraw/list"; // 提现信息查询
  static const getUserbetList = "/api/user/betList"; // 注单信息查询
  static const updateUserInfo = "/api/user/updateUserInfo"; //修改用户头像和昵称
  static const rechargeCustomer = "/api/public/rechargeCustomer"; //充值客服中心
  static const getDefaultAvatar = "/api/user/getDefaultAvatar"; //获取默认头像
  // 游戏
  static const getGroupGameList = "/api/game/getGroupGameList"; // 所有游戏分组数据
  static const getGameTypeList = '/api/game/getGameTypeList'; //获取游戏类型分类列表
  static const getGameList = '/api/game/getGameList'; //获取游戏列表
  static const betGame = '/api/game/doJCPGameBet'; //彩票下注
  //客服中心
  static const getCustomer = "/api/public/customer";

  static const getAgentTeam = "/api/agent/team"; //我的推广
  static const getMessageList = '/api/notice/list'; //公告信息查询
  //获取自动返佣
  static const getAutoRecord = '/api/userRebate/getAutoRecord';

  //获取总戏码金额
  static const getTotalMoney = '/api/userRebate/getTotalMoney';

  //洗码记录
  static const getRecord = '/api/userRebate/getRecord';
  static const readNotice = '/api/notice/readNotice'; //系统公告设置已读
  //洗码比例
  static const getRatio = '/api/userRebate/getRatio';
  static const getGameDataStatistics = "/api/game/getGameDataStatistics"; //个人数据
  static const uploadImage = "/api/public/image"; //上传图片
  static const modifyPassword = "/api/public/modifyPassword"; //更新密码
  static const setWithDrawPassword = "/api/public/setWDPassword"; //设置提现密码
  static const modifyWDPassword = "/api/public/modifyWDPassword"; //更新提现密码
  static const currency = "/api/withdrawal/currency"; //获取提现币种
  static const withdraw = "/api/withdrawal/apply"; //申请提现
// static const feeConfig = "/api/withdrawal/config"; //获取提现配置信息
  //领取返水
  static const receiveRebate = "/api/userRebate/receive";
//第三方登录
  static const register_third = "/api/public/register_third";
  static const getNoticeSubType = "/api/public/subType";

  //获取洗码记录
  static const getRecordDetail = "/api/userRebate/getRecordDetail";
}
