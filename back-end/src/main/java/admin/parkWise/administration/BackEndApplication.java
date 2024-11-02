package admin.parkWise.administration;

import admin.parkWise.administration.configs.QueueConfig;
import admin.parkWise.administration.messageQueue.Consumer;
import admin.parkWise.administration.messageQueue.QueueComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.bind.annotation.CrossOrigin;

@CrossOrigin
@SpringBootApplication
@EnableScheduling
public class BackEndApplication {

	public static void main(String[] args) {
		(new QueueComponent()).startQueue();
		SpringApplication.run(BackEndApplication.class, args);
	}

}
