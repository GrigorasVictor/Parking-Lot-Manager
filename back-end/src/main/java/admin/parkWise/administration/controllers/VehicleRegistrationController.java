package admin.parkWise.administration.controllers;
import admin.parkWise.administration.models.VehicleRegistration;
import admin.parkWise.administration.repository.VehicleRegistrationRepo;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/vehicleRegistration")
public class VehicleRegistrationController extends AbstractController<VehicleRegistration, VehicleRegistrationRepo>{
}
