package admin.parkWise.administration.controller;

import admin.parkWise.administration.model.User;
import admin.parkWise.administration.model.VehicleRegistration;
import admin.parkWise.administration.repository.VehicleRegistrationRepo;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/vehicleRegistration")
public class VehicleRegistrationController extends AbstractController<VehicleRegistration, VehicleRegistrationRepo>{
    @GetMapping("/user/{id}")
    public ResponseEntity<List<VehicleRegistration>> getUsersLicences(@PathVariable Integer id){
        return new ResponseEntity<>(repo.findByUserId(new User(id)), HttpStatus.OK);
    }
}
