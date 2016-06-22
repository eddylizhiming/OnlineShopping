/*
 * Created by Roy Oct 14, 2014 2:28:26 PM.                          
 * Copyright (c) 2000-2014 AnXunBen. All rights reserved. 
 */
package tool;


import java.io.IOException;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.directwebremoting.Browser;
import org.directwebremoting.ScriptBuffer;
import org.directwebremoting.ScriptSession;
import org.directwebremoting.ScriptSessions;
import org.directwebremoting.ServerContext;
import org.directwebremoting.ServerContextFactory;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.WebContextFactory.WebContextBuilder;
import org.directwebremoting.impl.DefaultWebContextBuilder;
import org.directwebremoting.proxy.dwr.Util;


public class MySevlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("abcdefg");
		//  PrintWriter out = response.getWriter();
		Browser.withPage("/OnlineShopping/user/index",new Runnable(){
			public void run(){
				ScriptSessions.addFunctionCall("show", "caonima");
			}
		});

	}



}


