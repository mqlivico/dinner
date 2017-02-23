package com.hxy.isw.control;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hxy.isw.entity.Employee;
import com.hxy.isw.util.ConstantUtil;
import com.hxy.isw.util.DatabaseHelper;
import com.hxy.isw.util.JsonUtil;

@Controller
@RequestMapping("/isw")
public class IswControl {
	@Autowired
	DatabaseHelper databaseHelper;
	
	@RequestMapping(method = RequestMethod.GET, value = "/test")
	public void test(HttpServletRequest request,PrintWriter out) throws Exception{
		out.println("ok");
		out.close();
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/login")
	public String login(HttpSession session){
		if(session.getAttribute("loginEmp")==null){
			return "isw/login";
		}else{
			return "isw/index";
		}
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/doLogin")
	public void doLogin(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		String hql = "select emp from Employee emp where emp.username = '"+username+"'";
		List<Object> lst =  databaseHelper.getResultListByHql(hql);
		if(lst.size()==0){
			JsonUtil.success2page(response, "{\"status\":\"-1\",\"info\":\"用户名不存在\"}");
			return;
		}
		
		Employee emp = (Employee)lst.get(0);
		
		if(emp.getState()!=0){
			JsonUtil.success2page(response, "{\"status\":\"-1\",\"info\":\"此用户账号已被禁用\"}");
			return;
		}
		
		if(!emp.getPassword().equals(password)){
			JsonUtil.success2page(response, "{\"status\":\"-1\",\"info\":\"密码错误\"}");
			return;
		}
		
		session.setAttribute("loginEmp", emp);
		JsonUtil.success2page(response, "{\"status\":\"1\"}");
	}
	
	
	@RequestMapping(method = RequestMethod.GET, value = "/wlogin")
	public String wlogin(HttpSession session){
		if(session.getAttribute("loginEmp")==null){
			return "isw/login2";
		}else{
			return "isw/index2";
		}
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/msd")
	public String msd(HttpSession session){
		return "isw/msd";
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/outportretireinfo")
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	public void outportretireinfo(HttpServletRequest request,HttpSession session,HttpServletResponse response) throws Exception{
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date now = new Date();
		
		String time = sdf.format(now);
		
		int year = Integer.parseInt(time.split("-")[0]);
		int month = Integer.parseInt(time.split("-")[1]);
		
		if(month==5){
			//if(Integer.parseInt(time.split("-")[2])==20||Integer.parseInt(time.split("-")[2])==21||Integer.parseInt(time.split("-")[2])==22){
				Connection conn = getConnection("taskDB_"+year);
				String sql = "update taskdetail_"+month+" set duration = 0 where date(time) = curdate()";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.executeUpdate();
				
				close(conn,pstmt);
			//}
		}
		
		Connection conn = getConnection("taskDB_"+year);
		
		String sql = "select handphone,duration,time from taskdetail_"+month+" where date(time) = curdate()";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		ResultSet rs = pstmt.executeQuery();
		
		List<String[]> lst = new ArrayList<String[]>();
		
		
		while(rs.next()){
			
			
			String handphone = rs.getString(1);
			int duration = rs.getInt(2);
			String xtime = rs.getString(3);
			
			String[] strs = new String[3];
			strs[0] = handphone;
			strs[1] = duration+"";
			strs[2] = xtime;
			
			lst.add(strs);
		}
		
		close(conn,pstmt,rs);
		
		if(lst.size()==0){
			JsonUtil.success2page(response,"{\"op\":\"noexist\"}");
			return;
		}
		
		gen_excel(lst);
		
		JsonUtil.success2page(response);
	}
	
	private void gen_excel(List<String[]> lstObj){
		 HSSFWorkbook hssfworkbook = new HSSFWorkbook(); 
		 HSSFSheet sheet = hssfworkbook.createSheet("new sheet");
		 HSSFRow row = sheet.createRow(0);
		 int count = 0;
		
		 row.createCell(0).setCellValue("手机");
		 row.createCell(1).setCellValue("时长");
		 row.createCell(2).setCellValue("时间");
   	
		 int len = lstObj.size();
		
		for (int i = 0; i < len; i++) {
			String [] strs = lstObj.get(i);
			HSSFRow _row = sheet.createRow(++count);
			_row.createCell(0).setCellValue(strs[0]);
	        _row.createCell(1).setCellValue(strs[1]);
	        _row.createCell(2).setCellValue(strs[2]);
		}
	      //System.out.println("count:"+count);
	   /*   String path = ConstantUtil.PROJECT_PATH.replace("WEB-INF/classes/", "");
	      path = path + "html";*/
//   	  String path = ConstantUtil.PROJECT_PATH.replace("target/classes/","src/main/webapp/html/excel");
		String path = ConstantUtil.PROJECT_PATH.replace("WEB-INF/classes/", "excel/");//tomcat
//		String path = ConstantUtil.PROJECT_PATH.replace("target/classes/", "src/main/webapp/excel/");//maven
		File file = new File(path);
	      if( !file.exists() ){
	    	  file.mkdirs();
	      }
	      
	      path += "data_excel.xls";
	      
	      try {
			FileOutputStream fileoutputstream = new FileOutputStream(path);
			  hssfworkbook.write(fileoutputstream);
			  fileoutputstream.flush();
			  fileoutputstream.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/wdoLogin")
	public void wdoLogin(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		String hql = "select emp from Employee emp where emp.username = '"+username+"'";
		List<Object> lst =  databaseHelper.getResultListByHql(hql);
		if(lst.size()==0){
			JsonUtil.success2page(response, "{\"status\":\"-1\",\"info\":\"用户名不存在\"}");
			return;
		}
		
		Employee emp = (Employee)lst.get(0);
		
		if(emp.getState()!=0){
			JsonUtil.success2page(response, "{\"status\":\"-1\",\"info\":\"此用户账号已被禁用\"}");
			return;
		}
		
		if(!emp.getPassword().equals(password)){
			JsonUtil.success2page(response, "{\"status\":\"-1\",\"info\":\"密码错误\"}");
			return;
		}
		
		session.setAttribute("loginEmp", emp);
		JsonUtil.success2page(response, "{\"status\":\"1\"}");
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/index")
	public String index(HttpSession session){
		if(session.getAttribute("loginEmp")==null){
			return "redirect:/";
		}else{
			return "isw/index";
		}
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/error")
	public String error(HttpSession session){
		return "isw/error";
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/exit")
	public void exit(HttpSession session,PrintWriter out){
		session.removeAttribute("loginEmp");
		JsonUtil.success2page(out);
	}
	
	
	private static String driver = "com.mysql.jdbc.Driver";
	private static String url = "jdbc:mysql://121.41.102.173:3306/";
	private static String user = "root";
	private static String pwd = "bellatrix7";
	
	public static Connection getConnection(String database){
		Connection conn=null;
		try {
			
            Class.forName(driver);  
         
			conn = DriverManager.getConnection(url+database,user,pwd);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
		
	}
	
	public static void close(Connection conn,Statement stat,ResultSet rs){
		try {
			if(rs!=null){
				rs.close();
				rs=null;
			}
			if(stat!=null){
				stat.close();
				stat=null;
			}
			if(conn!=null){
				conn.close();
				conn=null;
			}
		} catch (SQLException e) {
				e.printStackTrace();
		}
		
	}
	
	public static void close(Connection conn,Statement stat){
		try {
			if(stat!=null){
				stat.close();
				stat=null;
			}
			if(conn!=null){
				conn.close();
				conn=null;
			}
		} catch (SQLException e) {
				e.printStackTrace();
		}
		
	}
}
