package admin.parkWise.administration.repository;
import admin.parkWise.administration.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource
public interface UserRepo extends JpaRepository <User, Integer>{

}
