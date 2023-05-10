package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Movie {
    /*影片id*/
    private Integer movieId;
    public Integer getMovieId(){
        return movieId;
    }
    public void setMovieId(Integer movieId){
        this.movieId = movieId;
    }

    /*影片名称*/
    @NotEmpty(message="影片名称不能为空")
    private String movieName;
    public String getMovieName() {
        return movieName;
    }
    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    /*影片类型*/
    @NotEmpty(message="影片类型不能为空")
    private String movieType;
    public String getMovieType() {
        return movieType;
    }
    public void setMovieType(String movieType) {
        this.movieType = movieType;
    }

    /*影片图片*/
    private String moviePhoto;
    public String getMoviePhoto() {
        return moviePhoto;
    }
    public void setMoviePhoto(String moviePhoto) {
        this.moviePhoto = moviePhoto;
    }

    /*导演*/
    @NotEmpty(message="导演不能为空")
    private String director;
    public String getDirector() {
        return director;
    }
    public void setDirector(String director) {
        this.director = director;
    }

    /*主演*/
    @NotEmpty(message="主演不能为空")
    private String mainPerformer;
    public String getMainPerformer() {
        return mainPerformer;
    }
    public void setMainPerformer(String mainPerformer) {
        this.mainPerformer = mainPerformer;
    }

    /*时长*/
    @NotEmpty(message="时长不能为空")
    private String duration;
    public String getDuration() {
        return duration;
    }
    public void setDuration(String duration) {
        this.duration = duration;
    }

    /*地区*/
    @NotEmpty(message="地区不能为空")
    private String area;
    public String getArea() {
        return area;
    }
    public void setArea(String area) {
        this.area = area;
    }

    /*上映日期*/
    @NotEmpty(message="上映日期不能为空")
    private String releaseDate;
    public String getReleaseDate() {
        return releaseDate;
    }
    public void setReleaseDate(String releaseDate) {
        this.releaseDate = releaseDate;
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

    /*剧情*/
    @NotEmpty(message="剧情不能为空")
    private String opera;
    public String getOpera() {
        return opera;
    }
    public void setOpera(String opera) {
        this.opera = opera;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonMovie=new JSONObject(); 
		jsonMovie.accumulate("movieId", this.getMovieId());
		jsonMovie.accumulate("movieName", this.getMovieName());
		jsonMovie.accumulate("movieType", this.getMovieType());
		jsonMovie.accumulate("moviePhoto", this.getMoviePhoto());
		jsonMovie.accumulate("director", this.getDirector());
		jsonMovie.accumulate("mainPerformer", this.getMainPerformer());
		jsonMovie.accumulate("duration", this.getDuration());
		jsonMovie.accumulate("area", this.getArea());
		jsonMovie.accumulate("releaseDate", this.getReleaseDate().length()>19?this.getReleaseDate().substring(0,19):this.getReleaseDate());
		jsonMovie.accumulate("price", this.getPrice());
		jsonMovie.accumulate("opera", this.getOpera());
		return jsonMovie;
    }}