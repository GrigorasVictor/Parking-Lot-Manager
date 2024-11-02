package admin.parkWise.administration.messageQueue;

import admin.parkWise.administration.configs.QueueConfig;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import software.amazon.awssdk.services.s3.endpoints.internal.Value;

import static admin.parkWise.administration.configs.QueueConfig.url;

@Component
public abstract class AbstractQueue {
    protected final int SECONDS = 3000;
    protected final boolean DURABLE = false;
    protected final boolean EXCLUSIVE = false;
    protected final boolean AUTO_DELETE = false;

    protected ConnectionFactory factory;
    protected Connection connection;
    protected Channel channel;

//    private QueueConfig qc;
    @Autowired
    private Environment env;

    @Autowired
    private String url;

    @Autowired
    public void init(){
        try {
            System.out.println(url);
            factory = new ConnectionFactory();
            factory.setUri(url);
            factory.setConnectionTimeout(SECONDS);

            connection = factory.newConnection();
            channel = connection.createChannel();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
