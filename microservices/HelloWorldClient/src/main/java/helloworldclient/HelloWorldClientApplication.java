package helloworldclient;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.client.RestTemplate;

@SpringBootApplication
public class HelloWorldClientApplication {

    public static void main(String[] args) {
        SpringApplication.run(HelloWorldClientApplication.class, args);
    }

    @Bean
    public RestTemplate restTemplateBean(){

        return new RestTemplate();

    }

}
