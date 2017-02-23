package com.hxy.isw.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.hxy.isw.service.ModelConfigService;
import com.hxy.isw.util.DatabaseHelper;

@Repository
public class ModelConfigServiceImpl implements ModelConfigService {

	@Autowired
	DatabaseHelper databaseHelper;

	@SuppressWarnings("unchecked")
	public JsonArray findTables(String json) {
		JsonArray arr = new JsonArray();

		String sql = "select TABLE_NAME from information_schema.`TABLES` where TABLE_SCHEMA='isw'";
		List<Object> lst = databaseHelper.getResultListBySql(sql);
		for (Object obj : lst) {
			JsonObject jo = new JsonObject();
			jo.addProperty("name", obj.toString());
			arr.add(jo);
		}

		return arr;
	}
	
	public int countTables(String json){
		String sql = "select count(table_name) 'ct' from information_schema.`TABLES` where TABLE_SCHEMA='isw'";
		int count = Integer.parseInt(databaseHelper.getResultListBySql(sql).get(0).toString());
		return count;
	}

	@SuppressWarnings("unchecked")
	public JsonArray findsome(String json, int start, int limit) {
		JsonArray arr = new JsonArray();

		String sql = "select F_COMPANY_NAME,F_REMARK from tcompany";
		List<Object[]> lst = databaseHelper.getResultListBySql(sql, start,
				limit);
		for (Object[] objs : lst) {
			JsonObject jo = new JsonObject();
			jo.addProperty("name", objs[0].toString());
			if (objs[1] != null)
				jo.addProperty("remark", objs[1].toString());
			arr.add(jo);
		}

		return arr;
	}

	@SuppressWarnings("unchecked")
	public int countsome(String json) {
		int count = 0;
		String sql = "select count(fid) 'fid' from tcompany";
		List<Object> lst = databaseHelper.getResultListBySql(sql);
		count = Integer.parseInt(lst.get(0).toString());
		return count;
	}

}
