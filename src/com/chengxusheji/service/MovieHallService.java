package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.MovieHall;

import com.chengxusheji.mapper.MovieHallMapper;
@Service
public class MovieHallService {

	@Resource MovieHallMapper movieHallMapper;
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

    /*添加影厅记录*/
    public void addMovieHall(MovieHall movieHall) throws Exception {
    	movieHallMapper.addMovieHall(movieHall);
    }

    /*按照查询条件分页查询影厅记录*/
    public ArrayList<MovieHall> queryMovieHall(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return movieHallMapper.queryMovieHall(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<MovieHall> queryMovieHall() throws Exception  { 
     	String where = "where 1=1";
    	return movieHallMapper.queryMovieHallList(where);
    }

    /*查询所有影厅记录*/
    public ArrayList<MovieHall> queryAllMovieHall()  throws Exception {
        return movieHallMapper.queryMovieHallList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = movieHallMapper.queryMovieHallCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取影厅记录*/
    public MovieHall getMovieHall(int movieHallId) throws Exception  {
        MovieHall movieHall = movieHallMapper.getMovieHall(movieHallId);
        return movieHall;
    }

    /*更新影厅记录*/
    public void updateMovieHall(MovieHall movieHall) throws Exception {
        movieHallMapper.updateMovieHall(movieHall);
    }

    /*删除一条影厅记录*/
    public void deleteMovieHall (int movieHallId) throws Exception {
        movieHallMapper.deleteMovieHall(movieHallId);
    }

    /*删除多条影厅信息*/
    public int deleteMovieHalls (String movieHallIds) throws Exception {
    	String _movieHallIds[] = movieHallIds.split(",");
    	for(String _movieHallId: _movieHallIds) {
    		movieHallMapper.deleteMovieHall(Integer.parseInt(_movieHallId));
    	}
    	return _movieHallIds.length;
    }
}
