package tool;

import java.util.HashMap;
import java.util.Map;

public class FormatValidation {

	/***
	 *	验证邮箱格式
	 * @param receiveAddress
	 * @return 若验证成功，返回一个字符串"验证成功"
	 */
	public static String vaildBindEmailAddress(String receiveAddress){
		String emailRegeXp = "([a-z0-9_\\.-]{2,15})@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})";
		//判断输入的邮箱是否为空
		if (receiveAddress == null || receiveAddress.equals(""))
		{
			return "邮箱不能为空";
		}
		//如果邮件格式不正确，提前返回
		if (! receiveAddress.matches(emailRegeXp))
			return "邮箱格式不正确";
		
		return "验证成功";
	}
	
	public static String vaildUpdateEmailAddress(String receiveAddress){
		String emailRegeXp = "([a-z0-9_\\.-]{2,15})@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})";
		//更新用户信息时，如果没填验证码，表示用原来的。。
		if (receiveAddress == null || receiveAddress.equals(""))
			return "验证成功";		
		//如果邮件格式不正确，提前返回
		if (! receiveAddress.matches(emailRegeXp))
			return "邮箱格式不正确";
		
		return "验证成功";
	}
}
