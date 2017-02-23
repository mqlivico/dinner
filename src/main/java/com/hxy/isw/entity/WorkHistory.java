package com.hxy.isw.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

//工作经历表
@Entity
@Table(name="workhistory")
public class WorkHistory {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private Long id;
	
	
	@Column(name="f_retireinfo_id")
	private Long retireinfoId;
	
	@Column(name="workdesc")
	private String workdesc;
	
	
	@Column(name="starttime")
	private Date starttime;
	
	@Column(name="endtime")
	private Date  endtime;
	
	@Column(name="createtime")
	private Date createtime;
	

	@Column(name="state")
	private int state;


	@Column(name="starttime_year")
	private String starttimeYear;
	
	@Column(name="starttime_month")
	private String starttimeMonth;
	
	@Column(name="endtime_year")
	private String endtimeYear;
	
	@Column(name="endtime_month")
	private String endtimeMonth;
	
	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public Long getRetireinfoId() {
		return retireinfoId;
	}


	public void setRetireinfoId(Long retireinfoId) {
		this.retireinfoId = retireinfoId;
	}


	public String getWorkdesc() {
		return workdesc;
	}


	public void setWorkdesc(String workdesc) {
		this.workdesc = workdesc;
	}


	public Date getStarttime() {
		return starttime;
	}


	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}


	public Date getEndtime() {
		return endtime;
	}


	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}


	public Date getCreatetime() {
		return createtime;
	}


	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}


	public int getState() {
		return state;
	}


	public void setState(int state) {
		this.state = state;
	}


	public String getStarttimeYear() {
		return starttimeYear;
	}


	public void setStarttimeYear(String starttimeYear) {
		this.starttimeYear = starttimeYear;
	}


	public String getStarttimeMonth() {
		return starttimeMonth;
	}


	public void setStarttimeMonth(String starttimeMonth) {
		this.starttimeMonth = starttimeMonth;
	}


	public String getEndtimeYear() {
		return endtimeYear;
	}


	public void setEndtimeYear(String endtimeYear) {
		this.endtimeYear = endtimeYear;
	}


	public String getEndtimeMonth() {
		return endtimeMonth;
	}


	public void setEndtimeMonth(String endtimeMonth) {
		this.endtimeMonth = endtimeMonth;
	}
	
	
	
}
