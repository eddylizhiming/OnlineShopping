package daoTest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import dao.UserDao;
import domain.User;
import tool.CaptchaGenerator;

@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/daoContext.xml"}) 
public class TestUserDao {

	@Autowired
	private UserDao userDao;
	@Test
	public void test() {
/*		UserDao userDao = new UserDaoImpl();
		userDao.findUserByUserId("1");*/
/*		System.out.println(jdbcTemplate);
		assertNotNull(jdbcTemplate);
		userDao.findUserByUserId("");
		assertNotNull(userDao);*/
		
		//测试用户存在
		User user = new User();
		user.setUserId("1072842511");
		user.setPassword("1234567");
		if (userDao.findUserByUserId(user.getUserId()) != null)
			System.out.println("用户存在");
		else
			System.out.println("用户不存在");
	}

	@Test
	public void test2(){
		User user = new User();
		System.out.println("email" + user.getEmail());
	}
	
	@Test
	public void test3(){
		//随机数生成
		CaptchaGenerator generator = new CaptchaGenerator(6, "0123456789");
		System.out.println( generator.next());
	}
}
