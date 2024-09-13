package admin.parkWise.administration.repository;

import admin.parkWise.administration.model.UserAuth;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import java.util.Optional;

@RepositoryRestResource
public interface UserAuthRepo extends JpaRepository<UserAuth, Integer> {
    Optional<UserAuth> findByEmail(String email);
}
