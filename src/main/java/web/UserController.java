package web;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import domain.LoginingUser;
import domain.User;
import service.UserService;
import tool.CaptchaGenerator;
import tool.MyCage;
import tool.UploadOperation;

@Controller
@RequestMapping("/user/${userId}")
//将本处理器中任何处理方法属性名为loginedUser的模型属性存储到HttpSession中
@SessionAttributes("loginedUser")
public class UserController {

	private static Logger logger = Logger.getLogger(UserController.class);
	@Autowired
	private UserService userService;
	//商品类型
	
	@ModelAttribute("user")
	public LoginingUser getUser()
	{
		return new LoginingUser();
	}

	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String forwardLogin(HttpServletRequest request){
		//直接输入地址的话，清除session中的验证码属性
		//		request.getSession().removeAttribute("captcha");
		return "login";
	}

	/****
	 * 对用户登录请求的验证及处理
	 * @param user 登录的用户包括用户Id及密码
	 * @return 一个逻辑视图名
	 */

	@RequestMapping(value="/login", method=RequestMethod.POST)
	//必须添加@ModelAttribute("user")，及时更新user模型属性，否则login.jsp错误信息无法取出
	public String loginCheck(@Valid @ModelAttribute("user") LoginingUser loginedUser, BindingResult bindingResult, @RequestParam(value="captcha") String captcha, 
			HttpServletRequest request, boolean isRememberPwd, @RequestParam("rememberd_days") int rememberd_days,
			HttpServletResponse response){

		logger.debug("记住的天数：" + rememberd_days);

		if (loginedUser.getUserId().equals("")){
			request.setAttribute("loginError", "用户名不能为空");
			return "login";
		}
		//有校验错误直接返回登录页
		if (bindingResult.hasErrors())
			return "login";
		//			System.out.println("用户登录信息格式有错误");
		else
			logger.info("用户登录信息格式无错误");

		if (userService.hasMatchUser(loginedUser.getUserId(), loginedUser.getPassword())){
			//将登陆的用户放入session
			User user = userService.findUserByUserId(loginedUser.getUserId());
			request.getSession().setAttribute("loginedUser", user);
			//如果勾选了记住密码选项且信息正确
			if (isRememberPwd == true){
				Cookie userId = new Cookie("userId", loginedUser.getUserId()); 
				Cookie password = new Cookie("password", loginedUser.getPassword()); 
				//rememberd_days是天，而setMaxAge的单位是秒，需要转换,
				userId.setMaxAge(rememberd_days * 24 * 60 * 60);  
				password.setMaxAge(rememberd_days * 24 * 60 * 60);  

				response.addCookie(userId);  
				response.addCookie(password);  
			}
			//没有勾选记住密码的情况，删除cookie
			else {
				Cookie cookies[] = request.getCookies();  
				if (cookies != null)  
				{   
					for (int i = 0; i < cookies.length; i++)  
					{  
						if (cookies[i].getName().equals("userId") ||
								cookies[i].getName().equals("password")   )  
						{  
							logger.debug("find userId or password cookie");
							cookies[i].setMaxAge(0);  
							//更新cookie，让其失效
							response.addCookie(cookies[i]);
						}  
					}  
				}  

			}
			return "index";
		}
		else {
			logger.info("有用户登录失败。");
			request.setAttribute("loginError", "用户名或密码不正确");
			return "login";
		}

	}

	@Autowired
	private MyCage myCage;

	/***
	 * 生成验证码
	 */
	@RequestMapping(value="createCode") 
	private void createValidateImg(HttpServletRequest request,HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession(false);
		if (session == null) {
			session=request.getSession();
		}
		String token = myCage.getTokenGenerator().next();
		System.out.println("当前的SessionID=" + session.getId() + "，验证码=" + token);
		session.setAttribute("captchaToken", token);
		setResponseHeaders(response);
		myCage.draw(token, response.getOutputStream());
	}
	/***
	 * 设置响应的头信息
	 */
	protected void setResponseHeaders(HttpServletResponse response) {
		response.setContentType("image/" + myCage.getFormat());
		response.setHeader("Cache-Control", "no-cache, no-store");
		response.setHeader("Pragma", "no-cache");
		long time = System.currentTimeMillis();
		response.setDateHeader("Last-Modified", time);
		response.setDateHeader("Date", time);
		response.setDateHeader("Expires", time);
	}

	/***
	 * 检查用户填写的验证码是否正确
	 * @param userInputCode 用户输入的验证码
	 * @param request 用来获取session中的真实验证码
	 * @return 验证码填写若正确则返回一个字符串 "填写正确"
	 * @throws UnsupportedEncodingException
	 */
	@ResponseBody
	@RequestMapping("captchaCheck")
	public String checkLoginCaptcha(@RequestParam("captcha") String userInputCode, HttpServletRequest request) throws UnsupportedEncodingException
	{
		HttpSession session = request.getSession();
		String realCode = (String) session.getAttribute("captchaToken");

		logger.debug("用户输入的验证码：" + userInputCode);
		logger.debug("真实的验证码：" + realCode);

		//暂时不将验证码属性放入session中
		//        session.setAttribute("captcha", userInputCode);

		if (userInputCode.equalsIgnoreCase(realCode))
		{
			//填写正确则将生成的登录验证码属性从session中移除
			request.getSession().removeAttribute("captchaToken");
			return "填写正确";
		}
		else
			return "验证码错误";
	}

	//注册用户时的隐含模型
	@ModelAttribute("regUser")
	public User getRegUser()
	{
		return new User();
	}

	@RequestMapping(value="/register", method=RequestMethod.GET)
	public String forwardReigister(HttpServletRequest request){

		return "register";
	}

	/****
	 * 对用户注册请求的验证及处理
	 * @param user 登录的用户包括用户Id及昵称、密码，确认密码
	 * @return 一个逻辑视图名
	 */
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String registerCheck(@Valid @ModelAttribute("regUser") User user, BindingResult bindingResult,
			@RequestParam("confirmPassword") String confirmPassword, HttpServletRequest request){

		boolean flag = true;
		
		//用户名为空，提前返回
		if (user.getUserId().equals("") )
		{
			flag = false;
			request.setAttribute("createInfo", "用户名不能为空");
			return "register";
		}
		
		//如果密码不等于确认密码
		if (!user.getPassword().equals(confirmPassword) )
		{
			flag = false;
			request.setAttribute("pwdEquals", "密码和确认密码不同<br/>");
		}

		//校验出错
		if (bindingResult.hasErrors())
		{
			flag = false;
			logger.debug("有用户注册信息格式出错。。");
		}
		
		//防止一个用户在注册的时候，触发检测用户名可用，返回可用，但没有提交
		//而另一个用户在这期间进行了注册的同步注册的情况。
		if (userService.isUserExist(user.getUserId())){
			request.setAttribute("createInfo", "该用户名已注册\n");
			logger.error("发生了同步注册的情况。");
			return "register";
		}
		
		if (flag == false) return "register";
		
		//插入用户操作
		if ( userService.insertUser(user) ){	
			request.setAttribute("createInfo", "注册成功\n");
			//如果注册成功，则自动为他登录
			request.getSession().setAttribute("loginedUser", userService.findUserByUserId(user.getUserId()));
			logger.info("编号为 "+ user.getUserId() + "的用户注册成功。。\n");	
			return "index";
		}
		else
		{
			request.setAttribute("createInfo", "因为某些原因，注册失败。。\n");
			logger.error("创建用户失败。。");
			return "register";
		}

	}

	@ResponseBody
	@RequestMapping(value = "userExistCheck")
	public String userExistCheck(String userId, HttpServletResponse response) throws IOException{
		//根目录下的images文件夹，即webapp
		String filePath = "/OnlineShopping/images/";
		//如果用户名不满足正则则提前返回
		if (userId.matches("\\w{6,30}") == false)
		{
			filePath += "userExist.jpg";
			return filePath;
		}
		if (userService.isUserExist(userId))
		{
			filePath += "userExist.jpg";
		}
		else
			filePath += "userAvl.jpg";

		return filePath;
	}


	@RequestMapping(value="/manage")
	public String forwardUserManage(){

		return "user_manage";
	}

	//发送邮件
	@ResponseBody
	@RequestMapping(value="manage/sendEmail")
	public String sendEmail(String receiveAddress, HttpServletRequest request){
		System.out.println("sendEmail");
		//生成6位数字的随机数
		CaptchaGenerator generator = new CaptchaGenerator(6, "0123456789");
		String emailCaptcha =  generator.next();

		System.out.println(receiveAddress);
		String emailRegeXp = "([a-z0-9_\\.-]{2,15})@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})";
		//把邮件验证码放入session中
		request.getSession().setAttribute("emailCaptcha", emailCaptcha);

		//如果邮件格式不正确，提前返回
		if (! receiveAddress.matches(emailRegeXp))
			return "邮箱格式不正确";

		request.getSession().setAttribute("emailAddress", receiveAddress);
		if ( userService.sendVerifyEmail(receiveAddress, emailCaptcha)){
			return "发送成功";
		}else
		{
			return "发送失败";
		}
	}

	//绑定邮箱操作
	@RequestMapping(value = "manage/bindEmail", method=RequestMethod.POST)
	public String bindUserEmail(@RequestParam("emailCaptcha") String userInputCode, 
			String receiveAddress, HttpServletRequest request){
		
		//把邮箱地址放入request中
		request.setAttribute("emailAddress", receiveAddress);

		String emailRegeXp = "([a-z0-9_\\.-]{2,15})@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})";
		//判断输入的邮箱是否为空
		if (receiveAddress == null || receiveAddress.equals(""))
		{
			request.setAttribute("bindResult", "邮箱不能为空");
			return "user_manage";
		}
		
		//如果邮件格式不正确，提前返回
		if (! receiveAddress.matches(emailRegeXp))
		{
			request.setAttribute("bindResult", "邮箱格式不正确");
			return "user_manage";
		}
		
		//先判断是否为null，短路运算符
		if (userInputCode != null && userInputCode.equals(""))
		{
			request.setAttribute("bindResult", "请输入验证码");
			return "user_manage";
		}

		//获取服务器端产生的验证码及服务器发送的邮箱地址
		String realEmailCode = (String) request.getSession().getAttribute("emailCaptcha");
		String serverSendAddress = (String) request.getSession().getAttribute("emailAddress");

		//如果用户输入的邮箱地址和服务器发送的邮箱地址相同
		//防止先获取了验证码，再使用其他的邮箱绑定
		if (serverSendAddress != null && !receiveAddress.equals(serverSendAddress))
		{
			request.setAttribute("bindResult", "发送邮件的邮箱和要绑定的邮箱不同");
			return "user_manage";
		}

		logger.info("邮件验证码：" + realEmailCode);
		logger.info("用户输入的验证码：" + userInputCode);
		//如果用户邮件验证码输入正确
		if ( realEmailCode != null &&
				userInputCode.equals(realEmailCode))
		{
			//从session中取得LoginingUser实例
			User user = (User) request.getSession().getAttribute("loginedUser");
			String userId = user.getUserId();
			//进行绑定操作
			if (userService.bindEmail(userId, receiveAddress) == true){
				request.setAttribute("bindResult", "邮箱绑定成功");
				//绑定成功的话，将属性从session中移除
				request.getSession().removeAttribute("emailCaptcha");
				request.getSession().removeAttribute("emailAddress");
				//更新session中登录用户的信息
				request.getSession().setAttribute("loginedUser", userService.findUserByUserId(userId));
				logger.info(userId + "用户邮箱绑定成功");
			}
			else
			{
				logger.info(userId + "绑定邮箱失败");
				request.setAttribute("bindResult", "邮箱绑定失败");
			}
		}else {
			request.setAttribute("bindResult", "验证码不正确，请确认");
		}
		return "user_manage";
	}
	//上传头像
	@RequestMapping(value="manage/upHeadScul")
	public String upHeadScul(@RequestParam(value="headScul")MultipartFile headScul , HttpServletRequest request) throws IllegalStateException, IOException{
		//获取web根目录
		String rootPath = UploadOperation.getContextPath(request); 
		//从session中获取登录的User实例
		User loginedUser = (User) request.getSession().getAttribute("loginedUser");
		String userId = loginedUser.getUserId();
		//上传的文件名
		String fileName = headScul.getOriginalFilename();
		//文件扩展名
		String prefix=fileName.substring(fileName.lastIndexOf(".")+1);
		String userDirPath = UploadOperation.getUserDirPath(rootPath, userId);
		
		UploadOperation.operUserUpDir(userDirPath);

		//文件路径，上传到用户独立的文件夹，如uploads/1072842511，表示用户Id为1072842511上传的图片
		String filePath = UploadOperation.getUploadPath(rootPath, userId, prefix);
		
		
		if (!headScul.isEmpty())
		{
			String contentType = headScul.getContentType();
			//判断是否是图片的格式，如JPEG
			if (UploadOperation.isVaildPicture(contentType))
			{
				UploadOperation.deleteUploadedHead(userDirPath);
				headScul.transferTo(new File(filePath));
				request.setAttribute("upLoadResult", "上传头像成功");
				//更新数据库中用户头像
				userService.updateHeadscul(userId, "headScul." + prefix);
				//更新session中登录用户的信息
				request.getSession().setAttribute("loginedUser", userService.findUserByUserId(userId));
			}
			else {
				request.setAttribute("upLoadResult", "上传的图片必须是JPG或PNG或GIF格式！");
			}
		} else
			request.setAttribute("upLoadResult", "请选择图片!");
		return "user_manage";
	}

}
