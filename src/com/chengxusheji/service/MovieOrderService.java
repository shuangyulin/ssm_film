package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Schedule;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.MovieOrder;

import com.chengxusheji.mapper.MovieOrderMapper;
@Service
public class MovieOrderService {

	@Resource MovieOrderMapper movieOrderMapper;
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

    /*添加订票记录*/
    public void addMovieOrder(MovieOrder movieOrder) throws Exception {
    	movieOrderMapper.addMovieOrder(movieOrder);
    }

    /*按照查询条件分页查询订票记录*/
    public ArrayList<MovieOrder> queryMovieOrder(Schedule scheduleObj,UserInfo userObj,String orderTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != scheduleObj && scheduleObj.getScheduleId()!= null && scheduleObj.getScheduleId()!= 0)  where += " and t_movieOrder.scheduleObj=" + scheduleObj.getScheduleId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_movieOrder.userObj='" + userObj.getUser_name() + "'";
    	if(!orderTime.equals("")) where = where + " and t_movieOrder.orderTime like '%" + orderTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return movieOrderMapper.queryMovieOrder(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<MovieOrder> queryMovieOrder(Schedule scheduleObj,UserInfo userObj,String orderTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != scheduleObj && scheduleObj.getScheduleId()!= null && scheduleObj.getScheduleId()!= 0)  where += " and t_movieOrder.scheduleObj=" + scheduleObj.getScheduleId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_movieOrder.userObj='" + userObj.getUser_name() + "'";
    	if(!orderTime.equals("")) where = where + " and t_movieOrder.orderTime like '%" + orderTime + "%'";
    	return movieOrderMapper.queryMovieOrderList(where);
    }

    /*查询所有订票记录*/
    public ArrayList<MovieOrder> queryAllMovieOrder()  throws Exception {
        return movieOrderMapper.queryMovieOrderList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Schedule scheduleObj,UserInfo userObj,String orderTime) throws Exception {
     	String where = "where 1=1";
    	if(null != scheduleObj && scheduleObj.getScheduleId()!= null && scheduleObj.getScheduleId()!= 0)  where += " and t_movieOrder.scheduleObj=" + scheduleObj.getScheduleId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_movieOrder.userObj='" + userObj.getUser_name() + "'";
    	if(!orderTime.equals("")) where = where + " and t_movieOrder.orderTime like '%" + orderTime + "%'";
        recordNumber = movieOrderMapper.queryMovieOrderCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取订票记录*/
    public MovieOrder getMovieOrder(int orderId) throws Exception  {
        MovieOrder movieOrder = movieOrderMapper.getMovieOrder(orderId);
        return movieOrder;
    }

    /*更新订票记录*/
    public void updateMovieOrder(MovieOrder movieOrder) throws Exception {
        movieOrderMapper.updateMovieOrder(movieOrder);
    }

    /*删除一条订票记录*/
    public void deleteMovieOrder (int orderId) throws Exception {
        movieOrderMapper.deleteMovieOrder(orderId);
    }

    /*删除多条订票信息*/
    public int deleteMovieOrders (String orderIds) throws Exception {
    	String _orderIds[] = orderIds.split(",");
    	for(String _orderId: _orderIds) {
    		movieOrderMapper.deleteMovieOrder(Integer.parseInt(_orderId));
    	}
    	return _orderIds.length;
    }
}
