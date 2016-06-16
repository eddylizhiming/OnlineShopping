package tool;

import java.util.Random;

import org.springframework.stereotype.Component;

import com.github.cage.IGenerator;

/**
 * 验证码生成器
 */
@Component("myTokenGenerator")
public class CaptchaGenerator implements IGenerator<String> {
    private int length = 4;
    private String charsetdir = "23456789abcdefghigkmnpqrstuvwxyzABCDEFGHIGKLMNPQRSTUVWXYZ";
    private static final Random r = new Random();
    public CaptchaGenerator() {
    }
    public CaptchaGenerator(int length, String charsetdir) {
        this.length = length;
        this.charsetdir = charsetdir;
    }
    
    public String next() {
        StringBuffer sb = new StringBuffer();
        int len = charsetdir.length();
        for (int i = 0; i < length; i++) {
            sb.append(charsetdir.charAt(r.nextInt(len - 1)));
        }
        return sb.toString();
    }
    public static void main(String[] args) {
    	CaptchaGenerator t = new CaptchaGenerator();
        for (int i = 0; i < 100; i++) {
            System.out.println(t.next());
        }
    }
}