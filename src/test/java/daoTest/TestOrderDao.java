package daoTest;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import dao.OrderDao;
import domain.Order;
import junit.framework.Assert;

//@Transactional
@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/daoContext.xml"}) 
public class TestOrderDao {

	@Autowired
	private OrderDao orderDao;

	@Test
	public void testSelectPagedOrders()
	{
		Assert.assertEquals(2, orderDao.getPageOrders(1, 5).getResult().size());
	}
	
	@Test
	public void testBatchDelete()
	{
		String[] orderIds = new String[3];
		orderIds[0] = new String("OW000001");
		orderIds[1] = new String("2");
		int[] results = orderDao.batchDeleteByIds(orderIds);
		
		Assert.assertEquals(1, results[0]);
		Assert.assertEquals(0, results[1]);
	}
	

	@Test
	public void testBatchUpdate()
	{
		List<Order> orders = new ArrayList<Order>();
		Order order = new Order();
		order.setOrderId("OW000001");
		order.setGoodIds("2");
		order.setAmounts("10");
		order.setStatus("未付款");
		order.setTotal(100);
		orders.add(order);
		Order order2 = new Order();
		order.setOrderId("OW000002");
		order.setGoodIds("2");
		order.setAmounts("10");
		order.setStatus("已完成");
		order.setTotal(100);
		orders.add(order2);
		int[] results = orderDao.batchUpdateOrders(orders);
		
		Assert.assertEquals(1, results[0]);
	
	}
	
	@Test
	public void testQueryByCondition(){
		Order order = new Order();
		order.setOrderId("");
		order.setUserId("10728425211");
		order.setGoodIds("");
		order.setStatus("");
		
		Assert.assertEquals(1, orderDao.findOrdersByCondition(order, 1, 5).getResult().size());
	}
}
