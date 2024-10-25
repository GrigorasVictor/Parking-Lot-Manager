package admin.parkWise.administration.messageQueue;

import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import org.springframework.beans.factory.annotation.Value;

public class Producer {
    private final int SECONDS = 3000;
    private final boolean DURABLE = false;
    private final boolean EXCLUSIVE = false;
    private final boolean AUTO_DELETE = false;
    private final String QUEUE = "licencePlate";

    @Value("${ampq-url}")
    private String channelUrl;

    private ConnectionFactory factory;
    private Connection connection;
    private Channel channel;
    public Producer(){
        try {
            factory = new ConnectionFactory();
            factory.setUri(channelUrl);
            factory.setConnectionTimeout(SECONDS);

            connection = factory.newConnection();
            channel = connection.createChannel();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public void publish(String routingKey, String message){
        try {
            channel.queueDeclare(QUEUE, DURABLE, EXCLUSIVE, AUTO_DELETE, null);
            channel.basicPublish("", routingKey, null, message.getBytes());
            System.out.println("Cloud_AMPQ: Sent message: " + message);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
