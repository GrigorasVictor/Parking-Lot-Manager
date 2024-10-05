package admin.parkWise.administration.controllers;

import admin.parkWise.administration.models.ParkingLot;
import admin.parkWise.administration.repository.ParkingLotRepo;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/parkingLot")
public class ParkingLotController extends AbstractController<ParkingLot, ParkingLotRepo>{
}
