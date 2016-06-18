package web;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.zip.Inflater;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import domain.User;
import service.UserService;
import tool.UploadOperation;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private UserService userService;
	
	
	//已经注册用户的隐含模型
	@ModelAttribute("regUser")
	public User getRegUser()
	{
		return new User();
	}

	@RequestMapping("manage")
	public String forwardAdminManage()
	{
		return "admin_manage";
	}
	
	
	//查询用户信息
	@ResponseBody
	@RequestMapping("queryUserInfo")
	public String queryUserInfo(@ModelAttribute("regUser") User regUser)
	{	
		regUser = userService.findUserByUserId(regUser.getUserId());
		
		if (regUser == null)
			return "";
		//'&'是自定义的分隔符
		return regUser.getUserName() + "&" + regUser.getHeadScul();
	}
	
	//更新用户昵称
	@ResponseBody
	@RequestMapping("updateUserName")
	public String updateUserName(String userId, String userName)
	{	
		User user = userService.findUserByUserId(userId);
		user.setUserName(userName);
		if ( userService.updateUserInfo(user) == true)
			return "更新昵称成功";
		return "更新昵称失败";
	}
	
	//更新用户头像
	@RequestMapping("updateUserHead")
	public String updateUserHead(@RequestParam(value="newHeadScul") MultipartFile headScul, 
		  @RequestParam("userId2") String userId, HttpServletRequest request) throws IllegalStateException, IOException
	{	
		String aimUrl = "admin_manage";
		request.setAttribute("userId", userId);
		if (userId.equals(""))
		{
			request.setAttribute("updateHeadResult", "用户Id不能为空");
			return aimUrl;
		}
		//判断是否有用户
		User user = userService.findUserByUserId(userId);
		if (user == null)
		{
			request.setAttribute("updateHeadResult", "没有Id为"+ userId + "的用户");
			return aimUrl;
		}
		//如果用户的权限不是普通用户
		if(user.getAuthority().equals("ordinary") == false)
		{
			request.setAttribute("updateHeadResult", "您只能修改普通用户的资料");
			return aimUrl;
		}
		//获取用户上传的基本信息
		Map<String, String> infos = UploadOperation.getUploadInfos(request, headScul, userId);
		String userDirPath = infos.get("userDirPath");
		String prefix = infos.get("prefix");

		UploadOperation.operUserUpDir(userDirPath);
		String filePath = infos.get("filepath");

		if (!headScul.isEmpty())
		{
			String contentType = headScul.getContentType();
			//判断是否是图片的格式，如JPEG
			if (UploadOperation.isVaildPicture(contentType))
			{
				UploadOperation.deleteUploadedHead(userDirPath);
				headScul.transferTo(new File(filePath));
				request.setAttribute("updateHeadResult", "修改用户头像成功");
				//更新数据库中用户头像
				userService.updateHeadscul(userId, "headScul." + prefix);
				//更新session中登录用户的信息
				request.getSession().setAttribute("loginedUser", userService.findUserByUserId(userId));
			}
			else {
				request.setAttribute("updateHeadResult", "图片必须是JPG或PNG或GIF格式！");
			}
		} else
			request.setAttribute("updateHeadResult", "请选择图片!");
		return aimUrl;
	}

}
