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
import com.chengxusheji.service.MovieService;
import com.chengxusheji.po.Movie;

//Movie管理控制层
@Controller
@RequestMapping("/Movie")
public class MovieController extends BaseController {

    /*业务层对象*/
    @Resource MovieService movieService;

	@InitBinder("movie")
	public void initBinderMovie(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("movie.");
	}
	/*跳转到添加Movie视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Movie());
		return "Movie_add";
	}

	/*客户端ajax方式提交添加影片信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Movie movie, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			movie.setMoviePhoto(this.handlePhotoUpload(request, "moviePhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        movieService.addMovie(movie);
        message = "影片添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询影片信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String movieName,String movieType,String director,String area,String releaseDate,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (movieName == null) movieName = "";
		if (movieType == null) movieType = "";
		if (director == null) director = "";
		if (area == null) area = "";
		if (releaseDate == null) releaseDate = "";
		if(rows != 0)movieService.setRows(rows);
		List<Movie> movieList = movieService.queryMovie(movieName, movieType, director, area, releaseDate, page);
	    /*计算总的页数和总的记录数*/
	    movieService.queryTotalPageAndRecordNumber(movieName, movieType, director, area, releaseDate);
	    /*获取到总的页码数目*/
	    int totalPage = movieService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = movieService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Movie movie:movieList) {
			JSONObject jsonMovie = movie.getJsonObject();
			jsonArray.put(jsonMovie);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询影片信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Movie> movieList = movieService.queryAllMovie();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Movie movie:movieList) {
			JSONObject jsonMovie = new JSONObject();
			jsonMovie.accumulate("movieId", movie.getMovieId());
			jsonMovie.accumulate("movieName", movie.getMovieName());
			jsonArray.put(jsonMovie);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询影片信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String movieName,String movieType,String director,String area,String releaseDate,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (movieName == null) movieName = "";
		if (movieType == null) movieType = "";
		if (director == null) director = "";
		if (area == null) area = "";
		if (releaseDate == null) releaseDate = "";
		List<Movie> movieList = movieService.queryMovie(movieName, movieType, director, area, releaseDate, currentPage);
	    /*计算总的页数和总的记录数*/
	    movieService.queryTotalPageAndRecordNumber(movieName, movieType, director, area, releaseDate);
	    /*获取到总的页码数目*/
	    int totalPage = movieService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = movieService.getRecordNumber();
	    request.setAttribute("movieList",  movieList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("movieName", movieName);
	    request.setAttribute("movieType", movieType);
	    request.setAttribute("director", director);
	    request.setAttribute("area", area);
	    request.setAttribute("releaseDate", releaseDate);
		return "Movie/movie_frontquery_result"; 
	}

     /*前台查询Movie信息*/
	@RequestMapping(value="/{movieId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer movieId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键movieId获取Movie对象*/
        Movie movie = movieService.getMovie(movieId);

        request.setAttribute("movie",  movie);
        return "Movie/movie_frontshow";
	}

	/*ajax方式显示影片修改jsp视图页*/
	@RequestMapping(value="/{movieId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer movieId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键movieId获取Movie对象*/
        Movie movie = movieService.getMovie(movieId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonMovie = movie.getJsonObject();
		out.println(jsonMovie.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新影片信息*/
	@RequestMapping(value = "/{movieId}/update", method = RequestMethod.POST)
	public void update(@Validated Movie movie, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String moviePhotoFileName = this.handlePhotoUpload(request, "moviePhotoFile");
		if(!moviePhotoFileName.equals("upload/NoImage.jpg"))movie.setMoviePhoto(moviePhotoFileName); 


		try {
			movieService.updateMovie(movie);
			message = "影片更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "影片更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除影片信息*/
	@RequestMapping(value="/{movieId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer movieId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  movieService.deleteMovie(movieId);
	            request.setAttribute("message", "影片删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "影片删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条影片记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String movieIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = movieService.deleteMovies(movieIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出影片信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String movieName,String movieType,String director,String area,String releaseDate, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(movieName == null) movieName = "";
        if(movieType == null) movieType = "";
        if(director == null) director = "";
        if(area == null) area = "";
        if(releaseDate == null) releaseDate = "";
        List<Movie> movieList = movieService.queryMovie(movieName,movieType,director,area,releaseDate);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Movie信息记录"; 
        String[] headers = { "影片id","影片名称","影片类型","影片图片","导演","主演","时长","地区","上映日期","票价"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<movieList.size();i++) {
        	Movie movie = movieList.get(i); 
        	dataset.add(new String[]{movie.getMovieId() + "",movie.getMovieName(),movie.getMovieType(),movie.getMoviePhoto(),movie.getDirector(),movie.getMainPerformer(),movie.getDuration(),movie.getArea(),movie.getReleaseDate(),movie.getPrice() + ""});
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
			response.setHeader("Content-disposition","attachment; filename="+"Movie.xls");//filename是下载的xls的名，建议最好用英文 
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
