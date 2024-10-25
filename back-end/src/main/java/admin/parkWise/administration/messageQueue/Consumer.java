package admin.parkWise.administration.messageQueue;

import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import com.rabbitmq.client.DeliverCallback;

import java.nio.charset.StandardCharsets;

public class Consumer {
    private final int SECONDS = 3000;
    private final boolean DURABLE = false;
    private final boolean EXCLUSIVE = false;
    private final boolean AUTO_DELETE = false;
    private final String QUEUE = "validation";

    // Set the RabbitMQ URL either directly or with @Value
    //@Value("${ampq.url}")
    private String channelUrl = "amqps://jcjuueuk:YgdVAqQkaln9sXpkh9BFMgZfe3PGDE2H@sparrow.rmq.cloudamqp.com/jcjuueuk";

    private ConnectionFactory factory;
    private Connection connection;
    private Channel channel;

    public Consumer() {
        try {
            factory = new ConnectionFactory();
            factory.setUri(channelUrl);
            factory.setConnectionTimeout(SECONDS);

            connection = factory.newConnection();
            channel = connection.createChannel();
        } catch (Exception e) {
            System.out.println("Error initializing Consumer: " + e.getMessage());
        }
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
