package admin.parkWise.administration.controllers;

import admin.parkWise.administration.models.TransactionRecord;
import admin.parkWise.administration.repository.TransactionRecordRepo;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/transactionRecord")
public class TransactionRecordController  extends AbstractController<TransactionRecord, TransactionRecordRepo>{
}
