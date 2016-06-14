package dao;

import static cons.ConDataBase.*;
import java.util.List;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Repository;
import domain.User;

@Repository
public class UserDaoImpl implements UserDao{

	//日志记录器
	private static Logger logger = Logger.getLogger(UserDaoImpl.class);
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
	
	public User findUserByUserId(String userId) {
		String sql = SELECT_USER_SQL + " WHERE userId = ?";
		Object args[] = {userId};
		
		return oneOrNull(jdbcTemplate.query(sql, args, new BeanPropertyRowMapper(User.class)));
	}

	/**
	 * 判断是否有匹配条件的返回值，若有返回一个实例，若没有Null
	 * @param list 使用query查询出来的列表
	 */
	private <T> T oneOrNull(List<T> list) {
		if (list == null || list.size() == 0) {
			return null;
		} else {	
			return list.get(0);
		}
	}


	public int insertUser(User user) {
		//使用具名参数，让bean属性与sql参数进行对应，这里是User
		System.out.println(user.getBalance());
		System.out.println(user.getEmail());
		String sql = INSERT_USER_SQL + " VALUES(:userId, :userName, :password, :balance, :email) ";

		SqlParameterSource sqlParameterSource = new BeanPropertySqlParameterSource(user);
		return namedParameterJdbcTemplate.update(sql, sqlParameterSource);
	}
	//发送验证邮件
	@Autowired
	private MailSender mailSender;
	@Autowired
	private SimpleMailMessage mailMessage;
	public SimpleMailMessage sendVerifyEmail(String receiveAddress, String captcha) {

		try {
			mailMessage.setSubject("OW旅游网站验证码邮件"); //设置邮件标题
			mailMessage.setText("尊敬的用户：\n\n您的邮箱绑定验证码为："+
					captcha +"，请在网页中填写，完成验证。 "); //设置邮件内容
				
			mailMessage.setTo(receiveAddress);
			mailSender.send(mailMessage);
		} catch (Exception e) {
			logger.error("发送邮件出错");
			return null;
		}
		
		return mailMessage;
	}

	public int updateUserInfo(User user) {
		
		String sql = UPDATE_USER_SQL + " WHERE userId = ?";
		Object args[] = {
				user.getUserName(),
				user.getPassword(),
				user.getAuthority(),
				user.getBalance(),
				user.getEmail(),
				user.getUserId()
		};
		
		return jdbcTemplate.update(sql, args);
	}
}
