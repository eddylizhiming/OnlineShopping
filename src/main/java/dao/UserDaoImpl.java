package dao;

import static cons.ConDataBase.INSERT_USER_SQL;
import static cons.ConDataBase.SELECT_USER_SQL;
import static cons.ConDataBase.UPDATE_USER_SQL;

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
import tool.FormatValidation;

@Repository
public class UserDaoImpl extends BaseDaoImpl implements UserDao{

	//日志记录器
	private static Logger logger = Logger.getLogger(UserDaoImpl.class);
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
	
	public User findUserByUserId(String userId) {
		Object args[] = {userId};
		
		return oneOrNull(jdbcTemplate.query(SELECT_USER_SQL, args, new BeanPropertyRowMapper<User>(User.class)));
	}





	public Integer insertUser(User user) {
		//设置用户默认头像为defaultHead.jpg
		user.setHeadScul("defaultHead.jpg");
		
		//使用具名参数，让bean属性与sql参数进行对应，这里是User
		SqlParameterSource sqlParameterSource = new BeanPropertySqlParameterSource(user);
		return namedParameterJdbcTemplate.update(INSERT_USER_SQL, sqlParameterSource);
	}
	//发送验证邮件
	@Autowired
	private MailSender mailSender;
	@Autowired
	private SimpleMailMessage mailMessage;
	public SimpleMailMessage sendVerifyEmail(String receiveAddress, String captcha) {

		//如果邮箱格式不正确
		if (FormatValidation.vaildBindEmailAddress(receiveAddress).equals("验证成功") == false )
			return null;
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

	public Integer updateUserInfo(User user) {
		
		Object args[] = {
				user.getUserName(),
				user.getPassword(),
				user.getAuthority(),
				user.getBalance(),
				user.getEmail(),
				user.getHeadScul(),
				user.getUserId()
		};
		
		return jdbcTemplate.update(UPDATE_USER_SQL, args);
	}
}
