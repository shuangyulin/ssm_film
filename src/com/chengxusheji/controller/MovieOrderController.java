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
import com.chengxusheji.service.MovieOrderService;
import com.chengxusheji.po.MovieOrder;
import com.chengxusheji.service.ScheduleService;
import com.chengxusheji.po.Schedule;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//MovieOrder管理控制层
@Controller
@RequestMapping("/MovieOrder")
public class MovieOrderController extends BaseController {

    /*业务层对象*/
    @Resource MovieOrderService movieOrderService;

    @Resource ScheduleService scheduleService;
    @Resource UserInfoService userInfoService;
	@InitBinder("scheduleObj")
	public void initBinderscheduleObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("scheduleObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("movieOrder")
	public void initBinderMovieOrder(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("movieOrder.");
	}
	/*跳转到添加MovieOrder视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new MovieOrder());
		/*查询所有的Schedule信息*/
		List<Schedule> scheduleList = scheduleService.queryAllSchedule();
		request.setAttribute("scheduleList", scheduleList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "MovieOrder_add";
	}

	/*客户端ajax方式提交添加订票信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated MovieOrder movieOrder, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        movieOrderService.addMovieOrder(movieOrder);
        message = "订票添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询订票信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("scheduleObj") Schedule scheduleObj,@ModelAttribute("userObj") UserInfo userObj,String orderTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (orderTime == null) orderTime = "";
		if(rows != 0)movieOrderService.setRows(rows);
		List<MovieOrder> movieOrderList = movieOrderService.queryMovieOrder(scheduleObj, userObj, orderTime, page);
	    /*计算总的页数和总的记录数*/
	    movieOrderService.queryTotalPageAndRecordNumber(scheduleObj, userObj, orderTime);
	    /*获取到总的页码数目*/
	    int totalPage = movieOrderService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = movieOrderService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(MovieOrder movieOrder:movieOrderList) {
			JSONObject jsonMovieOrder = movieOrder.getJsonObject();
			jsonArray.put(jsonMovieOrder);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询订票信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<MovieOrder> movieOrderList = movieOrderService.queryAllMovieOrder();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(MovieOrder movieOrder:movieOrderList) {
			JSONObject jsonMovieOrder = new JSONObject();
			jsonMovieOrder.accumulate("orderId", movieOrder.getOrderId());
			jsonArray.put(jsonMovieOrder);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询订票信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("scheduleObj") Schedule scheduleObj,@ModelAttribute("userObj") UserInfo userObj,String orderTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (orderTime == null) orderTime = "";
		List<MovieOrder> movieOrderList = movieOrderService.queryMovieOrder(scheduleObj, userObj, orderTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    movieOrderService.queryTotalPageAndRecordNumber(scheduleObj, userObj, orderTime);
	    /*获取到总的页码数目*/
	    int totalPage = movieOrderService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = movieOrderService.getRecordNumber();
	    request.setAttribute("movieOrderList",  movieOrderList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("scheduleObj", scheduleObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("orderTime", orderTime);
	    List<Schedule> scheduleList = scheduleService.queryAllSchedule();
	    request.setAttribute("scheduleList", scheduleList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "MovieOrder/movieOrder_frontquery_result"; 
	}

     /*前台查询MovieOrder信息*/
	@RequestMapping(value="/{orderId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer orderId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键orderId获取MovieOrder对象*/
        MovieOrder movieOrder = movieOrderService.getMovieOrder(orderId);

        List<Schedule> scheduleList = scheduleService.queryAllSchedule();
        request.setAttribute("scheduleList", scheduleList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("movieOrder",  movieOrder);
        return "MovieOrder/movieOrder_frontshow";
	}

	/*ajax方式显示订票修改jsp视图页*/
	@RequestMapping(value="/{orderId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer orderId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键orderId获取MovieOrder对象*/
        MovieOrder movieOrder = movieOrderService.getMovieOrder(orderId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonMovieOrder = movieOrder.getJsonObject();
		out.println(jsonMovieOrder.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新订票信息*/
	@RequestMapping(value = "/{orderId}/update", method = RequestMethod.POST)
	public void update(@Validated MovieOrder movieOrder, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			movieOrderService.updateMovieOrder(movieOrder);
			message = "订票更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "订票更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除订票信息*/
	@RequestMapping(value="/{orderId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer orderId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  movieOrderService.deleteMovieOrder(orderId);
	            request.setAttribute("message", "订票删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "订票删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条订票记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String orderIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = movieOrderService.deleteMovieOrders(orderIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出订票信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("scheduleObj") Schedule scheduleObj,@ModelAttribute("userObj") UserInfo userObj,String orderTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(orderTime == null) orderTime = "";
        List<MovieOrder> movieOrderList = movieOrderService.queryMovieOrder(scheduleObj,userObj,orderTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "MovieOrder信息记录"; 
        String[] headers = { "订票id","档期","座位行号","座位列号","票价","用户","预定时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<movieOrderList.size();i++) {
        	MovieOrder movieOrder = movieOrderList.get(i); 
        	dataset.add(new String[]{movieOrder.getOrderId() + "",movieOrder.getScheduleObj().getScheduleId()+"",movieOrder.getRowsIndex() + "",movieOrder.getCols() + "",movieOrder.getPrice() + "",movieOrder.getUserObj().getName(),movieOrder.getOrderTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"MovieOrder.xls");//filename是下载的xls的名，建议最好用英文 
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
