package admin.parkWise.administration.controller;

import admin.parkWise.administration.model.ParkingRecord;
import admin.parkWise.administration.repository.ParkingRecordsRepo;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/parkingRecords")
public class ParkingRecordsController extends AbstractController<ParkingRecord, ParkingRecordsRepo>{
}
