package daoTest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import dao.GoodTypeDao;
import junit.framework.Assert;

@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/daoContext.xml"}) 
public class TestGoodTypeDao {

	@Autowired
	private GoodTypeDao goodTypeDao;
	
	@Test
	public void testGetAllGoodTypes()
	{
		Assert.assertEquals(goodTypeDao.getAllTypes().get(1).getTypeName(), "日常家居");
	}
}
