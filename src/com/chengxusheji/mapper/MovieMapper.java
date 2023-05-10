package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Movie;

public interface MovieMapper {
	/*添加影片信息*/
	public void addMovie(Movie movie) throws Exception;

	/*按照查询条件分页查询影片记录*/
	public ArrayList<Movie> queryMovie(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有影片记录*/
	public ArrayList<Movie> queryMovieList(@Param("where") String where) throws Exception;

	/*按照查询条件的影片记录数*/
	public int queryMovieCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条影片记录*/
	public Movie getMovie(int movieId) throws Exception;

	/*更新影片记录*/
	public void updateMovie(Movie movie) throws Exception;

	/*删除影片记录*/
	public void deleteMovie(int movieId) throws Exception;

}
