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
import com.chengxusheji.service.ScheduleService;
import com.chengxusheji.po.Schedule;
import com.chengxusheji.service.MovieService;
import com.chengxusheji.po.Movie;
import com.chengxusheji.service.MovieHallService;
import com.chengxusheji.po.MovieHall;

//Schedule管理控制层
@Controller
@RequestMapping("/Schedule")
public class ScheduleController extends BaseController {

    /*业务层对象*/
    @Resource ScheduleService scheduleService;

    @Resource MovieService movieService;
    @Resource MovieHallService movieHallService;
	@InitBinder("movieObj")
	public void initBindermovieObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("movieObj.");
	}
	@InitBinder("hallObj")
	public void initBinderhallObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("hallObj.");
	}
	@InitBinder("schedule")
	public void initBinderSchedule(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("schedule.");
	}
	/*跳转到添加Schedule视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Schedule());
		/*查询所有的Movie信息*/
		List<Movie> movieList = movieService.queryAllMovie();
		request.setAttribute("movieList", movieList);
		/*查询所有的MovieHall信息*/
		List<MovieHall> movieHallList = movieHallService.queryAllMovieHall();
		request.setAttribute("movieHallList", movieHallList);
		return "Schedule_add";
	}

	/*客户端ajax方式提交添加档期计划信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Schedule schedule, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        scheduleService.addSchedule(schedule);
        message = "档期计划添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询档期计划信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("movieObj") Movie movieObj,@ModelAttribute("hallObj") MovieHall hallObj,String scheduleDate,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (scheduleDate == null) scheduleDate = "";
		if(rows != 0)scheduleService.setRows(rows);
		List<Schedule> scheduleList = scheduleService.querySchedule(movieObj, hallObj, scheduleDate, page);
	    /*计算总的页数和总的记录数*/
	    scheduleService.queryTotalPageAndRecordNumber(movieObj, hallObj, scheduleDate);
	    /*获取到总的页码数目*/
	    int totalPage = scheduleService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = scheduleService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Schedule schedule:scheduleList) {
			JSONObject jsonSchedule = schedule.getJsonObject();
			jsonArray.put(jsonSchedule);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询档期计划信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Schedule> scheduleList = scheduleService.queryAllSchedule();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Schedule schedule:scheduleList) {
			JSONObject jsonSchedule = new JSONObject();
			jsonSchedule.accumulate("scheduleId", schedule.getScheduleId());
			jsonArray.put(jsonSchedule);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询档期计划信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("movieObj") Movie movieObj,@ModelAttribute("hallObj") MovieHall hallObj,String scheduleDate,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (scheduleDate == null) scheduleDate = "";
		List<Schedule> scheduleList = scheduleService.querySchedule(movieObj, hallObj, scheduleDate, currentPage);
	    /*计算总的页数和总的记录数*/
	    scheduleService.queryTotalPageAndRecordNumber(movieObj, hallObj, scheduleDate);
	    /*获取到总的页码数目*/
	    int totalPage = scheduleService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = scheduleService.getRecordNumber();
	    request.setAttribute("scheduleList",  scheduleList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("movieObj", movieObj);
	    request.setAttribute("hallObj", hallObj);
	    request.setAttribute("scheduleDate", scheduleDate);
	    List<Movie> movieList = movieService.queryAllMovie();
	    request.setAttribute("movieList", movieList);
	    List<MovieHall> movieHallList = movieHallService.queryAllMovieHall();
	    request.setAttribute("movieHallList", movieHallList);
		return "Schedule/schedule_frontquery_result"; 
	}

     /*前台查询Schedule信息*/
	@RequestMapping(value="/{scheduleId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer scheduleId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键scheduleId获取Schedule对象*/
        Schedule schedule = scheduleService.getSchedule(scheduleId);

        List<Movie> movieList = movieService.queryAllMovie();
        request.setAttribute("movieList", movieList);
        List<MovieHall> movieHallList = movieHallService.queryAllMovieHall();
        request.setAttribute("movieHallList", movieHallList);
        request.setAttribute("schedule",  schedule);
        return "Schedule/schedule_frontshow";
	}

	/*ajax方式显示档期计划修改jsp视图页*/
	@RequestMapping(value="/{scheduleId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer scheduleId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键scheduleId获取Schedule对象*/
        Schedule schedule = scheduleService.getSchedule(scheduleId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonSchedule = schedule.getJsonObject();
		out.println(jsonSchedule.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新档期计划信息*/
	@RequestMapping(value = "/{scheduleId}/update", method = RequestMethod.POST)
	public void update(@Validated Schedule schedule, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			scheduleService.updateSchedule(schedule);
			message = "档期计划更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "档期计划更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除档期计划信息*/
	@RequestMapping(value="/{scheduleId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer scheduleId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  scheduleService.deleteSchedule(scheduleId);
	            request.setAttribute("message", "档期计划删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "档期计划删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条档期计划记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String scheduleIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = scheduleService.deleteSchedules(scheduleIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出档期计划信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("movieObj") Movie movieObj,@ModelAttribute("hallObj") MovieHall hallObj,String scheduleDate, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(scheduleDate == null) scheduleDate = "";
        List<Schedule> scheduleList = scheduleService.querySchedule(movieObj,hallObj,scheduleDate);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Schedule信息记录"; 
        String[] headers = { "档期id","电影","播放影厅","放映日期","放映时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<scheduleList.size();i++) {
        	Schedule schedule = scheduleList.get(i); 
        	dataset.add(new String[]{schedule.getScheduleId() + "",schedule.getMovieObj().getMovieName(),schedule.getHallObj().getMovieHallName(),schedule.getScheduleDate(),schedule.getScheduleTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Schedule.xls");//filename是下载的xls的名，建议最好用英文 
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
