package admin.parkWise.administration.controller;

import admin.parkWise.administration.model.User;
import admin.parkWise.administration.model.VehicleRegistration;
import admin.parkWise.administration.repository.VehicleRegistrationRepo;
import jakarta.servlet.http.HttpServletResponseWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.net.ssl.SSLSession;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpHeaders;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.List;
import java.util.Optional;

public abstract class AbstractController<T, R extends JpaRepository<T, Integer>>{
    @Autowired
    R repo;

    @PostMapping
    public ResponseEntity<T> add(@RequestBody T newEntry) {
        repo.save(newEntry);
        return new ResponseEntity<>(newEntry, HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Integer id){
        repo.deleteById(id);
    }

    @GetMapping
    public ResponseEntity<List<T>> getAll(){
        return new ResponseEntity<>(repo.findAll(), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Optional<T>> get(@PathVariable Integer id){
        return new ResponseEntity<>(repo.findById(id), HttpStatus.OK);
    }

}

