package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class MovieHall {
    /*影厅id*/
    private Integer movieHallId;
    public Integer getMovieHallId(){
        return movieHallId;
    }
    public void setMovieHallId(Integer movieHallId){
        this.movieHallId = movieHallId;
    }

    /*影厅名称*/
    @NotEmpty(message="影厅名称不能为空")
    private String movieHallName;
    public String getMovieHallName() {
        return movieHallName;
    }
    public void setMovieHallName(String movieHallName) {
        this.movieHallName = movieHallName;
    }

    /*座位排数*/
    @NotNull(message="必须输入座位排数")
    private Integer rows;
    public Integer getRows() {
        return rows;
    }
    public void setRows(Integer rows) {
        this.rows = rows;
    }

    /*座位列数*/
    @NotNull(message="必须输入座位列数")
    private Integer cols;
    public Integer getCols() {
        return cols;
    }
    public void setCols(Integer cols) {
        this.cols = cols;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonMovieHall=new JSONObject(); 
		jsonMovieHall.accumulate("movieHallId", this.getMovieHallId());
		jsonMovieHall.accumulate("movieHallName", this.getMovieHallName());
		jsonMovieHall.accumulate("rows", this.getRows());
		jsonMovieHall.accumulate("cols", this.getCols());
		return jsonMovieHall;
    }}