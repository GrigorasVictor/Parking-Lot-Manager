package admin.parkWise.administration.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.ResponseInputStream;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.core.sync.ResponseTransformer;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.*;

import java.io.IOException;
import java.net.URI;
import java.nio.file.Paths;

@Service
public class AwsStorageService {
    @Value("${filebase.endpoint}")
    private String filebaseEndpoint;

    @Value("${filebase.bucket.name}")
    private String bucketName;

    @Autowired
    private S3Client s3Client;

    public String uploadFile(MultipartFile file) {
        if(file.isEmpty())
            throw new IllegalArgumentException("File name cannot be empty.");

        String fileName = file.getOriginalFilename();
        if (fileName == null || fileName.isEmpty()) {
            throw new IllegalArgumentException("File name cannot be empty.");
        }
        
        PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                .bucket(bucketName)
                .key(fileName)
                .build();

        try {
            PutObjectResponse resp = s3Client.putObject(putObjectRequest, RequestBody.fromBytes(file.getBytes()));\

            // VEZI CA AICI ESTE CHETIA ASTA DE ETAG
            // SA VERIFICI DACA E ACCEIASI CU AIA CU CERE PUTEM ACCESA PUBLIC
            // DACA E PUTEM RECONSTRUII LINKU

            System.out.println(resp);

            return resp.eTag(); // Public URL format for Filebase

        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("!! ==== ERROR AWS: " + e.getMessage());
            return null;
        }
    }
}

