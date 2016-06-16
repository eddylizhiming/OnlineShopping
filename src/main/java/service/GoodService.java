package service;

import domain.Good;
import tool.Page;

public interface GoodService {

	/***
	 * 以类型获取分页过的商品信息
	 * @param pageNo 第几页
	 * @param pageSize 页面记录数
	 * @param typeId 商品类型编号
	 * @return 分页过的商品信息
	 */
	public Page<Good> getPagedGoodsByType(int pageNo, int pageSize, int typeId);
}
