package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.MovieHall;

public interface MovieHallMapper {
	/*添加影厅信息*/
	public void addMovieHall(MovieHall movieHall) throws Exception;

	/*按照查询条件分页查询影厅记录*/
	public ArrayList<MovieHall> queryMovieHall(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有影厅记录*/
	public ArrayList<MovieHall> queryMovieHallList(@Param("where") String where) throws Exception;

	/*按照查询条件的影厅记录数*/
	public int queryMovieHallCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条影厅记录*/
	public MovieHall getMovieHall(int movieHallId) throws Exception;

	/*更新影厅记录*/
	public void updateMovieHall(MovieHall movieHall) throws Exception;

	/*删除影厅记录*/
	public void deleteMovieHall(int movieHallId) throws Exception;

}
