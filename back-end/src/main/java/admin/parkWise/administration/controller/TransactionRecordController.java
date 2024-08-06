package admin.parkWise.administration.controller;

import admin.parkWise.administration.model.TransactionRecord;
import admin.parkWise.administration.repository.TransactionRecordRepo;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/transactionRecord")
public class TransactionRecordController  extends AbstractController<TransactionRecord, TransactionRecordRepo>{
}
