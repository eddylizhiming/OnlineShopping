package tool;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import org.springframework.web.multipart.MultipartFile;

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
	public static String getUserUploadPath(String rootPath, String userId, String prefix){
		String filePath = getUserDirPath(rootPath, userId) + "headScul." + prefix;

		return filePath;
	}
	
	/***
	 * 获取管理员上传商品图片的文件的路径，为web根目录下的uploads+goodTypes+类型Id+文件名
	 * @param rootPath : web根目录
	 * @param userId : 用户的Id
	 * @param prefix : 文件后缀名
	 * @return
	 */
	public static String getAdminUploadGoodPicPath(String rootPath, String typeId, String fileName){
		String filePath = getAdminDirPath(rootPath, typeId)  + fileName;
		//在这里可以更换文件名称
		return filePath;
	}
	
	/**
	 * 获取用户上传的路径
	 * @param rootPath
	 * @param userId
	 * @return
	 */
	public static String getUserDirPath(String rootPath, String userId){
		String userDirPath = rootPath + "uploads" + File.separatorChar
				+ userId + File.separatorChar;

		return userDirPath;
	}
	
	/**
	 * 获取管理员上传商品文件夹的路径
	 * @param rootPath
	 * @param userId
	 * @return
	 */
	public static String getAdminDirPath(String rootPath, String typeId){
		String userDirPath = rootPath + "uploads" + File.separatorChar
				+ "goodTypes" + File.separatorChar + typeId + File.separatorChar;

		return userDirPath;
	}
	/***
	 * 获取用户上传信息，包括web根目录、上传的文件名、文件扩展名
	 * @param request
	 * @param headScul
	 * @param userId
	 * @return
	 */
	public static Map<String, String> getUserUploadInfos(HttpServletRequest request, MultipartFile headScul, String userId){
		Map<String, String> infos = new HashMap<String, String>();
		
		//获取web根目录
		String rootPath = UploadOperation.getContextPath(request); 
		//从session中获取登录的User实例
	
		//上传的文件名
		String fileName = headScul.getOriginalFilename();
		//文件扩展名
		String prefix = fileName.substring(fileName.lastIndexOf(".")+1);
		String userDirPath = UploadOperation.getUserDirPath(rootPath, userId);
		//文件路径，上传到用户独立的文件夹，如uploads/1072842511，表示用户Id为1072842511上传的图片
		String filePath = UploadOperation.getUserUploadPath(rootPath, userId, prefix);
		
		infos.put("rootPath", rootPath);
		infos.put("fileName", fileName);
		infos.put("prefix", prefix);
		infos.put("userDirPath", userDirPath);
		infos.put("filePath", filePath);
		return infos;
	}
	
	/***
	 * 获取管理员上传商品信息，包括web根目录、上传的文件名、文件扩展名
	 * @param request
	 * @param headScul
	 * @param userId
	 * @return
	 */
	public static Map<String, String> getAdminUploadGoodInfos(HttpServletRequest request, MultipartFile headScul, String typeId){
		Map<String, String> infos = new HashMap<String, String>();
		
		//获取web根目录
		String rootPath = UploadOperation.getContextPath(request); 
		//从session中获取登录的User实例
	
		//上传的文件名
		String fileName = headScul.getOriginalFilename();
		//文件扩展名
		String prefix = fileName.substring(fileName.lastIndexOf(".")+1);
		String userDirPath = UploadOperation.getAdminDirPath(rootPath, typeId);
		//文件路径，上传到用户独立的文件夹，如uploads/1072842511，表示用户Id为1072842511上传的图片
		String filePath = UploadOperation.getAdminUploadGoodPicPath(rootPath, typeId, prefix);
		
		infos.put("rootPath", rootPath);
		infos.put("fileName", fileName);
		infos.put("prefix", prefix);
		infos.put("userDirPath", userDirPath);
		infos.put("filePath", filePath);
		return infos;
	}
	
	public static String getFilePrefix(String fileName)
	{
		String prefix = fileName.substring(fileName.lastIndexOf(".")+1);
		return prefix;
	}
	public static void main(String[] args) {
		
	}
}
