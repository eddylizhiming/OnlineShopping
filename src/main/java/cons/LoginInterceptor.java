package cons;

import javax.naming.AuthenticationException;
import javax.security.auth.login.LoginException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import domain.User;

public class LoginInterceptor extends HandlerInterceptorAdapter {
//	private static final String[] URI_NOT_NEED_LOGIN = {"/index"};
	// "/addToCar" 因为返回的responseBody是要alert所以在controller中处理
	private static final String[] URIS_NEED_LOGIN = {"/manage"};
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	
        HttpSession session = request.getSession();
        //获取请求URI
        String requestURI = request.getRequestURI();
        User user = (User) session.getAttribute("loginedUser");
        //如果是web根目录
        if (isWebRootUrl(request.getRequestURI(), request))
        	return false;
        
        boolean flag = true;
    	//如果是需要登录才能访问的页面。
    	for (String loginURI : URIS_NEED_LOGIN)
    		if (requestURI.contains(loginURI)){
    			System.out.println(requestURI);
    			flag = false;
    			break;
    		}
    	
    	//如果flag还是true，表示不需要登录就可以访问了。
    	if (flag) return true;
    	
        //如果没有登录
        if (user == null) { 
        	//抛出登录异常。。
            throw new LoginException();
        } else {
        	
        	//如果是管理员界面，并且权限不是管理员。。
        	if (requestURI.indexOf("/admin") >0 && !user.getAuthority().equals("admin"))
        	{
        		//抛出认证异常
        		throw new AuthenticationException();
        	}else if (requestURI.indexOf("/user") >0 && !user.getAuthority().equals("ordinary"))
        	{
        		throw new AuthenticationException();
        	}
            return true;
        }
    }
 
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        super.postHandle(request, response, handler, modelAndView);
    }
    
	private boolean isWebRootUrl(String requestURI, HttpServletRequest request){
		//防止用户直接访问根目录操作文件。。
		if (request.getContextPath().equalsIgnoreCase(requestURI)
				||(request.getContextPath() + "/").equals(requestURI)){
			return true;
		}
	
		return false;
	}
}
