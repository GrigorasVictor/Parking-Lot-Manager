package admin.parkWise.administration.messageQueue;

import admin.parkWise.administration.configs.ConfigQueueProperties;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public abstract class QueueFactory {
    protected final int SECONDS = 3000;
    protected final boolean DURABLE = false;
    protected final boolean EXCLUSIVE = false;
    protected final boolean AUTO_DELETE = false;

    protected ConnectionFactory factory;
    protected Connection connection;
    protected Channel channel;

    @Autowired
    private ConfigQueueProperties configQueueProperties;
    private String channelUrl = configQueueProperties.getUrl();
    public QueueFactory(){
        try {
            System.out.println(channelUrl);
            factory = new ConnectionFactory();
            factory.setUri(channelUrl);
            factory.setConnectionTimeout(SECONDS);

            connection = factory.newConnection();
            channel = connection.createChannel();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
