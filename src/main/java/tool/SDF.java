package tool;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;

public class SDF {

	public static void main(String[] args) {
		
		WebDriver driver = new HtmlUnitDriver();
		driver.get("http://www.people.com.cn/");
		String html = driver.getPageSource();
	//	System.out.println(driver.getPageSource());
		Document document = Jsoup.parse(html);
		Element infoDiv =  document.getElementById("list_new_c_1");
		System.out.println(infoDiv);		
	}
}
