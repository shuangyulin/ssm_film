package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.MovieHallService;
import com.chengxusheji.po.MovieHall;

//MovieHall管理控制层
@Controller
@RequestMapping("/MovieHall")
public class MovieHallController extends BaseController {

    /*业务层对象*/
    @Resource MovieHallService movieHallService;

	@InitBinder("movieHall")
	public void initBinderMovieHall(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("movieHall.");
	}
	/*跳转到添加MovieHall视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new MovieHall());
		return "MovieHall_add";
	}

	/*客户端ajax方式提交添加影厅信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated MovieHall movieHall, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        movieHallService.addMovieHall(movieHall);
        message = "影厅添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询影厅信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)movieHallService.setRows(rows);
		List<MovieHall> movieHallList = movieHallService.queryMovieHall(page);
	    /*计算总的页数和总的记录数*/
	    movieHallService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = movieHallService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = movieHallService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(MovieHall movieHall:movieHallList) {
			JSONObject jsonMovieHall = movieHall.getJsonObject();
			jsonArray.put(jsonMovieHall);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询影厅信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<MovieHall> movieHallList = movieHallService.queryAllMovieHall();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(MovieHall movieHall:movieHallList) {
			JSONObject jsonMovieHall = new JSONObject();
			jsonMovieHall.accumulate("movieHallId", movieHall.getMovieHallId());
			jsonMovieHall.accumulate("movieHallName", movieHall.getMovieHallName());
			jsonArray.put(jsonMovieHall);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询影厅信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<MovieHall> movieHallList = movieHallService.queryMovieHall(currentPage);
	    /*计算总的页数和总的记录数*/
	    movieHallService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = movieHallService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = movieHallService.getRecordNumber();
	    request.setAttribute("movieHallList",  movieHallList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
		return "MovieHall/movieHall_frontquery_result"; 
	}

     /*前台查询MovieHall信息*/
	@RequestMapping(value="/{movieHallId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer movieHallId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键movieHallId获取MovieHall对象*/
        MovieHall movieHall = movieHallService.getMovieHall(movieHallId);

        request.setAttribute("movieHall",  movieHall);
        return "MovieHall/movieHall_frontshow";
	}

	/*ajax方式显示影厅修改jsp视图页*/
	@RequestMapping(value="/{movieHallId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer movieHallId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键movieHallId获取MovieHall对象*/
        MovieHall movieHall = movieHallService.getMovieHall(movieHallId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonMovieHall = movieHall.getJsonObject();
		out.println(jsonMovieHall.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新影厅信息*/
	@RequestMapping(value = "/{movieHallId}/update", method = RequestMethod.POST)
	public void update(@Validated MovieHall movieHall, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			movieHallService.updateMovieHall(movieHall);
			message = "影厅更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "影厅更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除影厅信息*/
	@RequestMapping(value="/{movieHallId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer movieHallId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  movieHallService.deleteMovieHall(movieHallId);
	            request.setAttribute("message", "影厅删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "影厅删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条影厅记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String movieHallIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = movieHallService.deleteMovieHalls(movieHallIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出影厅信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel( Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<MovieHall> movieHallList = movieHallService.queryMovieHall();
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "MovieHall信息记录"; 
        String[] headers = { "影厅id","影厅名称","座位排数","座位列数"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<movieHallList.size();i++) {
        	MovieHall movieHall = movieHallList.get(i); 
        	dataset.add(new String[]{movieHall.getMovieHallId() + "",movieHall.getMovieHallName(),movieHall.getRows() + "",movieHall.getCols() + ""});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"MovieHall.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
