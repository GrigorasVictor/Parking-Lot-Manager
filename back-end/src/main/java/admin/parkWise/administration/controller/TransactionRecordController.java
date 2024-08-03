package admin.parkWise.administration.controller;

import admin.parkWise.administration.model.TransactionRecord;
import admin.parkWise.administration.repository.TransactionRecordRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/transactionRecord")
public class TransactionRecordController {

    @Autowired
    TransactionRecordRepo repo;

    @PostMapping("/addTransaction")
    public void addUser(@RequestBody TransactionRecord transactionRecord){
        System.out.println(transactionRecord);
        repo.save(transactionRecord);
    }

    @DeleteMapping("/delete/{id}")
    public void deleteUser(@PathVariable Integer id){
        repo.deleteById(id);
    }

    @GetMapping("/getTransactions")
    public List<TransactionRecord> getAllUsers(){
        return repo.findAll();
    }

    @GetMapping("/getTransaction/{id}")
    public Optional<TransactionRecord> getUser(@PathVariable Integer id){
        System.out.println(id);
        return repo.findById(id);
    }
}
