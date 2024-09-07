package admin.parkWise.administration.controller;
import admin.parkWise.administration.model.VehicleRegistration;
import admin.parkWise.administration.repository.VehicleRegistrationRepo;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/vehicleRegistration")
public class VehicleRegistrationController extends AbstractController<VehicleRegistration, VehicleRegistrationRepo>{

}
