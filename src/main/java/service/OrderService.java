package service;

import java.util.List;

import domain.Order;
import tool.Page;

public interface OrderService {
	/**
	 * 获取分页的订单
	 * @param pageNo 页面的索引
	 * @param pageSize 页面大小
	 * @return 分页过的订单
	 */
	public Page<Order> getPageOrders(int pageNo, int pageSize);
	/**
	 * 以订单编号批量删除订单
	 * @param orderIds 订单编号的list
	 * @return 删除订单是否成功的信息。
	 */
	public List<String> batchDeleteByIds(final String[] orderIds);
	/**
	 * 批量更新订单
	 * @param orderIds 订单的list
	 * @return 更新订单是否成功的信息list。
	 */
	public List<String> batchUpdateOrders(final List<Order> orders);
	/***
	 * 查找条件查找商品
	 * @param order
	 * @param pageNo
	 * @param pageSize
	 * @return 通过条件查找的商品列表
	 */
	public Page<Order> findOrdersByCondition(Order order, int pageNo, int pageSize);
}
