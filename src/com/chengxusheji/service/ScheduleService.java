package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Movie;
import com.chengxusheji.po.MovieHall;
import com.chengxusheji.po.Schedule;

import com.chengxusheji.mapper.ScheduleMapper;
@Service
public class ScheduleService {

	@Resource ScheduleMapper scheduleMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加档期计划记录*/
    public void addSchedule(Schedule schedule) throws Exception {
    	scheduleMapper.addSchedule(schedule);
    }

    /*按照查询条件分页查询档期计划记录*/
    public ArrayList<Schedule> querySchedule(Movie movieObj,MovieHall hallObj,String scheduleDate,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != movieObj && movieObj.getMovieId()!= null && movieObj.getMovieId()!= 0)  where += " and t_schedule.movieObj=" + movieObj.getMovieId();
    	if(null != hallObj && hallObj.getMovieHallId()!= null && hallObj.getMovieHallId()!= 0)  where += " and t_schedule.hallObj=" + hallObj.getMovieHallId();
    	if(!scheduleDate.equals("")) where = where + " and t_schedule.scheduleDate like '%" + scheduleDate + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return scheduleMapper.querySchedule(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Schedule> querySchedule(Movie movieObj,MovieHall hallObj,String scheduleDate) throws Exception  { 
     	String where = "where 1=1";
    	if(null != movieObj && movieObj.getMovieId()!= null && movieObj.getMovieId()!= 0)  where += " and t_schedule.movieObj=" + movieObj.getMovieId();
    	if(null != hallObj && hallObj.getMovieHallId()!= null && hallObj.getMovieHallId()!= 0)  where += " and t_schedule.hallObj=" + hallObj.getMovieHallId();
    	if(!scheduleDate.equals("")) where = where + " and t_schedule.scheduleDate like '%" + scheduleDate + "%'";
    	return scheduleMapper.queryScheduleList(where);
    }

    /*查询所有档期计划记录*/
    public ArrayList<Schedule> queryAllSchedule()  throws Exception {
        return scheduleMapper.queryScheduleList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Movie movieObj,MovieHall hallObj,String scheduleDate) throws Exception {
     	String where = "where 1=1";
    	if(null != movieObj && movieObj.getMovieId()!= null && movieObj.getMovieId()!= 0)  where += " and t_schedule.movieObj=" + movieObj.getMovieId();
    	if(null != hallObj && hallObj.getMovieHallId()!= null && hallObj.getMovieHallId()!= 0)  where += " and t_schedule.hallObj=" + hallObj.getMovieHallId();
    	if(!scheduleDate.equals("")) where = where + " and t_schedule.scheduleDate like '%" + scheduleDate + "%'";
        recordNumber = scheduleMapper.queryScheduleCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取档期计划记录*/
    public Schedule getSchedule(int scheduleId) throws Exception  {
        Schedule schedule = scheduleMapper.getSchedule(scheduleId);
        return schedule;
    }

    /*更新档期计划记录*/
    public void updateSchedule(Schedule schedule) throws Exception {
        scheduleMapper.updateSchedule(schedule);
    }

    /*删除一条档期计划记录*/
    public void deleteSchedule (int scheduleId) throws Exception {
        scheduleMapper.deleteSchedule(scheduleId);
    }

    /*删除多条档期计划信息*/
    public int deleteSchedules (String scheduleIds) throws Exception {
    	String _scheduleIds[] = scheduleIds.split(",");
    	for(String _scheduleId: _scheduleIds) {
    		scheduleMapper.deleteSchedule(Integer.parseInt(_scheduleId));
    	}
    	return _scheduleIds.length;
    }
}
