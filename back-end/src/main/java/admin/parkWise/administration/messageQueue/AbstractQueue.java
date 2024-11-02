package admin.parkWise.administration.messageQueue;

import admin.parkWise.administration.configs.QueueConfig;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.stereotype.Service;

@Service
@Configurable
public abstract class AbstractQueue {
    protected final int SECONDS = 3000;
    protected final boolean DURABLE = false;
    protected final boolean EXCLUSIVE = false;
    protected final boolean AUTO_DELETE = false;

    protected ConnectionFactory factory;
    protected Connection connection;
    protected Channel channel;
    @Autowired
    private QueueConfig configQueueProperties;

    public AbstractQueue(QueueConfig qc){
        try {
            configQueueProperties = qc;
            System.out.println(configQueueProperties.getAmqpUrl());
            factory = new ConnectionFactory();
            factory.setUri(configQueueProperties.getAmqpUrl());
            factory.setConnectionTimeout(SECONDS);

            connection = factory.newConnection();
            channel = connection.createChannel();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
