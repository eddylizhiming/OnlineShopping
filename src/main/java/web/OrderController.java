package web;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;

import domain.Order;
import service.OrderService;
import tool.Page;

@Controller
@SessionAttributes("orders")
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	@ModelAttribute()
	public Order getOrder()
	{
		return new Order();
	}
	@RequestMapping(value="manage")
	public String forwardOrderManage(ModelMap modelMap,@RequestParam(defaultValue="1") int pageNo,
			@RequestParam(defaultValue=Page.DEFAULT_ORDER_PAGE_SIZE) int pageSize)
	{
		Page<Order> pageResult = orderService.getPageOrders(pageNo, pageSize);
		List<Order> orders = pageResult.getResult();
		modelMap.put("pageResult", pageResult);
		modelMap.put("orders", orders);
		modelMap.put("pageSize", pageSize);
	
		return "order_manage";
	}
	@RequestMapping(value="batchDelete")
	//用String 数组获取选中的订单id值
	public String bulkDeleteOrders(ModelMap modelMap,String[] selectIds, @RequestParam(defaultValue="1") int pageNo,
			@RequestParam(defaultValue=Page.DEFAULT_ORDER_PAGE_SIZE) int pageSize){
		
		String defaultInfo[] = new String[1];
		defaultInfo[0] = "请问您是逗比吗，您没有选择商品";
		if (selectIds == null)
		{
			modelMap.put("deleteInfos", defaultInfo);
			//重定向。如果使用redirect的话，则会新发起一个请求，put进去的东西就会消失
			return "forward:manage";
		}
		List<String> deleteInfos = orderService.batchDeleteByIds(selectIds);
		//获取商品批量删除的结果
		modelMap.put("deleteInfos", deleteInfos);
		
		return "forward:manage";
	}
	
	//批量更新
	@RequestMapping(value="batchUpdate")
	public String bulkUpdateOrders(ModelMap modelMap, @RequestBody List<Order> orders){
		List<String> updateInfos =orderService.batchUpdateOrders(orders);
		modelMap.put("updateInfos", updateInfos);
		return "forward:manage";
	}
	
	//批量更新
	@RequestMapping(value="findOrders")
	public String findOrdersByCondition(Order order,ModelMap modelMap, @RequestParam(required=false, defaultValue="1") int pageNo,
			@RequestParam(required=false, defaultValue=Page.DEFAULT_ORDER_PAGE_SIZE) int pageSize){
		
		Page<Order> pageResult = orderService.findOrdersByCondition(order, pageNo, pageSize);
		List<Order> orders = pageResult.getResult();
		
		modelMap.put("pageResult", pageResult);
		modelMap.put("orders", orders);
		modelMap.put("pageSize", pageSize);
		
		return "order_manage";
	}
	
	//输出订单Excel
	@RequestMapping(value="orderListExcel2")
	public String getOrderListExcel(ModelMap modelMap){
		List<Order> orders = (List<Order>) modelMap.get("orders");
		modelMap.put("orders", orders);
		return "orderListExcel";
	}
	
	//输出订单PDF
	@RequestMapping(value="orderListPdf2")
	public String getOrderListPdf(ModelMap modelMap){
		List<Order> orders = (List<Order>) modelMap.get("orders");
		modelMap.put("orders", orders);
		return "orderListPdf";
	}
	
	//输出订单XML
	@RequestMapping(value="orderListXml2")
	public String getOrderListXml(ModelMap modelMap){
		List<Order> orders = (List<Order>) modelMap.get("orders");
		modelMap.put("orders", orders);
		return "orderListXml";
	}

}
