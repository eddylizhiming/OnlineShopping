package serviceTest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import junit.framework.Assert;
import service.ShoppingCarService;

//必须使它工作在事物环境下，才能回滚！！！！
@Transactional
@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/applicationContext.xml"}) 
public class TestShoppingCarService {

	@Autowired
	private ShoppingCarService shoppingCarService;
	
	@Rollback(true)
	@Test
	public void testServiceNotNull()
	{
		Assert.assertTrue(shoppingCarService.removeGoodFromCar("1035809405", "2"));
//		Assert.assertTrue(shoppingCarService.alterGoodsBoughtNum("1035809405", "2", 4));
	}
}