package admin.parkWise.administration.configs;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

@Configuration
public class QueueConfig {

    @Value("${amqp.url}")
    private String url;
    @Value("${amqp.password}")
    private String password;

    @Bean
    public String getAmqpUrl(){
        return this.url;
    }
    @Bean
    public String getPassword() {
        return password;
    }
}

