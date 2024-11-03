package admin.parkWise.administration.messageQueue;

import admin.parkWise.administration.configs.QueueConfig;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;

@Service
public class QueueFactory {
    @Autowired
    QueueConfig queueConfig;

    public ConnectionFactory factory;
    public Connection connection;
    public Channel channel;

    @Bean
    public Consumer consumer(){
        return new Consumer(queueConfig);
    }
}
