package admin.parkWise.administration.repository;

import admin.parkWise.administration.models.UserAuth;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import java.util.List;

@RepositoryRestResource
public interface  UserAuthRepo extends JpaRepository<UserAuth, Integer> {
    UserAuth findByEmail(String email);
}
