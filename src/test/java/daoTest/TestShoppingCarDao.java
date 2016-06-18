package daoTest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import dao.ShoppingCarDao;
import junit.framework.Assert;

@Transactional
@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/daoContext.xml"}) 
public class TestShoppingCarDao {

	@Autowired
	private ShoppingCarDao shoppingCarDao;
	@Test
	public void testAddToCar()
	{
		if (shoppingCarDao.getUserBoughtGood("1035809405", "3") != null)
		{
			System.out.println("用户购买了该商品。");
		}else {
			System.out.println("用户没有购买该商品。");
			
		}
		Assert.assertTrue(shoppingCarDao.addGoodsBoughtNum("1072842511", "44", 5) > 0);
	//	Assert.assertTrue( shoppingCarDao.addToCar("1072842511", "44", 5) > 0);
	}
	
	@Test
	public void TestRemoveFromCar()
	{
		Assert.assertTrue(shoppingCarDao.removeGoodFromCar("1", "1") == 0);
		Assert.assertTrue(shoppingCarDao.removeGoodFromCar("1072842511", "2") == 1);
	}
}
