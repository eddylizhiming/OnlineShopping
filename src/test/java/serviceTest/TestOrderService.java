package serviceTest;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import domain.Order;
import junit.framework.Assert;
import service.OrderService;

@Transactional
@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/applicationContext.xml"}) 
public class TestOrderService {

	@Autowired
	private OrderService orderService;
	
	@Test
	public void TestDeleteInfos()
	{
		String[] orderIds = new String[3];
		orderIds[0] = new String("OW000001");
		orderIds[1] = new String("2");
		List<String> array =orderService.batchDeleteByIds(orderIds);
		Assert.assertEquals(1, array.size());
		
	}
	
	@Test
	public void TestUpdateInfos()
	{
		List<Order> orders = new ArrayList<Order>();
		Order order = new Order();
		order.setOrderId("OW0000201");
		order.setGoodIds("2");
		order.setAmounts("10");
		order.setStatus("已关闭");
		order.setTotal(100);
		orders.add(order);
		
		Order order2 = new Order();
		order.setOrderId("OW0000201");
		order.setGoodIds("2");
		order.setAmounts("10");
		order.setStatus("已关闭");
		orders.add(order2);
		List<String> array =orderService.batchUpdateOrders(orders);
		System.out.println(array.get(0));
		Assert.assertEquals(1, array.size());
		
	}
}
