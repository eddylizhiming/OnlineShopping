package tool;

public class FormatValidation {

	public static String vaildEmailAddress(String receiveAddress){
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
}
