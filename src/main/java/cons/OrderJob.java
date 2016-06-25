package cons;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import web.UserController;

public class OrderJob implements Job {
	private static int count = 0;
	public ResultSet rs = null;
	public java.sql.Statement ps = null;
	public Connection conn = null;
	private static Logger logger = Logger.getLogger(OrderJob.class);
	
	public void execute(JobExecutionContext jctx) throws JobExecutionException {

		//加载JDBC驱动
		String driverName = "com.mysql.jdbc.Driver"; 
		//连接服务器和数据库sample 
		String dbURL = "jdbc:mysql://localhost:3306/onlineshopping?useUnicode=true&characterEncoding=utf8&mysqlEncoding=utf8"; 
		String userName = "root"; //默认用户名 
		String userPwd = "root"; //密码 

		Connection dbConn; 
		try { 
			Class.forName(driverName); 
			dbConn = DriverManager.getConnection(dbURL, userName, userPwd); 
			System.out.println("Connection Successful!"); //如果连接成功 控制台输出
			
			ps = dbConn.createStatement();
			int count = ps.executeUpdate("DELETE FROM tb_orders WHERE status = '已关闭'");
			if (count > 0 ) logger.info("删除了" + count +"条已关闭的订单的记录");
			dbConn.close();
		} catch (Exception e) { 
			e.printStackTrace();
		}finally{
			
		}

	}

}
