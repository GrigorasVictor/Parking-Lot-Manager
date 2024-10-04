package admin.parkWise.administration.models;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "parking_lots")
public class ParkingLot {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "name", nullable = false)
    @JsonProperty("name")
    private String name;

    @Column(name = "address", nullable = false)
    @JsonProperty("address")
    private String address;
    @Column(name = "lat", nullable = false)
    @JsonProperty("lat")
    private Float lat;
    @Column(name = "lng", nullable = false)
    @JsonProperty("lng")
    private Float lng;

    @Column(name = "total_parking_spaces")
    @JsonProperty("totalParkingSpaces")
    private Integer totalParkingSpaces;

    @Column(name = "available_parking_spaces")
    @JsonProperty("availableParkingSpaces")
    private Integer availableParkingSpaces;
}
