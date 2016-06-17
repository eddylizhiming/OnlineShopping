package daoTest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import dao.GoodDao;
import domain.Good;

import static junit.framework.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/daoContext.xml"}) 
public class TestGoodDao {

	@Autowired
	private GoodDao goodDao;
	@Test
	public void testPagedGoods()
	{
		assertEquals(goodDao.getPagedGoodsByType(1, 4, 1).getResult().size(), 3);
	}
	
	@Test
	public void searchGoodsByCondition()
	{
		for (Good good : goodDao.searchGoodsByCondition(1, "2", 1).getResult())
		{
			System.out.println(good.getGoodName());
		}
		assertEquals(3, goodDao.searchGoodsByCondition(1, "2", 1).getResult().size());
	}
}
