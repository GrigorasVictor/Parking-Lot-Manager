package admin.parkWise.administration.messageQueue;

import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import com.rabbitmq.client.DeliverCallback;
import org.springframework.beans.factory.annotation.Value;

import java.util.concurrent.atomic.AtomicReference;

public class Consumer {
    private final int SECONDS = 3000;
    private final boolean DURABLE = false;
    private final boolean EXCLUSIVE = false;
    private final boolean AUTO_DELETE = false;
    private final String QUEUE = "validation";

    @Value("${ampq-url}")
    private String channelUrl;

    private ConnectionFactory factory;
    private Connection connection;
    private Channel channel;
    public Consumer(){
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

    public String consume(String routingKey){
        AtomicReference<String> message = new AtomicReference<>("Empty");
        try {
            channel.queueDeclare(QUEUE, DURABLE, EXCLUSIVE, AUTO_DELETE, null);
            DeliverCallback deliverCallback = (consumerTag, delivery) -> {
                message.set(new String(delivery.getBody(), "UTF-8"));
                System.out.println("Cloud_AMPQ: Received message: " + message);

            };
            channel.basicConsume(QUEUE, true, deliverCallback, consumerTag -> {});
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return message.get();
    }
}
