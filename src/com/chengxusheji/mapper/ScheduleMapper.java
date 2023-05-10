package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Schedule;

public interface ScheduleMapper {
	/*添加档期计划信息*/
	public void addSchedule(Schedule schedule) throws Exception;

	/*按照查询条件分页查询档期计划记录*/
	public ArrayList<Schedule> querySchedule(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有档期计划记录*/
	public ArrayList<Schedule> queryScheduleList(@Param("where") String where) throws Exception;

	/*按照查询条件的档期计划记录数*/
	public int queryScheduleCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条档期计划记录*/
	public Schedule getSchedule(int scheduleId) throws Exception;

	/*更新档期计划记录*/
	public void updateSchedule(Schedule schedule) throws Exception;

	/*删除档期计划记录*/
	public void deleteSchedule(int scheduleId) throws Exception;

}
