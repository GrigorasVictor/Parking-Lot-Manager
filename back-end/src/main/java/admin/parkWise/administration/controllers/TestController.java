package admin.parkWise.administration.controllers;

import admin.parkWise.administration.configs.QueueConfig;
import admin.parkWise.administration.messageQueue.Consumer;
import admin.parkWise.administration.messageQueue.QueueComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {

    @GetMapping("/test")
    public ResponseEntity<String> test() {

        (new QueueComponent()).startQueue();
        return new ResponseEntity<>("a mers", HttpStatus.OK);
    }
}
