package service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.OrderDao;
import domain.Order;
import tool.Page;

@Service
public class OrderServiceImpl implements OrderService{

	@Autowired
	private OrderDao orderDao;
	public Page<Order> getPageOrders(int pageNo, int pageSize) {
		return orderDao.getPageOrders(pageNo, pageSize);
	}
	public List<String> batchDeleteByIds(String[] orderIds) {
		int[] deleteResults = orderDao.batchDeleteByIds(orderIds);
		List<String> infos = new ArrayList<String>();
		//注意 退出for 的条件不要搞错喽。
		for (int index = 0; index < deleteResults.length; index++)
		{
			if (deleteResults[index] > 0)
				infos.add("编号为：" + orderIds[index] + "的订单删除成功");
			else
				infos.add("编号为：" + orderIds[index]  + "的订单删除失败");
		}
		return infos;
	}
	public List<String> batchUpdateOrders(List<Order> orders) {
		int[] updateResult = orderDao.batchUpdateOrders(orders);
		List<String> infos = new ArrayList<String>();
		//注意 退出for 的条件不要搞错喽。
		for (int index = 0; index < updateResult.length; index++)
		{
			if (updateResult[index] > 0)
				infos.add("编号为：" + orders.get(index).getOrderId() + "的订单更新成功");
			else
				infos.add("编号为：" + orders.get(index).getOrderId()   + "的订单更新失败");
		}
		return infos;
	}
	public Page<Order> findOrdersByCondition(Order order, int pageNo, int pageSize) {
		
		return orderDao.findOrdersByCondition(order, pageNo, pageSize);
	}

}
