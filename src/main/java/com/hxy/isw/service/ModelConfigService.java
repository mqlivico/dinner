package com.hxy.isw.service;

import com.google.gson.JsonArray;

public interface ModelConfigService {
	public JsonArray findTables(String json);

	public int countTables(String json);
	
	public JsonArray findsome(String json, int start, int limit);

	public int countsome(String json);
}
