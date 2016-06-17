package daoTest;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class TestDbCon {

	public static void main(String[] args) throws SQLException, ClassNotFoundException {
		ApplicationContext ctx=new ClassPathXmlApplicationContext("daoContext.xml");  
		DataSource dataSource=ctx.getBean("dataSource",DataSource.class);

		if (dataSource.getConnection() != null){
			System.out.println("数据库连接成功");
		}

		
	}
}
