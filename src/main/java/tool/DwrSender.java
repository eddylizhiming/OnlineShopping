package tool;
import org.apache.log4j.Logger;
import org.directwebremoting.Browser;
import org.directwebremoting.ScriptSessions;

public class DwrSender {

	private static Logger logger = Logger.getLogger(DwrSender.class);
	public void sendMsg(final String msg){
		logger.info("now is pushing:" + msg);
	
		  Browser.withPage("/OnlineShopping/serverMsg_receive.jsp",new Runnable(){
		        public void run(){
		        	System.out.println("ab");
		            ScriptSessions.addFunctionCall("recvServerMsg", msg);
		        }
		    });
	}
}
