package tools;

import com.github.cage.Cage;
import com.github.cage.IGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import javax.annotation.Resource;

@Component
public class MyCage extends Cage {
    public MyCage() {
    }
    @Autowired
    public MyCage(@Qualifier("myTokenGenerator") IGenerator<String> myTokenGenerator) {
        super(null, null, null, null, null, myTokenGenerator, null);
    }
}