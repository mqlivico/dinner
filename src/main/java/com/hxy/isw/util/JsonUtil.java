package com.hxy.isw.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class JsonUtil {

	
	
	@SuppressWarnings("rawtypes")
	public static void listToJson(List lstMap,int count,HttpServletResponse response) throws IOException{
		
		String json = new Gson().toJson(lstMap);
		JsonArray arr = (JsonArray) new JsonParser().parse(json);
		JsonObject obj = new JsonObject();
		obj.addProperty("total",count);
		obj.add("rows", arr);
		response.setContentType("text/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println(obj.toString());
		out.close();
		
	}
	

	public static void objToJson(Object obj,HttpServletResponse response ) throws IOException{
		
		String json = new Gson().toJson(obj);
		PrintWriter pw = response.getWriter();
		if(pw!=null){
			pw.print(json.toString());
			pw.flush();
			pw.close();
		}

	}
	
	public static void mapToJson(Map<String , Object> map,HttpServletResponse response ) throws IOException{
		
		objToJson(map,response);
	
	}
	
	

	public static void listToJson(JsonArray arr,int count,HttpServletResponse response) throws IOException{
		JsonObject obj = new JsonObject();
		obj.addProperty("total",count);
		obj.add("rows", arr);
		response.setContentType("text/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println(obj.toString());
		out.close();
		
	}
	

	public static void success2page(HttpServletResponse response){
		
		PrintWriter out;
		try {
			out = response.getWriter();
			out.println("{\"op\":\"success\"}");
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	public static void noRight2page(HttpServletResponse response){
		
		PrintWriter out;
		try {
			out = response.getWriter();
			out.println("{\"op\":\"noright\"}");
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	public static void timeout2page(HttpServletResponse response){
		
		PrintWriter out;
		try {
			out = response.getWriter();
			out.println("{\"op\":\"timeout\"}");
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	public static void success2page(HttpServletResponse response,String json){
		
		PrintWriter out;
		try {
			out = response.getWriter();
			out.print(json);
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	public static void success2page(PrintWriter out){
		out.println("{\"op\":\"success\"}");
		out.close();
	}
	
	private static JsonParser jsonParser = null;
	private static Gson gson = null;
	public static JsonParser getJsonParser(){
		if(jsonParser==null)jsonParser = new JsonParser();
		return jsonParser;
	}
	public static Gson getGson(){
		if(gson==null){
			GsonBuilder gsonBuilder = new GsonBuilder(); 
			gsonBuilder.setDateFormat("yyyy-MM-dd");// HH:mm:ss  
			gsonBuilder.registerTypeAdapter(Timestamp.class,new TimestampTypeAdapter());  
			gson = gsonBuilder.create();
		}
		return gson;
	}
	
	public static void castGson2Time(){
		GsonBuilder gsonBuilder = new GsonBuilder(); 
		gsonBuilder.setDateFormat("yyyy-MM-dd hh:mm:ss");// HH:mm:ss  
		gsonBuilder.registerTypeAdapter(Timestamp.class,new TimestampTypeAdapterTime());  
		gson = gsonBuilder.create();
	}
	
	public static void reGson(){
		GsonBuilder gsonBuilder = new GsonBuilder(); 
		gsonBuilder.setDateFormat("yyyy-MM-dd");// HH:mm:ss  
		gsonBuilder.registerTypeAdapter(Timestamp.class,new TimestampTypeAdapter());  
		gson = gsonBuilder.create();
	}
	
	@SuppressWarnings("rawtypes")
	public static String castObject2Json(Object obj,Class xclass){
		return getGson().toJson(obj,xclass);
	}
	
	public static JsonObject castString2Object(String json){
		return (JsonObject) getJsonParser().parse(json);
	}
	
	public static JsonObject castObjs2JsonObject(Object...objs){
		JsonObject jsonObject = new JsonObject();
		for (Object obj : objs) {
			if(obj==null)continue;
			String className = obj.getClass().getSimpleName();
			String perprotyName = (className.charAt(0)+"").toLowerCase()+className.substring(1, className.length());
			JsonObject jsonObj = castString2Object(castObject2Json(obj, obj.getClass()));
			if(jsonObject.get(perprotyName)==null){
				jsonObject.add(perprotyName, jsonObj);
			}else if(jsonObject.get(perprotyName+1)==null){
				jsonObject.add(perprotyName+1, jsonObj);
			}else{
				jsonObject.add(perprotyName+2, jsonObj);
			}
		}
		return jsonObject;
	}
	
	public static JsonArray castLst2Arr(List<Object[]> lst){
		JsonArray arr = new JsonArray();
		if( lst != null && lst.size()>0 ){
			for (Object[] objs: lst) {
				JsonObject jsonObject = castObjs2JsonObject(objs);
				arr.add(jsonObject);
			}
		}
		return arr;
	}
	
	public static JsonArray castLst2ArrTime(List<Object[]> lst){
		castGson2Time();
		JsonArray arr = new JsonArray();
		if( lst != null && lst.size()>0 ){
			for (Object[] objs: lst) {
				JsonObject jsonObject = castObjs2JsonObject(objs);
				arr.add(jsonObject);
			}
		}
		reGson();
		return arr;
	}
	
	public static JsonArray castLst2Arr4Single(List<Object> lst){
		JsonArray arr = new JsonArray();
		if( lst != null && lst.size()>0 ){
			for (Object obj: lst) {
				JsonObject jsonObject = castObjs2JsonObject(obj);
				arr.add(jsonObject);
			}
		}
		return arr;
	}
	
	public static JsonArray castLst2Arr4SingleTime(List<Object> lst){
		castGson2Time();
		JsonArray arr = new JsonArray();
		if( lst != null && lst.size()>0 ){
			for (Object obj: lst) {
				JsonObject jsonObject = castObjs2JsonObject(obj);
				arr.add(jsonObject);
			}
		}
		reGson();
		return arr;
	}
	
	
	
}

