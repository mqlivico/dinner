package com.hxy.isw.control;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.hxy.isw.thread.ReflushAccessToken;
import com.hxy.isw.util.ConstantUtil;
import com.hxy.isw.util.DatabaseHelper;



@Controller
public class IndexControl {
	
	@Autowired
	DatabaseHelper databaseHelper;
	
	@PostConstruct
	public void init() throws Exception{
		//System.out.println(MD5.JM("123456"));
		String path = this.getClass().getResource("/").getPath();
	
		initialize();
		
		//ConstantUtil.PROJECT_PATH = readconfig("prjpath");
		
		//ConstantUtil.PROJECT_PATH = path;//TODO delete when is publish
		/*ReflushAccessToken rat = new ReflushAccessToken();
		Thread t = new Thread(rat);
		t.start();*/
		
	}
	
	@PreDestroy
	public void destroy(){
		
	}
	
	
	private void  initialize(){
	
		
//		MsgHandle.mydatabaseHelper = databaseHelper;
//		MsgBase.mydatabaseHelper = databaseHelper;
//		MsgBodyMsg2Wx.mydatabaseHelper = databaseHelper;
//		MsgBodyMsgAgetCus.mydatabaseHelper = databaseHelper;
//		MsgBodyMsgAchg2otherA.mydatabaseHelper = databaseHelper;
		
	}
	
	
	private String readconfig(String filename){
		//String path = ConstantUtil.PROJECT_PATH.replace("WEB-INF/classes/", "");
		String path = ConstantUtil.PROJECT_PATH+filename+".txt";
		
	
		File file = new File(path );
		System.out.println("before if ......"+path );
		try {
			if (file.exists()) {
				
				System.out.println("after if ......"+path);
				BufferedReader b = new BufferedReader(new FileReader(file));
				 String ss= "";	
					String s = "";
					do {

						s += ss;
						

					} while ((ss = b.readLine())!= null);
					System.out.println("s............."+s);
				return s;
			} 
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
}
