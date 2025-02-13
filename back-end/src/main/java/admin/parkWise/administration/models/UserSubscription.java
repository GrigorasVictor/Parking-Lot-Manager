package admin.parkWise.administration.models;

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

    @JsonProperty("subscription_type")
    @Column(name = "subscription_type")
    private String subscriptionType;

    @Column(name="start_date")
    @JsonProperty("start_date")
    private LocalDate startDate;

    @Column(name="end_date")
    @JsonProperty("end_date")
    private LocalDate  endDate;
}
