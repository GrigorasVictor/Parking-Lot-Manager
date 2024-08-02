package admin.parkWise.administration.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

import java.time.LocalDate;

@Data
@Entity
@Table(name = "transaction_records")
public class TransactionRecord {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "transaction_id")
    private int transactionId;

    @Column(name = "user_id", nullable = false)
    @JsonProperty("user_id")
    private String userId;

    @Column(name = "transaction_date", nullable = false)
    @JsonProperty("transaction_date")
    private LocalDate transactionDate;

    @Column(name = "amount", nullable = false)
    @JsonProperty("amount")
    private float amount;

    @Column(name = "description", nullable = false)
    @JsonProperty("description")
    private String description;
}
