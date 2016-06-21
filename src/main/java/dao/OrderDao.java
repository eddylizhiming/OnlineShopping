package dao;

import java.util.List;

import domain.Order;
import tool.Page;

public interface OrderDao {
	public Page<Order> getPageOrders(int pageNo, int pageSize);
	public int[] batchDeleteByIds(String[]  orderIds);
	public int[] batchUpdateOrders(final List<Order> orders);
	public Page<Order> findOrdersByCondition(Order order, int pageNo, int pageSize);
	
}
