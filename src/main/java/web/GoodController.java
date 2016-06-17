package web;

import java.io.IOException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import domain.Good;
import domain.GoodType;
import service.GoodService;
import service.GoodTypeService;
import tool.Page;

@Controller
@RequestMapping("/good")
public class GoodController {
	
	@Autowired
	private GoodTypeService goodTypeService;
	@Autowired
	private GoodService goodService;

	@ModelAttribute("goodType")
	public GoodType getGoodType()
	{
		return new GoodType();
	}
	//展示一个类型下的所有商品信息
	@RequestMapping(value="type/{typeId}/showGoods")
	//设置默认值
	public String showGoods(HttpServletRequest request, @RequestParam(value = "pageNo", defaultValue="1", required = false) int pageNo , 
			@RequestParam(value = "pageSize", defaultValue = Page.DEFAULT_PAGE_SIZE_STRING, required = false) int pageSize, @PathVariable("typeId") int typeId)
	{	
		//放入所有商品类型
		List<GoodType> goodTypes =  goodTypeService.getAllTypes();
		request.setAttribute("goodTypes", goodTypes);
	
		//放入一个类型下的所有商品
		Page<Good> goodsPaged = goodService.getPagedGoodsByType(pageNo, pageSize, typeId);
		List<Good> goods = goodsPaged.getResult();

		request.setAttribute("goodsPaged", goodsPaged);
		request.setAttribute("goods", goods);
		request.setAttribute("pageSize", pageSize);
		
		//下个页面取商品图片要用
		request.setAttribute("typeId", typeId);
		//移除搜索商品时的两个属性。
		request.getSession().removeAttribute("typeId");
		request.getSession().removeAttribute("goodCondition");
		return "goods_show";
	}

	//如果是通过用户提交表单，则需要两个parameter
	@RequestMapping(value = "searchGoods", params = { "typeId", "goodCondition" }, method=RequestMethod.POST)
	public String searchGoodsByCondition(int typeId, String goodCondition, HttpServletRequest request, HttpServletResponse response) throws IOException {
		Page<Good> page = goodService.searchGoodsByCondition(typeId, goodCondition, 1);

		request.getSession().setAttribute("typeId", typeId);
		request.getSession().setAttribute("goodCondition", goodCondition);
		//采用默认大小
		request.setAttribute("pageSize", Page.DEFAULT_PAGE_SIZE);
		if (page.getResult().size() == 0)
		{
			//若没有搜索结果，给他一个typeId下的第一页的商品
			page =  goodService.getPagedGoodsByType(1, Page.DEFAULT_PAGE_SIZE, typeId);
			
			//放入所有商品类型
			List<GoodType> goodTypes =  goodTypeService.getAllTypes();
			request.setAttribute("goodTypes", goodTypes);
			
			request.setAttribute("goodsPaged", page);
			request.setAttribute("goods", page.getResult());
			request.setAttribute("searchResult", "无搜索结果，为您展示同类型商品");
			return "goods_show";
		}
		request.setAttribute("searchResult", "已为您搜索到了商品");
		request.setAttribute("goodsPaged", page);
		request.setAttribute("goods", page.getResult());
		return "goods_search";
	}
	
	@RequestMapping(value = "searchGoods", params={"pageNo"} ,method=RequestMethod.GET)
	public String operSearchResult(HttpServletRequest request, Integer pageNo)
	{
		Integer typeId =  (Integer) request.getSession().getAttribute("typeId");
		String goodCondition = (String) request.getSession().getAttribute("goodCondition");
		
		Page<Good> page = goodService.searchGoodsByCondition(typeId, goodCondition, pageNo);
		request.setAttribute("goodsPaged", page);
		request.setAttribute("goods", page.getResult());
		
		return "goods_search";
	}
}
