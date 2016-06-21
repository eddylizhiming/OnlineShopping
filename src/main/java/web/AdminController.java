package web;

import static tool.UploadOperation.deleteUploadedHead;
import static tool.UploadOperation.getAdminUploadGoodPicPath;
import static tool.UploadOperation.getContextPath;
import static tool.UploadOperation.getFilePrefix;
import static tool.UploadOperation.getUserUploadInfos;
import static tool.UploadOperation.isVaildPicture;
import static tool.UploadOperation.operUserUpDir;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import domain.Good;
import domain.User;
import service.GoodService;
import service.UserService;
import tool.IPTimeStamp;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private GoodService goodService;
	
	//已经注册用户的隐含模型
	@ModelAttribute("regUser")
	public User getRegUser()
	{
		return new User();
	}

	/*//管理员管理商品信息要用的隐含模型
	@ModelAttribute("good")
	//必须设置GET方式，否则在请求方法中填写的隐含模型回到本页面时会被覆盖！！！
	@RequestMapping(method=RequestMethod.GET)
	public Good getGood(ModelMap modelMap)
	{
		Good good = (Good) modelMap.get("good") ;
		System.out.println(good.getGoodName());
		return good;
	}*/
	
	@RequestMapping("manage")
	public String forwardAdminManage(ModelMap modelMap)
	{
		modelMap.put("good", new Good()) ;
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
		Map<String, String> infos = getUserUploadInfos(request, headScul, userId);
		String userDirPath = infos.get("userDirPath");
		String prefix = infos.get("prefix");

		operUserUpDir(userDirPath);
		String filePath = infos.get("filepath");

		if (!headScul.isEmpty())
		{
			String contentType = headScul.getContentType();
			//判断是否是图片的格式，如JPEG
			if (isVaildPicture(contentType))
			{
				deleteUploadedHead(userDirPath);
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
	//查询商品信息
	@RequestMapping(value="queryGoodInfo", params={"goodId"})
	public String queryGoodInfo(ModelMap modelMap, String goodId)
	{
		Good good = goodService.findGoodById(goodId);

		if (good == null)
		{
			modelMap.put("queryResult", "查询商品失败");
			modelMap.put("good", new Good());
			
			return "admin_manage";
		}
		modelMap.put("typeId", good.getGoodType());
		modelMap.put("queryResult", "查询商品成功");
		modelMap.put("good", good);
		return "admin_manage";
	}
	
	//删除商品
	@ResponseBody
	@RequestMapping(value="deleteGood", params={"goodId"})
	public String deleteGood(ModelMap modelMap, String goodId)
	{
		if (goodService.deleteGoodById(goodId) == true){
			return "删除成功";
		}
		else
			return "删除失败";
	}
	
	//更新商品信息
	@RequestMapping(value="updateGoodInfo", params={"goodId"})
	public String updateGoodInfo(@RequestParam("goodPic") MultipartFile goodPic, ModelMap modelMap, Good good,
			HttpServletRequest request) throws IllegalStateException, IOException
	{
		String aimUrl = "admin_manage";
		if (goodService.findGoodById(good.getGoodId()) == null )
		{
			modelMap.put("updateGoodResult", "更新失败");
			return aimUrl;
		}
		String fileName = goodPic.getOriginalFilename();
		String prefix = getFilePrefix(fileName);
		//使用时间戳的形式让名称不重复。
		fileName = new IPTimeStamp(request.getRemoteAddr()).getIPTimeRand() + "." + prefix;
		//如果是合法的图片
		if (isVaildPicture(goodPic.getContentType()))
		{
			//删除原来该商品图片
			String tempTypeId = goodService.findGoodById(good.getGoodId()).getGoodType();
			String tempGoodPic = goodService.findGoodById(good.getGoodId()).getPictureSrc();


			String filepath = getAdminUploadGoodPicPath(getContextPath(request),
					tempTypeId, tempGoodPic);
			
			new File(filepath).delete();
			filepath = getAdminUploadGoodPicPath(getContextPath(request),
			good.getGoodType(), fileName);
			goodPic.transferTo(new File(filepath));
			
			good.setPictureSrc(fileName);
		}
		else
		{
			//设置商品为原来的图片
			String originalName = goodService.findGoodById(good.getGoodId()).getPictureSrc();
			good.setPictureSrc(originalName);
		}
		
		if (goodService.updateGoodInfo(good) == true){
			modelMap.put("updateGoodResult", "更新成功");
			request.setAttribute("typeId", good.getGoodType());
			return aimUrl;
		}
		
		request.setAttribute("typeId", goodService.findGoodById(good.getGoodId()));
		modelMap.put("updateGoodResult", "更新失败");
		return aimUrl;
	}
	
	@RequestMapping(value="insertGood")
	public String insertGood(@RequestParam("goodPic") MultipartFile goodPic, ModelMap modelMap, Good good,
			HttpServletRequest request) throws IllegalStateException, IOException{

		String fileName = goodPic.getOriginalFilename();
		String prefix = getFilePrefix(fileName);
		//使用时间戳的形式让名称不重复。
		fileName = new IPTimeStamp(request.getRemoteAddr()).getIPTimeRand() + "." + prefix;

		//若上传了商品图片，如果是合法的图片
		if (goodPic.isEmpty() == false && isVaildPicture( goodPic.getContentType()))
		{
			String filepath = getAdminUploadGoodPicPath(getContextPath(request), good.getGoodType(), fileName);
			goodPic.transferTo(new File(filepath));
			good.setPictureSrc(fileName);
		}

		else
			good.setPictureSrc("defaultGoodPicture.jpg");		
		
		if ( goodService.insertGood(good) == true){
			modelMap.put("insertGoodResult", "添加成功");
			return "admin_manage";
		}

		modelMap.put("insertGoodResult", "添加失败");
		return "admin_manage";
	}
}
