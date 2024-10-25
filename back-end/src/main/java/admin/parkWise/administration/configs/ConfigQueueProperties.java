package admin.parkWise.administration.configs;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration

public class ConfigQueueProperties {

    @Value("${amqp.url}")
    private String url;

    @Bean
    public String getUrl(){
        return this.url;
    }

}

