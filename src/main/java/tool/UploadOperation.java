package tool;

import java.io.File;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

public class UploadOperation {

	/**
	 * 用来操作用户上传的文件夹，如果用户没有上传过，会新建一个。
	 * @param userDirName 用户目录的路径
	 */
	public static void operUserUpDir(String userDirPath)
	{
		File dir = new File(userDirPath);

		//如果用户在上传文件夹中没有文件夹，也就是没有上传过图片，则新建
		if (dir.exists() == false)
		{
			dir.mkdir();
		}
	}
	/**
	 * 删除用户上传过的头像
	 * @param userDirName 用户目录的路径
	 */
	public static void deleteUploadedHead(String userDirPath)
	{
		//如果用户之前上传过头像则删除。
		String[] headPrefixs = new String[]	
				{	
						"jpg","png","gif", "jpeg"
				};
		for (String headPrefix : headPrefixs){
			//头像名称为headScul，可自定义
			File file = new File(userDirPath + "headScul." + headPrefix);
			if (file.exists())
				file.delete();
		}
	}
	/**
	 * 判断是否是上传的文件是否是合法的图片，即内容类型为"image/png"等
	 * @param contentType 内容的类型
	 * @return 是合法的图片返回true，否则返回false
	 */
	public static boolean isVaildPicture(String contentType)
	{
		if (contentType.equals("image/png") || contentType.equals("image/jpeg") ||
				contentType.equals("image/gif"))
			return true;
		else
			return false;
	}

	/**
	 * 获取Web根目录
	 **/
	public static String getContextPath(HttpServletRequest request)
	{

		ServletContext servletContext = request.getSession().getServletContext();
		//获取web根目录,但是在eclipse中，是在一个临时文件夹，如：
		//\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\
		String rootPath = servletContext.getRealPath("/");    
		return rootPath;
	}

	/***
	 * 获取上传的路径，为web根目录下的uploads+用户id文件夹+文件名
	 * @param rootPath : web根目录
	 * @param userId : 用户的Id
	 * @param prefix : 文件后缀名
	 * @return
	 */
	public static String getUploadPath(String rootPath, String userId, String prefix){
		String filePath = getUserDirPath(rootPath, userId) + "headScul." + prefix;

		return filePath;
	}
	
	/**
	 * 获取用户上传的路径
	 * @param rootPath
	 * @param userId
	 * @return
	 */
	public static String getUserDirPath(String rootPath, String userId){
		String userDirPath = rootPath + File.separatorChar + "uploads" + File.separatorChar
				+ userId + File.separatorChar;

		return userDirPath;
	}
}
