package admin.parkWise.administration.configs;

import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class QueueConfig { // TODO: needs renaming
    public final int SECONDS = 3000;

    @Value("${amqp.url}")
    public String url = "amqps://jcjuueuk:YgdVAqQkaln9sXpkh9BFMgZfe3PGDE2H@sparrow.rmq.cloudamqp.com/jcjuueuk";

    @Value("${amqp.password}")
    public String password = "YgdVAqQkaln9sXpkh9BFMgZfe3PGDE2H";


    public QueueConfig(String url, String password) {
        this.url = url;
        this.password = password;
    }
}

