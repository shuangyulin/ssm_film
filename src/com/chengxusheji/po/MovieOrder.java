package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class MovieOrder {
    /*订票id*/
    private Integer orderId;
    public Integer getOrderId(){
        return orderId;
    }
    public void setOrderId(Integer orderId){
        this.orderId = orderId;
    }

    /*档期*/
    private Schedule scheduleObj;
    public Schedule getScheduleObj() {
        return scheduleObj;
    }
    public void setScheduleObj(Schedule scheduleObj) {
        this.scheduleObj = scheduleObj;
    }

    /*座位行号*/
    @NotNull(message="必须输入座位行号")
    private Integer rowsIndex;
    public Integer getRowsIndex() {
        return rowsIndex;
    }
    public void setRowsIndex(Integer rowsIndex) {
        this.rowsIndex = rowsIndex;
    }

    /*座位列号*/
    @NotNull(message="必须输入座位列号")
    private Integer cols;
    public Integer getCols() {
        return cols;
    }
    public void setCols(Integer cols) {
        this.cols = cols;
    }

    /*票价*/
    @NotNull(message="必须输入票价")
    private Float price;
    public Float getPrice() {
        return price;
    }
    public void setPrice(Float price) {
        this.price = price;
    }

    /*用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*预定时间*/
    private String orderTime;
    public String getOrderTime() {
        return orderTime;
    }
    public void setOrderTime(String orderTime) {
        this.orderTime = orderTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonMovieOrder=new JSONObject(); 
		jsonMovieOrder.accumulate("orderId", this.getOrderId());
		jsonMovieOrder.accumulate("scheduleObj", this.getScheduleObj().getScheduleId());
		jsonMovieOrder.accumulate("scheduleObjPri", this.getScheduleObj().getScheduleId());
		jsonMovieOrder.accumulate("rowsIndex", this.getRowsIndex());
		jsonMovieOrder.accumulate("cols", this.getCols());
		jsonMovieOrder.accumulate("price", this.getPrice());
		jsonMovieOrder.accumulate("userObj", this.getUserObj().getName());
		jsonMovieOrder.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonMovieOrder.accumulate("orderTime", this.getOrderTime());
		return jsonMovieOrder;
    }}