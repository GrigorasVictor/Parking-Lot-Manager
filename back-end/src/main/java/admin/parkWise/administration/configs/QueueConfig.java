package admin.parkWise.administration.configs;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

@Configuration
@Component
public class QueueConfig {

    @Value("${amqp.url}")
    public static String url;
    @Value("${amqp.password}")
    public static String password;
}

