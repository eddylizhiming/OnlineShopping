package tool;
import org.directwebremoting.Browser;
import org.directwebremoting.ScriptSessions;

public class sendMsg {

	public void sendMsg(final String msg){
		System.out.println("now is pushing……");
        Browser.withPage("/dwr-test/showMsg.jsp",new Runnable(){
	        public void run(){
	        	System.out.println("aa");
	            ScriptSessions.addFunctionCall("show", msg);
	        }
	    });
	}
}
