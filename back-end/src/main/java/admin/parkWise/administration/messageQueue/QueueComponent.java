package admin.parkWise.administration.messageQueue;

import admin.parkWise.administration.configs.QueueConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Service
public class QueueComponent {
    public void startQueue(){
        Consumer c = new Consumer();
        c.startConsuming();
    }
}
