package admin.parkWise.administration.controller;

 import admin.parkWise.administration.model.ParkingRecord;
 import admin.parkWise.administration.repository.ParkingRecordsRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/parkingRecords")
public class ParkingRecordsController {

    @Autowired
    ParkingRecordsRepo repo;

    @PostMapping("/addParkingRecord")
    public void addParkingRecord(@RequestBody ParkingRecord parkingRecord){
        System.out.println(parkingRecord);
        repo.save(parkingRecord);
    }

    @DeleteMapping("/delete/{id}")
    public void deleteParkingRecord(@PathVariable Integer id){
        repo.deleteById(id);
    }

    @GetMapping("/getParkingRecords")
    public List<ParkingRecord> getAllParkingRecords(){
        return repo.findAll();
    }

    @GetMapping("/getParkingRecord/{id}")
    public Optional<ParkingRecord> getParkingRecord(@PathVariable Integer id){
        System.out.println(id);
        return repo.findById(id);
    }
}
