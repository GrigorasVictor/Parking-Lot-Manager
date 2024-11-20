package admin.parkWise.administration.messageQueue;

import admin.parkWise.administration.configs.QueueConfig;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;

public class QueueConfigFactory {
    @Value("${amqp.url}")
    public String url;// = "amqps://jcjuueuk:YgdVAqQkaln9sXpkh9BFMgZfe3PGDE2H@sparrow.rmq.cloudamqp.com/jcjuueuk";

    @Value("${amqp.password}")
    public String password;// = "YgdVAqQkaln9sXpkh9BFMgZfe3PGDE2H";

    @Bean
    public QueueConfig queueConfig(){
        return new QueueConfig(url, password);
    }
}
