package web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
		if (goodService == null)
			System.out.println("servciceNull");
		if (goodService.getPagedGoodsByType(pageNo, pageSize, typeId) == null)
			System.out.println("resutNul");
	
		Page<Good> goodsPaged = goodService.getPagedGoodsByType(pageNo, pageSize, typeId);
		List<Good> goods = goodsPaged.getResult();

		request.setAttribute("goodsPaged", goodsPaged);
		request.setAttribute("goods", goods);
		request.setAttribute("pageSize", pageSize);
		
		//下个页面取商品图片要用
		request.setAttribute("typeId", typeId);
		
		return "goods_show";
	}
}
