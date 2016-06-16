package serviceTest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import junit.framework.Assert;
import service.GoodService;

@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/applicationContext.xml"}) 
public class TestGoodService {

	@Autowired
	private GoodService goodService;
	
	@Test
	public void testServiceNotNull()
	{
		Assert.assertEquals(goodService.getPagedGoodsByType(1, 4, 1).getResult().size() , 1);
	}
}
