package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Schedule {
    /*档期id*/
    private Integer scheduleId;
    public Integer getScheduleId(){
        return scheduleId;
    }
    public void setScheduleId(Integer scheduleId){
        this.scheduleId = scheduleId;
    }

    /*电影*/
    private Movie movieObj;
    public Movie getMovieObj() {
        return movieObj;
    }
    public void setMovieObj(Movie movieObj) {
        this.movieObj = movieObj;
    }

    /*播放影厅*/
    private MovieHall hallObj;
    public MovieHall getHallObj() {
        return hallObj;
    }
    public void setHallObj(MovieHall hallObj) {
        this.hallObj = hallObj;
    }

    /*放映日期*/
    @NotEmpty(message="放映日期不能为空")
    private String scheduleDate;
    public String getScheduleDate() {
        return scheduleDate;
    }
    public void setScheduleDate(String scheduleDate) {
        this.scheduleDate = scheduleDate;
    }

    /*放映时间*/
    @NotEmpty(message="放映时间不能为空")
    private String scheduleTime;
    public String getScheduleTime() {
        return scheduleTime;
    }
    public void setScheduleTime(String scheduleTime) {
        this.scheduleTime = scheduleTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonSchedule=new JSONObject(); 
		jsonSchedule.accumulate("scheduleId", this.getScheduleId());
		jsonSchedule.accumulate("movieObj", this.getMovieObj().getMovieName());
		jsonSchedule.accumulate("movieObjPri", this.getMovieObj().getMovieId());
		jsonSchedule.accumulate("hallObj", this.getHallObj().getMovieHallName());
		jsonSchedule.accumulate("hallObjPri", this.getHallObj().getMovieHallId());
		jsonSchedule.accumulate("scheduleDate", this.getScheduleDate().length()>19?this.getScheduleDate().substring(0,19):this.getScheduleDate());
		jsonSchedule.accumulate("scheduleTime", this.getScheduleTime());
		return jsonSchedule;
    }}