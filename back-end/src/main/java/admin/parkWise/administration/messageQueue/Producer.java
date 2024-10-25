package admin.parkWise.administration.messageQueue;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class Producer extends QueueFactory {
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
    //daca dai url hardcodat, merge
    public static void main(String[] args) {
        Producer producer = new Producer();

        producer.publish("licencePlate", "din Java");
    }
}
