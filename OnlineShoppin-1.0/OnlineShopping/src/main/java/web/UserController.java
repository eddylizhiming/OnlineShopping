package web;

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

import domain.LoginingUser;
import service.UserService;
import tools.MyCage;

@Controller
@RequestMapping("/user")
public class UserController {
	
	private static Logger logger = Logger.getLogger(UserController.class);
	@Autowired
	private UserService userService;
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
	public String loginCheck(@Valid @ModelAttribute("user") LoginingUser user, BindingResult bindingResult, @RequestParam(value="captcha") String captcha, 
			HttpServletRequest request, boolean isRememberPwd, @RequestParam("rememberd_days") int rememberd_days,
			HttpServletResponse response){
		
		logger.debug("记住的天数：" + rememberd_days);

		//有校验错误直接返回登录页
		if (bindingResult.hasErrors())
			return "login";
//			System.out.println("用户登录信息格式有错误");
		else
			logger.info("用户登录信息格式无错误");

		if (userService.isUserExist(user.getUserId(), user.getPassword())){
			//如果勾选了记住密码选项且信息正确
			if (isRememberPwd == true){
				Cookie userId = new Cookie("userId", user.getUserId()); 
				Cookie password = new Cookie("password", user.getPassword()); 
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
    public String checkCaptcha(@RequestParam("captcha") String userInputCode, HttpServletRequest request) throws UnsupportedEncodingException
    {
		HttpSession session = request.getSession();
        String realCode = (String) session.getAttribute("captchaToken");
        
        logger.debug("用户输入的验证码：" + userInputCode);
        logger.debug("真实的验证码：" + realCode);

        //暂时不将验证码属性放入session中
//        session.setAttribute("captcha", userInputCode);
        
        if (userInputCode.equalsIgnoreCase(realCode))
        	return "填写正确";
        else
        	return "验证码错误";
    }
}
