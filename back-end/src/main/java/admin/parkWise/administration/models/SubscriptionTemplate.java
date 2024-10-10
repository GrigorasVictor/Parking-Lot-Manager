package admin.parkWise.administration.models;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@Table(name = "subscription_templates")
@AllArgsConstructor
@NoArgsConstructor
public class SubscriptionTemplate {
    @Id
    @Column(name = "id", nullable = false)
    @JsonProperty("id")
    private Integer subscriptionTemplateId;

    @Column(name = "time_length", nullable = false)
    @JsonProperty("timeLength")
    private String timeLength;

    @Column(name = "name")
    @JsonProperty("name")
    private String name;

    @Column(name = "price")
    @JsonProperty("price")
    private Float price;
}
