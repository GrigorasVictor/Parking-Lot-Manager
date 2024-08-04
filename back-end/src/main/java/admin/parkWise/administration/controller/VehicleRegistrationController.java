package admin.parkWise.administration.controller;

import admin.parkWise.administration.model.VehicleRegistration;
import admin.parkWise.administration.repository.VehicleRegistrationRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/vehicleRegistration")
public class VehicleRegistrationController{

    @Autowired
    VehicleRegistrationRepo repo;

    @PostMapping("/addRegistration")
    public void addRegistration(@RequestBody VehicleRegistration vehicleRegistration){
        System.out.println(vehicleRegistration);
        repo.save(vehicleRegistration);
    }

    @DeleteMapping("/delete/{id}")
    public void deleteRegistration(@PathVariable Integer id){
        repo.deleteById(id);
    }

    @GetMapping("/getRegistrations")
    public List<VehicleRegistration> getRegistrations(){
        return repo.findAll();
    }

    @GetMapping("/getUser/{id}")
    public Optional<VehicleRegistration> getRegistration(@PathVariable Integer id){
        System.out.println(id);
        return repo.findById(id);
    }
}
