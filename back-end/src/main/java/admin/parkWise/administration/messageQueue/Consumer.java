package admin.parkWise.administration.messageQueue;
import com.rabbitmq.client.DeliverCallback;

import java.nio.charset.StandardCharsets;

public class Consumer extends QueueFactory{
    private final String QUEUE = "validation";

    public Consumer(){
        super();
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

    public static void main(String[] args) {
        Consumer consumer = new Consumer();
        consumer.startConsuming();
    }
}
