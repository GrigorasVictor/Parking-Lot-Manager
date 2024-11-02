package admin.parkWise.administration.messageQueue;

import admin.parkWise.administration.configs.QueueConfig;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.stereotype.Component;

@Component
@Configurable
public class Producer extends AbstractQueue {
    private final String QUEUE = "licencePlate";

    public Producer() {
        super();
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

//    public static void main(String[] args) {
//        Producer producer = new Producer();
//
//        producer.publish("licencePlate", "din Java");
//    }
}
