package admin.parkWise.administration.controllers;

import admin.parkWise.administration.models.ParkingRecord;
import admin.parkWise.administration.repository.ParkingRecordsRepo;
import org.springframework.web.bind.annotation.*;

@RestController
public class ParkingRecordsController extends AbstractController<ParkingRecord, ParkingRecordsRepo>{
}
