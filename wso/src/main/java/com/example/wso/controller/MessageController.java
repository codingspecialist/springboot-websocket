package com.example.wso.controller;

import com.example.wso.model.Message;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class MessageController {


    @MessageMapping("/hello")
    @SendTo("/topic/hello")
    public Message hello(Message message) throws Exception {
        Thread.sleep(1000); // simulated delay
        return message;
    }
}
