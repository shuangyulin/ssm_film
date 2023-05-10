package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Movie;

import com.chengxusheji.mapper.MovieMapper;
@Service
public class MovieService {

	@Resource MovieMapper movieMapper;
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

    /*添加影片记录*/
    public void addMovie(Movie movie) throws Exception {
    	movieMapper.addMovie(movie);
    }

    /*按照查询条件分页查询影片记录*/
    public ArrayList<Movie> queryMovie(String movieName,String movieType,String director,String area,String releaseDate,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!movieName.equals("")) where = where + " and t_movie.movieName like '%" + movieName + "%'";
    	if(!movieType.equals("")) where = where + " and t_movie.movieType like '%" + movieType + "%'";
    	if(!director.equals("")) where = where + " and t_movie.director like '%" + director + "%'";
    	if(!area.equals("")) where = where + " and t_movie.area like '%" + area + "%'";
    	if(!releaseDate.equals("")) where = where + " and t_movie.releaseDate like '%" + releaseDate + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return movieMapper.queryMovie(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Movie> queryMovie(String movieName,String movieType,String director,String area,String releaseDate) throws Exception  { 
     	String where = "where 1=1";
    	if(!movieName.equals("")) where = where + " and t_movie.movieName like '%" + movieName + "%'";
    	if(!movieType.equals("")) where = where + " and t_movie.movieType like '%" + movieType + "%'";
    	if(!director.equals("")) where = where + " and t_movie.director like '%" + director + "%'";
    	if(!area.equals("")) where = where + " and t_movie.area like '%" + area + "%'";
    	if(!releaseDate.equals("")) where = where + " and t_movie.releaseDate like '%" + releaseDate + "%'";
    	return movieMapper.queryMovieList(where);
    }

    /*查询所有影片记录*/
    public ArrayList<Movie> queryAllMovie()  throws Exception {
        return movieMapper.queryMovieList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String movieName,String movieType,String director,String area,String releaseDate) throws Exception {
     	String where = "where 1=1";
    	if(!movieName.equals("")) where = where + " and t_movie.movieName like '%" + movieName + "%'";
    	if(!movieType.equals("")) where = where + " and t_movie.movieType like '%" + movieType + "%'";
    	if(!director.equals("")) where = where + " and t_movie.director like '%" + director + "%'";
    	if(!area.equals("")) where = where + " and t_movie.area like '%" + area + "%'";
    	if(!releaseDate.equals("")) where = where + " and t_movie.releaseDate like '%" + releaseDate + "%'";
        recordNumber = movieMapper.queryMovieCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取影片记录*/
    public Movie getMovie(int movieId) throws Exception  {
        Movie movie = movieMapper.getMovie(movieId);
        return movie;
    }

    /*更新影片记录*/
    public void updateMovie(Movie movie) throws Exception {
        movieMapper.updateMovie(movie);
    }

    /*删除一条影片记录*/
    public void deleteMovie (int movieId) throws Exception {
        movieMapper.deleteMovie(movieId);
    }

    /*删除多条影片信息*/
    public int deleteMovies (String movieIds) throws Exception {
    	String _movieIds[] = movieIds.split(",");
    	for(String _movieId: _movieIds) {
    		movieMapper.deleteMovie(Integer.parseInt(_movieId));
    	}
    	return _movieIds.length;
    }
}
