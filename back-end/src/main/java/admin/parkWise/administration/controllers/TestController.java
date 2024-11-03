package admin.parkWise.administration.controllers;

import admin.parkWise.administration.messageQueue.Consumer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {
    @Autowired
    Consumer consumer;

    @GetMapping("/test")
    public ResponseEntity<String> test() {
        consumer.startConsuming();

        return new ResponseEntity<>("a mers", HttpStatus.OK);
    }
}
