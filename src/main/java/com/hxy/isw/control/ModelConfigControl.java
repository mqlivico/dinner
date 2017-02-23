package com.hxy.isw.control;

import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.StringReader;
import java.math.BigDecimal;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.MessageDigest;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.hxy.isw.entity.Dinner;
import com.hxy.isw.entity.Employee;
import com.hxy.isw.entity.SetMoney;
import com.hxy.isw.entity.Uploadimglog;
import com.hxy.isw.entity.UserInfo;
import com.hxy.isw.entity.Yycusinfo;
import com.hxy.isw.service.ModelConfigService;
import com.hxy.isw.thread.ReflushAccessToken;
import com.hxy.isw.util.ConstantUtil;
import com.hxy.isw.util.DatabaseHelper;
import com.hxy.isw.util.JsonUtil;
import com.hxy.isw.util.MD5;

import sun.misc.BASE64Decoder;

@Controller
@RequestMapping("/model")
public class ModelConfigControl {
	
	@Autowired
	ModelConfigService modelConfigService;
	
	@Autowired
	DatabaseHelper databaseHelper;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	private String mch_id = "1353467002";
	//private String spbill_create_ip = "121.41.102.173";
	private String appsecrit = "hirGir678dh9MNs342tDsa09LvbF77Yy";
	
	public static String SIGNATURE;
	public static String NONCE_STR ;
	public static String TIMESTAMP;
	
	@RequestMapping(method = RequestMethod.POST, value = "/findTables")
	public void findTables(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String json = request.getParameter("json");
		JsonArray arr = modelConfigService.findTables(json);
		JsonUtil.listToJson(arr, 3, response);
	}
	@RequestMapping(method = RequestMethod.POST, value = "/findColumns")
	public void findColumns(HttpServletRequest request,HttpServletResponse response) throws Exception{
		//select COLUMN_NAME from information_schema.`COLUMNS` where TABLE_SCHEMA = 'isw' and TABLE_NAME='temployee'
		String json = request.getParameter("json");
		JsonArray arr = modelConfigService.findTables(json);
		JsonUtil.listToJson(arr, 3, response);
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/findsome")
	public void findsome(HttpServletRequest request,PrintWriter out) throws Exception{
		String json = request.getParameter("json");
		
		int start = request.getParameter("start")==null?1:Integer.parseInt(request.getParameter("start"));
		int limit = request.getParameter("limit")==null?10:Integer.parseInt(request.getParameter("limit"));
		
		JsonArray arr = modelConfigService.findsome(json,start,limit);
		int count = modelConfigService.countsome(json);
		
		JsonObject jo = new JsonObject();
		jo.add("rows",arr);
		jo.addProperty("total",count);
		out.println(jo.toString());
		out.close();
	}
	
	
	
	
	
	
	
	@RequestMapping(method = RequestMethod.POST, value = "/istodo")
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	public void istodo(HttpServletRequest request,HttpSession session,HttpServletResponse response) throws Exception{
		Employee emp = (Employee)session.getAttribute("loginEmp");
		if(emp==null){
			JsonUtil.timeout2page(response);
			return;
		}
		String state = request.getParameter("state");
		String id = request.getParameter("id");
		Yycusinfo y = (Yycusinfo)databaseHelper.getObjectById(Yycusinfo.class, Long.parseLong(id));
		y.setState(Integer.parseInt(state));
		databaseHelper.updateObject(y);
		JsonUtil.success2page(response);
		
	}
	
	
	
	
	
	
	@RequestMapping(method = RequestMethod.POST, value = "/querynewbatch")
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	public void querynewbatch(HttpServletRequest request,HttpSession session,HttpServletResponse response) throws Exception{
		Employee emp = (Employee)session.getAttribute("loginEmp");
		if(emp==null){
			JsonUtil.timeout2page(response);
			return;
		}
		
		String hql = "select b from BatchInfo b where b.state =0 order by b.createtime desc";
		List<Object> lst = databaseHelper.getResultListByHql(hql);
		JsonArray arr = JsonUtil.castLst2Arr4Single(lst);
		JsonUtil.listToJson(arr, arr.size(), response);
	}
	
	
	@RequestMapping(method = RequestMethod.POST, value = "/queryorder")
	public void queryorder(HttpServletRequest request,HttpServletResponse response,HttpSession session){
		try {
			Employee emp = (Employee)session.getAttribute("loginEmp");
			if(emp==null){
				JsonUtil.timeout2page(response);
				return;
			}
			
			int start = request.getParameter("page")==null?1:Integer.parseInt(request.getParameter("page"));
			int limit = request.getParameter("rows")==null?1:Integer.parseInt(request.getParameter("rows"));
			
			String retire_name = request.getParameter("retire_name");
			String retire_mobileno = request.getParameter("retire_mobileno");
			int retire_state = Integer.parseInt(request.getParameter("retire_state"));
			int pay_state = Integer.parseInt(request.getParameter("pay_state"));
			String hql = "select y from Yycusinfo y where 1=1 ";
			
			
			if(retire_name!=null&&retire_name.length()>0){
				hql += " and y.customername like '%"+retire_name+"%'";
			}
			
			if(retire_mobileno!=null&&retire_mobileno.length()>0){
				hql += " and y.mobile like '%"+retire_mobileno+"%'";
			}
			if(retire_state>-1){
				hql += " and y.state ="+retire_state;
			}
			if(pay_state>-1){
				hql += " and y.paystate ="+pay_state;
			}
			
			//hql += " order by y.mobile,y.time desc";
			//hql += " order by y.time desc";
			hql += " order by y.time asc";
			List<Object> lst = databaseHelper.getResultListByHql(hql,start,limit);
			
			JsonArray arr = JsonUtil.castLst2Arr4SingleTime(lst);
			
			hql = "select count(y.id) from Yycusinfo y where 1=1 ";
			
			if(retire_name!=null&&retire_name.length()>0){
				hql += " and y.customername like '%"+retire_name+"%'";
			}
			
			if(retire_mobileno!=null&&retire_mobileno.length()>0){
				hql += " and y.mobile like '%"+retire_mobileno+"%'";
			}
			
			if(retire_state>-1){
				hql += " and y.state ="+retire_state;
			}
			
			if(pay_state>-1){
				hql += " and y.paystate ="+pay_state;
			}
			
			List clst = databaseHelper.getResultListByHql(hql);
			
			int count  = Integer.parseInt(clst.get(0).toString());
			
			JsonUtil.listToJson(arr,count,response);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping(method = RequestMethod.POST, value = "/queryretireinfo")
	public void queryretireinfo(HttpServletRequest request,HttpServletResponse response,HttpSession session){
		try {
			Employee emp = (Employee)session.getAttribute("loginEmp");
			if(emp==null){
				JsonUtil.timeout2page(response);
				return;
			}
			
			int start = request.getParameter("page")==null?1:Integer.parseInt(request.getParameter("page"));
			int limit = request.getParameter("rows")==null?1:Integer.parseInt(request.getParameter("rows"));
			
			String retire_fileno = request.getParameter("retire_fileno");
			String retire_name = request.getParameter("retire_name");
			String retire_paperno = request.getParameter("retire_paperno");
			String retire_mobileno = request.getParameter("retire_mobileno");
			String batchinfo_id = request.getParameter("batchinfo_id");
			String state = request.getParameter("state");
			String hql = "select r from RetireInfo r where r.state >0 ";
			
			if(retire_fileno!=null&&retire_fileno.length()>0){
				hql += " and r.fileno like '%"+retire_fileno+"%'";
			}
			if(retire_name!=null&&retire_name.length()>0){
				hql += " and r.name like '%"+retire_name+"%'";
			}
			if(retire_paperno!=null&&retire_paperno.length()>0){
				hql += " and r.paperno like '%"+retire_paperno+"%'";
			}
			if(retire_mobileno!=null&&retire_mobileno.length()>0){
				hql += " and r.mobileno like '%"+retire_mobileno+"%'";
			}
			
			if(batchinfo_id!=null&&batchinfo_id.length()>0){
				hql += " and r.batchinfoId ="+Long.parseLong(batchinfo_id);
			}
			
			if(state!=null&&state.length()>0){
				hql += " and r.state ="+Long.parseLong(state);
			}
			
			hql += " order by r.createtime desc";
			List<Object> lst = databaseHelper.getResultListByHql(hql,start,limit);
			
			JsonArray arr = JsonUtil.castLst2Arr4SingleTime(lst);
			
			hql = "select count(r.id) from RetireInfo r where r.state >0";
			
			if(retire_fileno!=null&&retire_fileno.length()>0){
				hql += " and r.fileno like '%"+retire_fileno+"%'";
			}
			if(retire_name!=null&&retire_name.length()>0){
				hql += " and r.name like '%"+retire_name+"%'";
			}
			if(retire_paperno!=null&&retire_paperno.length()>0){
				hql += " and r.paperno like '%"+retire_paperno+"%'";
			}
			if(retire_mobileno!=null&&retire_mobileno.length()>0){
				hql += " and r.mobileno like '%"+retire_mobileno+"%'";
			}
			if(batchinfo_id!=null&&batchinfo_id.length()>0){
				hql += " and r.batchinfoId ="+Long.parseLong(batchinfo_id);
			}
			if(state!=null&&state.length()>0){
				hql += " and r.state ="+Long.parseLong(state);
			}
			
			List clst = databaseHelper.getResultListByHql(hql);
			
			int count  = Integer.parseInt(clst.get(0).toString());
			
			JsonUtil.listToJson(arr,count,response);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping(method = RequestMethod.POST, value = "/queryorderById")
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	public void queryorderById(HttpServletRequest request,HttpSession session,HttpServletResponse response) throws Exception{
		Employee emp = (Employee)session.getAttribute("loginEmp");
		if(emp==null){
			JsonUtil.timeout2page(response);
			return;
		}
		String rid = request.getParameter("rid");
		String hql = "select y from Yycusinfo y where y.id ="+Long.parseLong(rid);
		List<Object> lst = databaseHelper.getResultListByHql(hql);
		JsonArray arr = JsonUtil.castLst2Arr4SingleTime(lst);
		JsonUtil.listToJson(arr, arr.size(), response);
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/addremark")
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	public void addremark(HttpServletRequest request,HttpSession session,HttpServletResponse response) throws Exception{
		Employee emp = (Employee)session.getAttribute("loginEmp");
		if(emp==null){
			JsonUtil.timeout2page(response);
			return;
		}
		String rid = request.getParameter("rid");
		String sendno = request.getParameter("sendno");
		String server = request.getParameter("server");
		String remark = request.getParameter("remark");
		
		Yycusinfo y =(Yycusinfo)databaseHelper.getObjectById(Yycusinfo.class, Long.parseLong(rid));
		y.setSendno(sendno);
		y.setServer(server);
		y.setRemark(remark);
		
		databaseHelper.updateObject(y);
		
		JsonUtil.success2page(response);
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/queryretireById")
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	public void queryretireById(HttpServletRequest request,HttpSession session,HttpServletResponse response) throws Exception{
		Employee emp = (Employee)session.getAttribute("loginEmp");
		if(emp==null){
			JsonUtil.timeout2page(response);
			return;
		}
		String rid = request.getParameter("rid");
		String hql = "select r from RetireInfo r where r.id ="+Long.parseLong(rid);
		List<Object> lst = databaseHelper.getResultListByHql(hql);
		JsonArray arr = JsonUtil.castLst2Arr4SingleTime(lst);
		JsonUtil.listToJson(arr, arr.size(), response);
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/queryretireByFileNo")
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	public void queryretireByFileNo(HttpServletRequest request,HttpSession session,HttpServletResponse response) throws Exception{
		String fileno = request.getParameter("fileno");
		
		String hql = "select r from RetireInfo r where r.state >=0 and r.fileno='"+fileno+"' order by r.createtime";
		List<Object> lst = databaseHelper.getResultListByHql(hql);
		
		JsonArray arr = JsonUtil.castLst2Arr4SingleTime(lst);
		JsonUtil.listToJson(arr, arr.size(), response);
	}
	
	
	private static String create_nonce_str() {
			
			String str = "";
			
			for (int i = 0; i < 32; i++) {
				Random r = new Random();
				int num = r.nextInt(61);
				if( num>=0 && num <=9 ){
					str += num;
				}else if( num>9 && num <=35 ){
					num+=55;
					str += (char)num;
				}else if( num>35 && num <=61 ){
					num+=61;
					str += (char)num;
				}
			}
			return str;
	    }
	
	
	private  String mchbillno(){
		String mch_billno = mch_id;
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		String d = sdf.format(date);
		d = d.replace("-", "");
		mch_billno = mch_billno+d;
		for (int i = 0; i < 10; i++) {
			int random = new Random().nextInt(10);
			mch_billno += (random+"");
		}
		
		return mch_billno;
	}
	
	private  String sign(String appid,String attach,String body,String nonce_str,String notify_url,String openid,String out_trade_no,String spbill_create_ip,int total_fee){
		String stringA = "appid="+appid+"&attach="+attach+"&body="+body+"&mch_id="+mch_id+"&nonce_str="+nonce_str+"&notify_url="+notify_url+"&openid="+openid+"&out_trade_no="+out_trade_no+"&spbill_create_ip="+spbill_create_ip+"&total_fee="+total_fee+"&trade_type=JSAPI";
		String stringSignTemp=stringA+"&key="+ appsecrit;
		System.out.println(stringSignTemp);
		return MD5.JM(stringSignTemp).toUpperCase();
	}
	
	private  String sign4pay(String appId, String timeStamp, String nonceStr,String ppackage,String signType){
		String stringA = "appId="+appId+"&nonceStr="+nonceStr+"&package="+ppackage+"&signType="+signType+"&timeStamp="+timeStamp;
		String stringSignTemp=stringA+"&key="+ appsecrit;
		System.out.println(stringSignTemp);
		return MD5.JM(stringSignTemp).toUpperCase();
	}
	

	public static String setXML(String return_code, String return_msg) {
        return "<xml><return_code><![CDATA[" + return_code
                + "]]></return_code><return_msg><![CDATA[" + return_msg
                + "]]></return_msg></xml>";
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/unifiedorder")
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	public void unifiedorder(HttpServletRequest request,HttpSession session,HttpServletResponse response) throws Exception{
		
		String ip = request.getHeader("x-forwarded-for"); 
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	         ip = request.getHeader("Proxy-Client-IP"); 
	    } 
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	         ip = request.getHeader("WL-Proxy-Client-IP"); 
	    } 
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	          ip = request.getRemoteAddr(); 
	    }
	    
	    if(ip.indexOf(",")!=-1){
	    	ip = ip.split(",")[0];
	    }
	    
		int fee = request.getParameter("fee")==null?1:Integer.parseInt(request.getParameter("fee"));
		String nonce_str = create_nonce_str();
		String notify_url = "http://s.lcc.so/notify/url";
		String openid = session.getAttribute("openid")==null?"":session.getAttribute("openid").toString();
		String out_trade_no= mchbillno();
		String attach = "YY红酒私人定制";
		String body = "YY红酒私人定制";
		int total_fee = fee;
		total_fee = 3900;
		String spbill_create_ip = ip;
		String sign = sign(ConstantUtil.APPID, attach, body, nonce_str, notify_url, openid, out_trade_no, spbill_create_ip, total_fee);
		String p = "<xml>"+
				"<appid><![CDATA["+ConstantUtil.APPID+"]]></appid>"+
				"<attach><![CDATA["+attach+"]]></attach>"+
				"<body><![CDATA["+body+"]]></body>"+
				"<mch_id><![CDATA["+mch_id+"]]></mch_id>"+
				"<nonce_str><![CDATA["+nonce_str+"]]></nonce_str>"+
				"<notify_url><![CDATA["+notify_url+"]]></notify_url>"+
				"<openid><![CDATA["+openid+"]]></openid>"+
				"<out_trade_no><![CDATA["+out_trade_no+"]]></out_trade_no>"+
				"<spbill_create_ip><![CDATA["+spbill_create_ip+"]]></spbill_create_ip>"+
				"<total_fee><![CDATA["+total_fee+"]]></total_fee>"+
				"<trade_type><![CDATA[JSAPI]]></trade_type>"+
				"<sign><![CDATA["+sign+"]]></sign>"+
				"</xml>";
		
		p = "<xml>"+
				"<appid>"+ConstantUtil.APPID+"</appid>"+
				"<attach>"+attach+"</attach>"+
				"<body>"+body+"</body>"+
				"<mch_id>"+mch_id+"</mch_id>"+
				"<nonce_str>"+nonce_str+"</nonce_str>"+
				"<notify_url>"+notify_url+"</notify_url>"+
				"<openid>"+openid+"</openid>"+
				"<out_trade_no>"+out_trade_no+"</out_trade_no>"+
				"<spbill_create_ip>"+spbill_create_ip+"</spbill_create_ip>"+
				"<total_fee>"+total_fee+"</total_fee>"+
				"<trade_type>JSAPI</trade_type>"+
				"<sign>"+sign+"</sign>"+
				"</xml>";
		
		System.out.println("p:"+p);
		/*try {
			DefaultHttpClient httpclient = new DefaultHttpClient();
			HttpPost httpost = HttpClientConnectionManager.getPostMethod("https://api.mch.weixin.qq.com/pay/unifiedorder");    
			httpost.setEntity(new StringEntity(p, "UTF-8"));    
			HttpResponse resp = httpclient.execute(httpost);    
			String result = EntityUtils.toString(resp.getEntity(), "utf-8"); 
			System.out.println("create:"+result);
			JsonUtil.success2page(response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			JsonUtil.noRight2page(response);
		} */
		String requestUrl = "https://api.mch.weixin.qq.com/pay/unifiedorder";
		Map<String, String> result = new HashMap<String, String>();
		  try {
			  StringBuffer buffer = httpsRequest(requestUrl, "POST", p);
			  System.out.println("=========result========");
			  String strBuffer = buffer.toString();
			  System.out.println(strBuffer);
			  result = parse(strBuffer);
			  System.out.println(result.get("prepay_id"));
			  Map<String, String> map = new HashMap<String, String>();
			 
			  map.put("appId", ConstantUtil.APPID);
			  map.put("timestamp", TIMESTAMP);
			  map.put("nonceStr",NONCE_STR);
			  map.put("packMage", result.get("prepay_id"));
			  map.put("signType", "MD5");
			  map.put("paySign", sign4pay(ConstantUtil.APPID, TIMESTAMP, NONCE_STR, "prepay_id="+result.get("prepay_id"), "MD5"));
			  String json = new Gson().toJson(map);
			  System.out.println("wxpay.."+json);
			  response.setContentType("text/json; charset=UTF-8");
			  PrintWriter out = response.getWriter();
			  out.println(json);
			out.close();
		  } catch (ConnectException ce) {
			  ce.printStackTrace();
		  } catch (Exception e) {
			  e.printStackTrace();
		  }
	}
	

	
	private static StringBuffer httpsRequest(String requestUrl, String requestMethod, String output)
			  throws Exception {
		
			 // URL url = new URL(requestUrl);
		      URL url = new URL(null,requestUrl, new sun.net.www.protocol.https.Handler());
			  HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			  connection.setDoOutput(true);
			  connection.setDoInput(true);
			  connection.setUseCaches(false);
			  connection.setRequestMethod(requestMethod);
			  if (null != output) {
			  OutputStream outputStream = connection.getOutputStream();
			  outputStream.write(output.getBytes("UTF-8"));
			  outputStream.close();
			  }
			  // 从输入流读取返回内容
			  InputStream inputStream = connection.getInputStream();
			  InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
			  BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
			  String str = null;
			  StringBuffer buffer = new StringBuffer();
			  while ((str = bufferedReader.readLine()) != null) {
			  buffer.append(str);
			  }
			  bufferedReader.close();
			  inputStreamReader.close();
			  inputStream.close();
			  inputStream = null;
			  connection.disconnect();
			  return buffer;
			 } 
	
	@RequestMapping(method = RequestMethod.GET, value = "/find")
	public void getwechatJsData(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		try {
			String my_url = "http://s.lcc.so/forImg/index.jsp";
			//my_url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx44f90f8d53c3c9be&redirect_uri=http%3A%2F%2Flcc.so%2Fmp%2Fx&response_type=code&scope=snsapi_base&state=STATE#wechat_redirect";
			//my_url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx44f90f8d53c3c9be&redirect_uri=http%3A%2F%2Flcc.so%2Fmp%2Fx&response_type=code&scope=snsapi_base&state=STATE";
			my_url = request.getParameter("url");
			System.out.println("my_url:"+my_url);
			Map<String,String> map = new HashMap<String,String>();
			
			NONCE_STR = ReflushAccessToken.create_nonce_str();
			TIMESTAMP = ReflushAccessToken.create_timestamp();
			
			String string1 = "jsapi_ticket=" + ReflushAccessToken.TICKET +
            "&noncestr=" + NONCE_STR +
            "&timestamp=" + TIMESTAMP +
            "&url=" + my_url;
			System.out.println("string1:"+string1);
			
			MessageDigest crypt = MessageDigest.getInstance("SHA-1");
            crypt.reset();
            crypt.update(string1.getBytes("UTF-8"));
            SIGNATURE = ReflushAccessToken.byteToHex(crypt.digest());
			
            System.out.println("TICKET:"+ReflushAccessToken.TICKET+",SIGNATURE:"+SIGNATURE+",NONCE_STR:"+NONCE_STR+",TIMESTAMP:"+TIMESTAMP);
			
			map.put("appId", ConstantUtil.APPID);
			map.put("timestamp", TIMESTAMP);
			map.put("nonceStr",NONCE_STR);
			map.put("signature", SIGNATURE);
			
			String json = new Gson().toJson(map);
			System.out.println("getwechatJsData.."+json);
			response.setContentType("text/json; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println(json);
			out.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/submitOrder")
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	public void submitOrder(HttpServletRequest request,HttpSession session,HttpServletResponse response) throws Exception{
		String customername = request.getParameter("customername")==null?"":request.getParameter("customername");
		String mobile = request.getParameter("mobile")==null?"":request.getParameter("mobile");
		String address = request.getParameter("address")==null?"":request.getParameter("address");
		int mark = request.getParameter("mark")==null?1:Integer.parseInt(request.getParameter("mark").toString());
		String imageurl = request.getParameter("imageurl")==null?"":request.getParameter("imageurl");
		
		/*String hql = "select y from Yycusinfo y where y.mobile = '"+mobile+"'";
		List<Object> lst = databaseHelper.getResultListByHql(hql);
		
		if(lst.size()>=2){
			JsonUtil.success2page(response,"{\"op\":\"tomore\"}");
			return;
		}*/
		
		//System.out.println(stringBase64);
		Yycusinfo yycus = new Yycusinfo();
		yycus.setAddress(address);
		yycus.setCustomername(customername);
		yycus.setImageurl(imageurl);
		yycus.setMobile(mobile);
		yycus.setModel(mark);
		yycus.setState(0);
		yycus.setTime(new Date());
		yycus.setOpenid(session.getAttribute("openid")==null?"":session.getAttribute("openid").toString());
		yycus.setPaystate(0);
		yycus.setPayid(-1l);
		databaseHelper.persistObject(yycus);
		
		int flag = 0;//checkidofuser(request);
		//System.out.println("ip is hubei .. flag:"+flag);
		JsonUtil.success2page(response,"{\"op\":\"success\",\"flag\":\""+flag+"\",\"id\":\""+yycus.getId()+"\"}");
	}
	
	
	@RequestMapping(method = RequestMethod.POST, value = "/updateorderpaystate")
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	public void updateorderpaystate(HttpServletRequest request,HttpSession session,HttpServletResponse response) throws Exception{
		Long id = request.getParameter("id")==null?0l:Long.parseLong(request.getParameter("id"));
		
		Yycusinfo y = (Yycusinfo)databaseHelper.getObjectById(Yycusinfo.class, id);
		y.setPaystate(1);
		//y.setPayid(session.getAttribute("payid")==null?-1l:Long.parseLong(session.getAttribute("payid").toString()));
		databaseHelper.updateObject(y);
		JsonUtil.success2page(response);
		
	}
	
	private int checkidofuser(HttpServletRequest request){
		String [] hbips = {"27.16.","27.17.","27.18.","27.19.","27.20.","27.21.","27.22.",
				"27.23.","27.24.","27.25.","27.26.","27.27.","27.28.","27.29.","27.30.","27.31.",
				"171.40.","171.41.","171.42.","171.43.","171.44.","171.45.","171.46.","171.47.",
				"111.176.","111.177.","111.178.","111.179.","111.180.","111.181.","111.182.","111.183.",
				"119.96.","119.97.","119.98.","119.99.","119.100.","119.101.","119.102.","119.103.",
				"58.48.","58.49.","58.50.","58.51.","58.52.","58.53.","58.54.","58.55.","59.68.","59.69.","59.70.","59.71.",
				"121.60.","121.61.","121.62.","121.63.","116.208.","116.209.","116.210.","116.211.",
				"122.188.","122.189.","122.190.","122.191.","49.120.","49.121.","49.122.","49.123.","49.220.","49.221.","49.222.","49.223.",
				"111.172.","111.173.","111.174.","111.175.","171.80.","171.81.","171.82.","171.83.","171.112.","171.113.","171.114.","171.115.",
				"122.204.","122.205.","122.206.","122.207.","175.24.","175.25.","175.26.","175.27.","183.92.","183.93.","183.94.","183.95.",
				"61.184.","61.185.","61.186.","61.187.","221.232.","221.233.","221.234.","221.235.","125.220.","125.221.","183.168.","183.169.",
				"222.20.","222.21.","59.172.","59.173.","59.174.","59.175.","115.190.","115.191.","115.156.","115.157.","113.56.","113.57.",
				"119.36.","61.183.","58.19.","111.170.","116.207.","202.114.",
				"202.103.8.","202.103.9.","202.103.10.","202.103.11.","202.103.12.","202.103.13.","202.103.14.","202.103.15.",
				"202.103.0.","202.103.1.","202.103.2.","202.103.3.","202.103.4.","202.103.5.","202.103.6.","202.103.7.",
				"103.3.104.","103.3.105.","103.3.106.","103.3.107.","103.22.80.","103.22.81.","103.22.82.","103.22.83."
		};
		
		String ip = request.getHeader("x-forwarded-for"); 
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	         ip = request.getHeader("Proxy-Client-IP"); 
	    } 
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	         ip = request.getHeader("WL-Proxy-Client-IP"); 
	    } 
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	          ip = request.getRemoteAddr(); 
	    }
		System.out.println("ip..before.."+ip);
		int flag = -1;
		for (String hbip : hbips) {
			if(ip.startsWith(hbip)){
				flag = 0;
				break;
			}
		}
		
		
		if(flag==-1&&ip.indexOf('.')!=-1){
			ip = ip.replace(".", "#");
			System.out.println(ip);
			String [] ips = ip.split("#");
			System.out.println(ips.length);
			int one = Integer.parseInt(ips[0]);
			int two = Integer.parseInt(ips[1]);
			int three = Integer.parseInt(ips[2]);
			
			if(one==61&&two==136&&three>=128&&three<=255)flag = 0;
			else if(one==202&&two==114&&three>=64&&three<=127)flag = 0;
			else if(one==203&&two==176&&three>=0&&three<=63)flag = 0;
			else if(one==202&&two==110&&three>=128&&three<=191)flag = 0;
			else if(one==122&&two==0&&three>=64&&three<=127)flag = 0;
			else if(one==210&&two==52&&three>=0&&three<=63)flag = 0;
			else if(one==202&&two==63&&three>=160&&three<=191)flag = 0;
			else if(one==202&&two==180&&three>=128&&three<=159)flag = 0;
			else if(one==202&&two==114&&three>=0&&three<=63)flag = 0;
			else if(one==182&&two==239&&three>=0&&three<=31)flag = 0;
			else if(one==202&&two==103&&three>=32&&three<=63)flag = 0;
			else if(one==203&&two==100&&three>=32&&three<=47)flag = 0;
			else if(one==210&&two==5&&three>=128&&three<=143)flag = 0;
			else if(one==203&&two==103&&three>=16&&three<=31)flag = 0;
			else if(one==203&&two==93&&three>=144&&three<=159)flag = 0;
			else if(one==223&&two==104&&three==20)flag = 0;
		}
		
		return flag;
	}
	
	
	@RequestMapping(method = RequestMethod.POST, value = "/checkip")
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	public void checkip(HttpServletRequest request,HttpSession session,HttpServletResponse response){
		String [] hbips = {"27.16.","27.17.","27.18.","27.19.","27.20.","27.21.","27.22.",
				"27.23.","27.24.","27.25.","27.26.","27.27.","27.28.","27.29.","27.30.","27.31.",
				"171.40.","171.41.","171.42.","171.43.","171.44.","171.45.","171.46.","171.47.",
				"111.176.","111.177.","111.178.","111.179.","111.180.","111.181.","111.182.","111.183.",
				"119.96.","119.97.","119.98.","119.99.","119.100.","119.101.","119.102.","119.103.",
				"58.48.","58.49.","58.50.","58.51.","58.52.","58.53.","58.54.","58.55.","59.68.","59.69.","59.70.","59.71.",
				"121.60.","121.61.","121.62.","121.63.","116.208.","116.209.","116.210.","116.211.",
				"122.188.","122.189.","122.190.","122.191.","49.120.","49.121.","49.122.","49.123.","49.220.","49.221.","49.222.","49.223.",
				"111.172.","111.173.","111.174.","111.175.","171.80.","171.81.","171.82.","171.83.","171.112.","171.113.","171.114.","171.115.",
				"122.204.","122.205.","122.206.","122.207.","175.24.","175.25.","175.26.","175.27.","183.92.","183.93.","183.94.","183.95.",
				"61.184.","61.185.","61.186.","61.187.","221.232.","221.233.","221.234.","221.235.","125.220.","125.221.","183.168.","183.169.",
				"222.20.","222.21.","59.172.","59.173.","59.174.","59.175.","115.190.","115.191.","115.156.","115.157.","113.56.","113.57.",
				"119.36.","61.183.","58.19.","111.170.","116.207.","202.114.",
				"202.103.8.","202.103.9.","202.103.10.","202.103.11.","202.103.12.","202.103.13.","202.103.14.","202.103.15.",
				"202.103.0.","202.103.1.","202.103.2.","202.103.3.","202.103.4.","202.103.5.","202.103.6.","202.103.7.",
				"103.3.104.","103.3.105.","103.3.106.","103.3.107.","103.22.80.","103.22.81.","103.22.82.","103.22.83."
		};
		
		String ip = request.getHeader("x-forwarded-for"); 
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	         ip = request.getHeader("Proxy-Client-IP"); 
	    } 
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	         ip = request.getHeader("WL-Proxy-Client-IP"); 
	    } 
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	          ip = request.getRemoteAddr(); 
	    }
		System.out.println("ip..before.."+ip);
		int flag = -1;
		for (String hbip : hbips) {
			if(ip.startsWith(hbip)){
				flag = 0;
				break;
			}
		}
		
		
		if(flag==-1&&ip.indexOf('.')!=-1){
			ip = ip.replace(".", "#");
			System.out.println(ip);
			String [] ips = ip.split("#");
			System.out.println(ips.length);
			int one = Integer.parseInt(ips[0]);
			int two = Integer.parseInt(ips[1]);
			int three = Integer.parseInt(ips[2]);
			
			if(one==61&&two==136&&three>=128&&three<=255)flag = 0;
			else if(one==202&&two==114&&three>=64&&three<=127)flag = 0;
			else if(one==203&&two==176&&three>=0&&three<=63)flag = 0;
			else if(one==202&&two==110&&three>=128&&three<=191)flag = 0;
			else if(one==122&&two==0&&three>=64&&three<=127)flag = 0;
			else if(one==210&&two==52&&three>=0&&three<=63)flag = 0;
			else if(one==202&&two==63&&three>=160&&three<=191)flag = 0;
			else if(one==202&&two==180&&three>=128&&three<=159)flag = 0;
			else if(one==202&&two==114&&three>=0&&three<=63)flag = 0;
			else if(one==182&&two==239&&three>=0&&three<=31)flag = 0;
			else if(one==202&&two==103&&three>=32&&three<=63)flag = 0;
			else if(one==203&&two==100&&three>=32&&three<=47)flag = 0;
			else if(one==210&&two==5&&three>=128&&three<=143)flag = 0;
			else if(one==203&&two==103&&three>=16&&three<=31)flag = 0;
			else if(one==203&&two==93&&three>=144&&three<=159)flag = 0;
			
		}
		
		JsonUtil.success2page(response,"{\"flag\":\""+flag+"\"}");
	}
	
	public static void main(String[] args) {
		/*String ip = "61.136.127.10";
		ip = ip.replace(".", "#");
		System.out.println(ip);
		
		String [] s = ip.split("#");
		System.out.println(s[0]);*/
		Date d = new Date(1455872603661l);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		System.out.println(sdf.format(d));
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/uploadImg")
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	public void uploadImg(HttpServletRequest request,HttpSession session,HttpServletResponse response){
		String result = "";
		try {
			String stringBase64 = request.getParameter("stringBase64");
			int model = request.getParameter("mark")==null?1:Integer.parseInt(request.getParameter("mark").toString());
			//System.out.println(stringBase64);
			String imgname = GenerateImage(stringBase64);
			System.out.println("imgname:"+imgname);
			if(imgname==null)result = "{\"op\":\"fail\"}";
			else if(session.getAttribute("openid")==null)result = "{\"op\":\"openidlose\"}";
			else {
				int subscribe = Integer.parseInt(session.getAttribute("subscribe")==null?"0":session.getAttribute("subscribe").toString());
				System.out.println("subscribe:"+subscribe);
				Uploadimglog ull = new Uploadimglog();
				
				Date now = new Date();
				
				ull.setSubscribe(subscribe);
				ull.setTime(now);
				ull.setModel(model);
				ull.setImageurl(imgname);
				ull.setOpenid(session.getAttribute("openid")==null?"":session.getAttribute("openid").toString());
				if(subscribe==1){
					ull.setCity(session.getAttribute("city")==null?"":session.getAttribute("city").toString());
					ull.setCountry(session.getAttribute("country")==null?"":session.getAttribute("country").toString());
					ull.setHeadimgurl(session.getAttribute("headimgurl")==null?"":session.getAttribute("headimgurl").toString());
					
					String nickname = session.getAttribute("nickname")==null?"":session.getAttribute("nickname").toString();
					if(nickname.length()>0)nickname = filterEmoji(nickname);
					
					ull.setNickname(nickname);
					ull.setProvince(session.getAttribute("province")==null?"":session.getAttribute("province").toString());
					ull.setSex(session.getAttribute("sex")==null?0:Integer.parseInt(session.getAttribute("sex").toString()));
				}
				
				/*System.out.println(ull.getSubscribe());
				System.out.println(ull.getTime());
				System.out.println(ull.getModel());
				System.out.println(ull.getImageurl());
				System.out.println(ull.getOpenid());
				System.out.println(ull.getCity());
				System.out.println(ull.getCountry());
				System.out.println(ull.getHeadimgurl());
				System.out.println(ull.getProvince());
				System.out.println(ull.getSex());*/
				
				databaseHelper.persistObject(ull);
				
				result ="{\"op\":\"success\",\"imgname\":\""+imgname+"\"}";
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		JsonUtil.success2page(response,result);
	}
	
	
	public  String filterEmoji(String source) {
	 	 
	    if (!containsEmoji(source)) {
	        return source;//如果不包含，直接返回
	    }
	    //到这里铁定包含
	        StringBuilder buf = null;
	 
	        int len = source.length();
	 
	        for (int i = 0; i < len; i++) {
	            char codePoint = source.charAt(i);
	 
	            if (isEmojiCharacter(codePoint)) {
	                if (buf == null) {
	                    buf = new StringBuilder(source.length());
	                }
	 
	                buf.append(codePoint);
	            } else {
	            }
	        }
	 
	        if (buf == null) {
	            return source;//如果没有找到 emoji表情，则返回源字符串
	    } else {
	        if (buf.length() == len) {//这里的意义在于尽可能少的toString，因为会重新生成字符串
	            buf = null;
	            return source;
	        } else {
	            return buf.toString();
	        }
	    }
			 	 
	}
	
	public  boolean containsEmoji(String source) {
	        if (StringUtils.isBlank(source)) {
	            return false;
	        }
	 
	        int len = source.length();
	 
        for (int i = 0; i < len; i++) {
            char codePoint = source.charAt(i);
	 
	            if (isEmojiCharacter(codePoint)) {
	                //do nothing，判断到了这里表明，确认有表情字符
	                return true;
	            }
	        }
	 
	        return false;
	    }

	private  boolean isEmojiCharacter(char codePoint) {
	        return (codePoint == 0x0) ||
	                (codePoint == 0x9) ||
	                (codePoint == 0xA) ||
	                (codePoint == 0xD) ||
	                ((codePoint >= 0x20) && (codePoint <= 0xD7FF)) ||
	                ((codePoint >= 0xE000) && (codePoint <= 0xFFFD)) ||
	                ((codePoint >= 0x10000) && (codePoint <= 0x10FFFF));
}
	
	// base64字符串转化成图片
	public static String GenerateImage(String imgStr) { // 对字节数组字符串进行Base64解码并生成图片
		if (imgStr == null) // 图像数据为空
		return null;
		BASE64Decoder decoder = new BASE64Decoder();
		try {
		// Base64解码
			byte[] b = decoder.decodeBuffer(imgStr);
			for (int i = 0; i < b.length; ++i) {
				if (b[i] < 0) {// 调整异常数据
					b[i] += 256;
				}
			}
		// 生成jpeg图片
			String imgFilePath = ConstantUtil.PROJECT_PATH.replace("WEB-INF/classes/", "forImg/userimg/");//tomcat

		//	imgFilePath = ConstantUtil.PROJECT_PATH.replace("target/classes/","src/main/webapp/forImg/userimg/");//maven
			long thistime = new Date().getTime();
			imgFilePath = imgFilePath+thistime+".png";// 新生成的图片
			System.out.println(imgFilePath);
			OutputStream out = new FileOutputStream(imgFilePath);
			out.write(b);
			out.flush();
			out.close();
			return thistime+".png";
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	
	@RequestMapping(method = RequestMethod.POST, value = "/queryworkhistoryById")
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	public void queryworkhistoryById(HttpServletRequest request,HttpSession session,HttpServletResponse response) throws Exception{
		Employee emp = (Employee)session.getAttribute("loginEmp");
		if(emp==null){
			JsonUtil.timeout2page(response);
			return;
		}
		String rid = request.getParameter("rid");
		String hql = "select wh from WorkHistory wh where wh.state = 0 and wh.retireinfoId ="+Long.parseLong(rid)+" order by wh.createtime";
		List<Object> lst = databaseHelper.getResultListByHql(hql);
		JsonArray arr = JsonUtil.castLst2Arr4SingleTime(lst);
		JsonUtil.listToJson(arr, arr.size(), response);
	}
	

	private String getCellFormatValue(HSSFCell cell) {

        String cellvalue = "";
        if (cell != null) {
            switch (cell.getCellType()) {
            case HSSFCell.CELL_TYPE_NUMERIC:
            case HSSFCell.CELL_TYPE_FORMULA: {
                if (HSSFDateUtil.isCellDateFormatted(cell)) {
                    
                    Date date = cell.getDateCellValue();
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:dd");
                    cellvalue = sdf.format(date);
                    
                }
                else {
                	DecimalFormat df = new DecimalFormat("#");
                    cellvalue = df.format(cell.getNumericCellValue());
                }
                break;
            }
            case HSSFCell.CELL_TYPE_STRING:
                cellvalue = cell.getRichStringCellValue().getString();
                break;
            default:
                cellvalue = " ";
            }
        } else {
            cellvalue = "";
        }
        

        return cellvalue;

    }
	
	private int returnpepletype(String v){
		String [] types = {"","正常退休", "特殊工种退休","因病退休","退职","军转干部退休","农工","民师","城镇集体"};
		int t = 0;
		for(int i=0;i<types.length;i++){
			if(types[i].equals(v)){
				t=i;
				break;
			}
		}
		return t;
	}
	
	 public static Map<String,String> parse(String protocolXML) {  
         
		 Map<String,String> map = new HashMap<String,String>();
	        try {  
	             DocumentBuilderFactory factory = DocumentBuilderFactory  
	                     .newInstance();  
	             DocumentBuilder builder = factory.newDocumentBuilder();  
	             Document doc = builder  
	                     .parse(new InputSource(new StringReader(protocolXML)));  
	 
	             Element root = doc.getDocumentElement();  
	             NodeList books = root.getChildNodes();  
	            if (books != null) {  
	                for (int i = 0; i < books.getLength(); i++) {  
	                     Node book = books.item(i);  
	                     System.out.println("document=" + book.getNodeName() + "\ttext=" 
	                             + book.getFirstChild().getNodeValue());  
	                     map.put(book.getNodeName(), book.getFirstChild().getNodeValue());
	                 }  
	             }  
	         } catch (Exception e) {  
	             e.printStackTrace();  
	         }  
	        return map;
	     }   
	
	 
	 @RequestMapping(method = RequestMethod.POST, value = "/queryuser")
		public void queryuser(HttpServletRequest request,HttpServletResponse response,HttpSession session){
			try {
				Employee emp = (Employee)session.getAttribute("loginEmp");
				if(emp==null){
					JsonUtil.timeout2page(response);
					return;
				}
				
				String hql = "select u from UserInfo u where u.state = 0";
				
				List<Object> lst = databaseHelper.getResultListByHql(hql);
				
				JsonArray arr = JsonUtil.castLst2Arr4SingleTime(lst);
				
				JsonUtil.listToJson(arr, arr.size(), response);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	 
	 
	 @RequestMapping(method = RequestMethod.POST, value = "/adduser")
		public void adduser(HttpServletRequest request,HttpServletResponse response,HttpSession session){
			try {
				Employee emp = (Employee)session.getAttribute("loginEmp");
				if(emp==null){
					JsonUtil.timeout2page(response);
					return;
				}
				String name = request.getParameter("name");
				
				String hql = "select u from UserInfo u where u.state = 0 and u.name = '"+name+"'";
				
				List<Object> lst = databaseHelper.getResultListByHql(hql);
				
				if(lst.size()>0){
					JsonUtil.success2page(response, "{\"op\":\"-4000\"}");
					return;
				}
				
				UserInfo u = new UserInfo();
				u.setName(name);
				u.setState(0);
				u.setTime(new Date());
				
				databaseHelper.persistObject(u);
				JsonUtil.success2page(response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	 
	 @RequestMapping(method = RequestMethod.POST, value = "/deluser")
		@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
		public void deluser(HttpServletRequest request,HttpSession session,HttpServletResponse response){
			Employee emp = (Employee)session.getAttribute("loginEmp");
			if(emp==null){
				JsonUtil.timeout2page(response);
				return;
			}
			
			
			try {
				String uid = request.getParameter("uid");
				
				UserInfo u = (UserInfo)databaseHelper.getObjectById(UserInfo.class, Long.parseLong(uid));
				u.setState(-1);
				databaseHelper.updateObject(u);
				
				JsonUtil.success2page(response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				String mess = e.getMessage();
				JsonUtil.success2page(response,"{\"op\":\""+mess+"\"}");
				e.printStackTrace();
			}
		}
	 
	 
	 @RequestMapping(method = RequestMethod.POST, value = "/queryuser4dinner")
		@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
		public void queryuser4dinner(HttpServletRequest request,HttpSession session,HttpServletResponse response){
			Employee emp = (Employee)session.getAttribute("loginEmp");
			if(emp==null){
				JsonUtil.timeout2page(response);
				return;
			}
			
			
			try {
				String time = request.getParameter("time");
				String type = request.getParameter("type");
				
				int year = Integer.parseInt(time.split("-")[0]);
				int month = Integer.parseInt(time.split("-")[1]);
				int day = Integer.parseInt(time.split("-")[2]);
				
				String hql = "select u from UserInfo u where u.state = 0";
				
				List<Object> lst = databaseHelper.getResultListByHql(hql);
				
				String sql = "select d from Dinner d where  year(d.time)="+year+" and month(d.time)="+month+" and day(d.time)="+day+" and d.timetype ="+Integer.parseInt(type)+" and d.state = 0";
				List<Object> dlst = databaseHelper.getResultListByHql(sql);
				
				List<Map<String,Object>> lstMap = new ArrayList<Map<String,Object>>();
				
				for (Object object : lst) {
					Map<String,Object> map = new HashMap<String,Object>();
					UserInfo u = (UserInfo)object;
					boolean flag = false;
					for (Object obj : dlst) {
						Dinner d = (Dinner)obj;
						if(d.getFuserinfoid()==u.getId()){
							flag = true;
							break;
						}
					}
					map.put("name", u.getName());
					map.put("userinfoid", u.getId());
					if(flag)map.put("dinner", 1);
					else map.put("dinner", 0);
					
					lstMap.add(map);
				}
				
				
				JsonUtil.listToJson(lstMap, lstMap.size(), response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				String mess = e.getMessage();
				JsonUtil.success2page(response,"{\"op\":\""+mess+"\"}");
				e.printStackTrace();
			}
		}
	 
	 
	 
	 	@RequestMapping(method = RequestMethod.POST, value = "/saveuserinfo4dinner")
		@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
		public void saveuserinfo4dinner(HttpServletRequest request,HttpSession session,HttpServletResponse response){
			Employee emp = (Employee)session.getAttribute("loginEmp");
			if(emp==null){
				JsonUtil.timeout2page(response);
				return;
			}
			
			
			try {
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				
				String time = request.getParameter("time");
				String type = request.getParameter("type");
				String userinfoids = request.getParameter("userinfoids");
				
				int year = Integer.parseInt(time.split("-")[0]);
				int month = Integer.parseInt(time.split("-")[1]);
				int day = Integer.parseInt(time.split("-")[2]);
				
				
				String sql = "select d from Dinner d where  year(d.time)="+year+" and month(d.time)="+month+" and day(d.time)="+day+" and d.timetype ="+Integer.parseInt(type)+" and d.state = 0";
				List<Object> dlst = databaseHelper.getResultListByHql(sql);
				
				Date t = sdf.parse(time);
				for (Object obj : dlst) {
						Dinner d = (Dinner)obj;
						d.setState(-1);
						databaseHelper.updateObject(d);
				}
				
				if(userinfoids.length()>0){
					if(userinfoids.indexOf(",")==-1){
						UserInfo u = (UserInfo)databaseHelper.getObjectById(UserInfo.class, Long.parseLong(userinfoids));
						Dinner d = new Dinner();
						d.setFuserinfoid(u.getId());
						d.setName(u.getName());
						d.setState(0);
						d.setTime(t);
						d.setTimetype(Integer.parseInt(type));
						databaseHelper.persistObject(d);
					}else{
						
						String [] userinfoid_arr = userinfoids.split(",");
						for (String s : userinfoid_arr) {
							UserInfo u = (UserInfo)databaseHelper.getObjectById(UserInfo.class, Long.parseLong(s));
							Dinner d = new Dinner();
							d.setFuserinfoid(u.getId());
							d.setName(u.getName());
							d.setState(0);
							d.setTime(t);
							d.setTimetype(Integer.parseInt(type));
							databaseHelper.persistObject(d);
						}
						
					}
				}
				
				JsonUtil.success2page(response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				String mess = e.getMessage();
				JsonUtil.success2page(response,"{\"op\":\""+mess+"\"}");
				e.printStackTrace();
			}
		}
	 	
	 	
	 	
	 	@RequestMapping(method = RequestMethod.POST, value = "/querydinner")
		@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
		public void querydinner(HttpServletRequest request,HttpSession session,HttpServletResponse response){
	 		Employee emp = (Employee)session.getAttribute("loginEmp");
			if(emp==null){
				JsonUtil.timeout2page(response);
				return;
			}
			
			try {
				int start = request.getParameter("page")==null?1:Integer.parseInt(request.getParameter("page"));
				int limit = request.getParameter("rows")==null?1:Integer.parseInt(request.getParameter("rows"));
				
				String starttime = request.getParameter("starttime");
				String endtime = request.getParameter("endtime");
				String timetype = request.getParameter("timetype");
				String name = request.getParameter("name");
				
				String hql = "select d from Dinner d where d.state = 0 ";
				
				if(starttime!=null&&starttime.length()>0){
					hql +=" and d.time >= '"+starttime+"'";
				}
				if(endtime!=null&&endtime.length()>0){
					hql +=" and d.time <= '"+endtime+"'";
				}
				if(timetype!=null&&Integer.parseInt(timetype)>0){
					hql +=" and d.timetype = "+Integer.parseInt(timetype)+"";
				}
				if(name!=null&&name.length()>0){
					hql +=" and d.name like '%"+name+"%'";
				}
				
				hql +=" order by d.time desc";
				
				List<Object> lst = databaseHelper.getResultListByHql(hql, start, limit);
				
				JsonArray arr = JsonUtil.castLst2Arr4Single(lst);
				
				hql = "select count(d.id) from Dinner d where d.state = 0 ";
				
				if(starttime!=null&&starttime.length()>0){
					hql +=" and d.time >= '"+starttime+"'";
				}
				if(endtime!=null&&endtime.length()>0){
					hql +=" and d.time <= '"+endtime+"'";
				}
				if(timetype!=null&&Integer.parseInt(timetype)>0){
					hql +=" and d.timetype = "+Integer.parseInt(timetype)+"";
				}
				if(name!=null&&name.length()>0){
					hql +=" and d.name like '%"+name+"%'";
				}
				
				
				List clst = databaseHelper.getResultListByHql(hql);
				
				int count  = Integer.parseInt(clst.get(0).toString());
				
				hql = "select s from SetMoney s where s.year="+Integer.parseInt(starttime.split("-")[0])+" and s.month="+Integer.parseInt(starttime.split("-")[1]);
				
				List<Object> slst = databaseHelper.getResultListByHql(hql);
				
				
				JsonObject obj = new JsonObject();
				obj.addProperty("total",count);
				obj.add("rows", arr);
				if(slst.size()>0){
					SetMoney s = ( SetMoney)slst.get(0);
					obj.addProperty("svgm", s.getSvgm());
					obj.addProperty("tm", s.getMoney());
				}
				response.setContentType("text/json; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println(obj.toString());
				out.close();
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
	 	}
	 	
	 	
	 	 @RequestMapping(method = RequestMethod.POST, value = "/addset")
	 	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
		public void addset(HttpServletRequest request,HttpServletResponse response,HttpSession session){
			try {
				Employee emp = (Employee)session.getAttribute("loginEmp");
				if(emp==null){
					JsonUtil.timeout2page(response);
					return;
				}
				String year = request.getParameter("year");
				String month = request.getParameter("month");
				String totalmoney = request.getParameter("totalmoney");
				
				String sql = "select count(d.id) from Dinner d where  year(d.time)="+year+" and month(d.time)="+month+" and d.state = 0";
				List clst = databaseHelper.getResultListByHql(sql);
				int count  = Integer.parseInt(clst.get(0).toString());
				
				String hql = "select s from SetMoney s where s.year="+Integer.parseInt(year)+" and s.month="+Integer.parseInt(month);
				
				List<Object> lst = databaseHelper.getResultListByHql(hql);
				
				
				
				if(lst.size()>0){
					SetMoney s = (SetMoney)lst.get(0);
					s.setMoney(Double.parseDouble(totalmoney));
					if(count>0)s.setSvgm(((new BigDecimal(totalmoney).divide(new BigDecimal(2))).divide(new BigDecimal(count),2,BigDecimal.ROUND_HALF_UP)).doubleValue());
					else s.setSvgm(0.0);
					databaseHelper.updateObject(s);
				}else{
					SetMoney s = new SetMoney();
					s.setMoney(Double.parseDouble(totalmoney));
					s.setMonth(Integer.parseInt(month));
					s.setYear(Integer.parseInt(year));
					s.setTime(new Date());
					if(count>0)s.setSvgm(((new BigDecimal(totalmoney).divide(new BigDecimal(2))).divide(new BigDecimal(count),2,BigDecimal.ROUND_HALF_UP)).doubleValue());
					else s.setSvgm(0.0);
					databaseHelper.persistObject(s);
				}
				JsonUtil.success2page(response);
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
}
