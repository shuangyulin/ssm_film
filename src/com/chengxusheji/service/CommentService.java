package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Movie;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Comment;

import com.chengxusheji.mapper.CommentMapper;
@Service
public class CommentService {

	@Resource CommentMapper commentMapper;
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

    /*添加影评记录*/
    public void addComment(Comment comment) throws Exception {
    	commentMapper.addComment(comment);
    }

    /*按照查询条件分页查询影评记录*/
    public ArrayList<Comment> queryComment(Movie movieObj,UserInfo userObj,String commentTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != movieObj && movieObj.getMovieId()!= null && movieObj.getMovieId()!= 0)  where += " and t_comment.movieObj=" + movieObj.getMovieId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_comment.userObj='" + userObj.getUser_name() + "'";
    	if(!commentTime.equals("")) where = where + " and t_comment.commentTime like '%" + commentTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return commentMapper.queryComment(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Comment> queryComment(Movie movieObj,UserInfo userObj,String commentTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != movieObj && movieObj.getMovieId()!= null && movieObj.getMovieId()!= 0)  where += " and t_comment.movieObj=" + movieObj.getMovieId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_comment.userObj='" + userObj.getUser_name() + "'";
    	if(!commentTime.equals("")) where = where + " and t_comment.commentTime like '%" + commentTime + "%'";
    	return commentMapper.queryCommentList(where);
    }

    /*查询所有影评记录*/
    public ArrayList<Comment> queryAllComment()  throws Exception {
        return commentMapper.queryCommentList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Movie movieObj,UserInfo userObj,String commentTime) throws Exception {
     	String where = "where 1=1";
    	if(null != movieObj && movieObj.getMovieId()!= null && movieObj.getMovieId()!= 0)  where += " and t_comment.movieObj=" + movieObj.getMovieId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_comment.userObj='" + userObj.getUser_name() + "'";
    	if(!commentTime.equals("")) where = where + " and t_comment.commentTime like '%" + commentTime + "%'";
        recordNumber = commentMapper.queryCommentCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取影评记录*/
    public Comment getComment(int commentId) throws Exception  {
        Comment comment = commentMapper.getComment(commentId);
        return comment;
    }

    /*更新影评记录*/
    public void updateComment(Comment comment) throws Exception {
        commentMapper.updateComment(comment);
    }

    /*删除一条影评记录*/
    public void deleteComment (int commentId) throws Exception {
        commentMapper.deleteComment(commentId);
    }

    /*删除多条影评信息*/
    public int deleteComments (String commentIds) throws Exception {
    	String _commentIds[] = commentIds.split(",");
    	for(String _commentId: _commentIds) {
    		commentMapper.deleteComment(Integer.parseInt(_commentId));
    	}
    	return _commentIds.length;
    }
}
