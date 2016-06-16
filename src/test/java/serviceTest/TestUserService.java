package serviceTest;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import service.UserService;

@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/applicationContext.xml"}) 
public class TestUserService {

	@Autowired
	private UserService userService;

	@Test
	public void testUpdateHead() {
		
		Assert.assertTrue( userService.updateHeadscul("107284251", "dsf"));
	}

	
}
