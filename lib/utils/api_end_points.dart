class AppEndPoints {
  AppEndPoints._();

  static bool isLive = true;

  static get BASEURL => isLive ? "testapi.kfon.co.in" : "testapi.kfon.co.in";

  static String SUBURL = "api/anp/";
  static String GETTOKEN = "api/auth/login";

  static String SEND_OTP_FOR_LOGIN = "${SUBURL}securitylnplogin";
  static String SUB_LOGIN = "${SUBURL}connectwithotp";
  static String SUB_LOGIN_RE = "${SUBURL}reconnectlnp";



  static String POSTLOGIN = "${SUBURL}connect";
  static String POSTPROFILE = "${SUBURL}profile";
  static String CHANGEPASSWORD = "${SUBURL}cpassword";
  static String FOGETPASSWORD = "${SUBURL}fpwdotp";
  static String VALIDATEOTP = "${SUBURL}valfpwotp";

  static String GETDASHBAORD = "${SUBURL}dashboard";

  static String GETSUBSCRIBERLIST = "${SUBURL}sublist";
  static String GETSUBSCRIBERDEATILS = "${SUBURL}subdetails";
  static String GETSUBSCRIBERDATAUSAGE = "${SUBURL}datausgae";

  ///new
  static String GETREMOVEMPONSUB = "${SUBURL}subunmappfrompon";
  static String GETADDPONSUB = "${SUBURL}mapppontosub";

  ///new

  static String SUBSCRIBERTOUP = "${SUBURL}stopup";
  static String SUBSCRIBER_LNP_RECHARGE_DETAILS = "${SUBURL}getrecamount";

  static String GETPACKAGES = "${SUBURL}pkglist";

  static String GETCONFIRMPLANCHANGE = "${SUBURL}plancamount";

  static String CHANGEPLAN = "${SUBURL}planchnage";

  static String USERNAMEAVAILABLE = "${SUBURL}unameavail";
  static String CAFTYPELIST = "${SUBURL}caftypes";

  static String SUBTYPELIST = "${SUBURL}subtypes";

  static String SUBGETAPPID = "${SUBURL}getapno";
  static String GETPLANLIST = "${SUBURL}cafpkglist";
  static String GETPLSNTYPE = "${SUBURL}plantypes";
  static String GETALLPINCODE = "${SUBURL}pincodelist";
  static String GETDISTRICTSANDPO = "${SUBURL}pfdtlist";
  static String GETLOCALBODYLIST = "${SUBURL}lblist";
  static String GETVVBMLIST = "${SUBURL}vbmlist";

  static String GETDEVICEPROVIDERLIST = "${SUBURL}deviceplist";
  static String GETDEVICETYPELIST = "${SUBURL}devicetlist";
  static String GETONTLIST = "${SUBURL}oltlist";

  ///NEW
  static String GETONTDEVICELIST = "${SUBURL}ontdevilist";
  static String GETONTDEVICEDETAILS = "${SUBURL}devicedetails";
  static String GETOLTLIST = "${SUBURL}getoltlist";
  static String GETPONLIST = "${SUBURL}getponlist";

  ///NEW

  static String GETSUPDOCLIST = "${SUBURL}supdocslist";

  static String GETAADHAROTP = "${SUBURL}getkycotp";
  static String AADHARVERIFYOTP = "${SUBURL}valkycotp";
  static String AADHARDETAILS = "${SUBURL}kycdetails";
  static String GSTINCHECKUrl = "${SUBURL}gstdetails";

  static String HDFCGATEWAYURL = "${SUBURL}preparehdfc";
  static String IKMGATEWAYURL = "${SUBURL}prepareikm";
  static String RECHARGEHISTORYURL = "${SUBURL}translist";
  static String CHECKREACHARGE = "${SUBURL}checkstatus";
  static String KYCLISTIURL = "${SUBURL}kyclist";
  static String ADDKEYC = "${SUBURL}addkyc";
  static String CREATEKEYC = "${SUBURL}createkyc";

  /// ticket
  static String getTicketSubjectUrl = "${SUBURL}issueslist";
  static String createTicketUrl = "${SUBURL}cticket";
  static String getTicketListUrl = "${SUBURL}tlist";
  static String getTicketDetailsUrl = "${SUBURL}tdetails";
  static String addTicketCmdUrl = "${SUBURL}addcomment";

  static String getCAFDetailsURL = "${SUBURL}cafdetails";

  ///new

  static String getInvoiceListURL = "${SUBURL}invoices";
  static String getInvoiceURL = "${SUBURL}invoicepdf";

  static String getSubListURL = "${SUBURL}ptnrsublist";
  static String getSubFinURL = "${SUBURL}subfin";

  static String getDisburURL = "${SUBURL}fdisp";
  static String getMonthListURL = "${SUBURL}disbmonthlist";

  static String getRevShareURL = "${SUBURL}revshare";

  static String getSubEnqListUrl = "${SUBURL}subenqlist";
  static String getSubEnqViewUrl = "${SUBURL}subenqview";

  static String getSubEnqStatusList = "${SUBURL}enqstatuslist";
  static String updateSubEnqStatus = "${SUBURL}updenqstatus";

  ///inventory

  static String inveDeviceListUrl = "${SUBURL}listdevice";

  static String removeDevSub = "${SUBURL}remvdevsub";
  static String addDevSub = "${SUBURL}mapvdevsub";
  static String avilToMap = "${SUBURL}avilbonts";


  static String callBackReqUrl = "${SUBURL}lnp_req_ticket";
}
