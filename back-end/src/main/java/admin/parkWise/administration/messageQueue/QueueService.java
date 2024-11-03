package admin.parkWise.administration.messageQueue;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.ContextStartedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Component
public class QueueService {
    @Autowired
    private Consumer consumer;

    @EventListener(ApplicationReadyEvent.class)
    public void startQueue(){
        System.out.println("Queue started here");
        consumer.startConsuming();
    }
}
