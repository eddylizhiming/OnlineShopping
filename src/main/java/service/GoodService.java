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
	/***
	 * 通过条件搜索商品
	 * @param typeId 类型的id
	 * @param goodCondition 模糊查询的商品编号或商品名称
	 * @return 分页的商品列表
	 */
	public Page<Good> searchGoodsByCondition(int typeId, String goodCondition, int pageNo);
	/***
	 * 通过制定的Id查找商品
	 * @param goodId
	 * @return 查找不到返回null
	 */
	public Good findGoodById(String goodId);
}
