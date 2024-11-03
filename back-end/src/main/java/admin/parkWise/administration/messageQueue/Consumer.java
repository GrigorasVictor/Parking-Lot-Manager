package admin.parkWise.administration.messageQueue;
import admin.parkWise.administration.configs.QueueConfig;
import com.rabbitmq.client.DeliverCallback;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;

@Component
@Configurable
public class Consumer extends AbstractQueue {
    private final String QUEUE = "validation";

    public Consumer(QueueConfig queueConfig) {
        super(queueConfig);
    }

    public void startConsuming() {
        try {
            channel.queueDeclare(QUEUE, DURABLE, EXCLUSIVE, AUTO_DELETE, null);
            DeliverCallback deliverCallback = (consumerTag, delivery) -> {
                String message = new String(delivery.getBody(), StandardCharsets.UTF_8);
                System.out.println("Cloud_AMPQ: Received message: " + message);
            };
            channel.basicConsume(QUEUE, true, deliverCallback, consumerTag -> {});
            System.out.println("Consumer started, listening for messages on queue: " + QUEUE);
        } catch (Exception e) {
            System.out.println("Error starting consumer: " + e.getMessage());
        }
    }
}
