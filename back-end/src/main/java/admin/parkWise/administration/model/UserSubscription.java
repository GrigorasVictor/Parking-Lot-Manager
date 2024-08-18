package admin.parkWise.administration.model;


import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;

@Data
@Entity
@Table(name = "user_subscriptions")
public class UserSubscription {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "subscription_id")
    private Integer subscriptionId;

    @JsonProperty("user_id")
    @Column(name = "user_id")
    private Integer userId;

    @Column(name="start_date")
    @JsonProperty("start_date")
    private LocalDate startDate;

    @Column(name="end_date")
    @JsonProperty("end_date")
    private LocalDate  endDate;

    @Column(name="parking_space")
    @JsonProperty("parking_space")
    private Integer parkingSpace;
}
