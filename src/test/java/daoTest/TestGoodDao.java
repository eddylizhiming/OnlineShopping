package daoTest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import dao.GoodDao;
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
}
