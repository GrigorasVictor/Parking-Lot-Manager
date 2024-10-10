package admin.parkWise.administration.controllers;

import admin.parkWise.administration.models.SubscriptionTemplate;
import admin.parkWise.administration.repository.SubscriptionTemplateRepo;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/subscription-templates")
public class SubscriptionTemplateController extends AbstractController<SubscriptionTemplate, SubscriptionTemplateRepo> {

}
