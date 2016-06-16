package service;

import java.util.List;
import domain.GoodType;

public interface GoodTypeService {
	
	/***
	 * 获取所有商品类型的信息
	 * @return 商品类型的列表
	 */
	public List<GoodType> getAllTypes();
	
}
