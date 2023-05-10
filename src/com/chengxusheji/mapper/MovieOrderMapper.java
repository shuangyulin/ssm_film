package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.MovieOrder;

public interface MovieOrderMapper {
	/*添加订票信息*/
	public void addMovieOrder(MovieOrder movieOrder) throws Exception;

	/*按照查询条件分页查询订票记录*/
	public ArrayList<MovieOrder> queryMovieOrder(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有订票记录*/
	public ArrayList<MovieOrder> queryMovieOrderList(@Param("where") String where) throws Exception;

	/*按照查询条件的订票记录数*/
	public int queryMovieOrderCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条订票记录*/
	public MovieOrder getMovieOrder(int orderId) throws Exception;

	/*更新订票记录*/
	public void updateMovieOrder(MovieOrder movieOrder) throws Exception;

	/*删除订票记录*/
	public void deleteMovieOrder(int orderId) throws Exception;

}
