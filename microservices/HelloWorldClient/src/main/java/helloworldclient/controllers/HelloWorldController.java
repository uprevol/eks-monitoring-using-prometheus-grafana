package helloworldclient.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import io.micrometer.core.instrument.Counter;
import io.micrometer.core.instrument.MeterRegistry;

@RestController
public class HelloWorldController {

    @Autowired
    private RestTemplate rest;

    @Value("${HELLO_SERVICE_URL}")
    private String helloServiceUrl;

    @Value("${WORLD_SERVICE_URL}")
    private String worldServiceUrl;
    @Autowired
    private MeterRegistry meterRegistry;  // Inject the MeterRegistry
    @GetMapping("/")
    public String getHelloWorld() {
          Counter helloCounter = meterRegistry.counter("requests.hello");
        helloCounter.increment();  // Increment every time this endpoint is hit
        String hello = rest.getForObject(helloServiceUrl + "/hello", String.class);
        String world = rest.getForObject(worldServiceUrl + "/world", String.class);
        return hello + "*****" + world;
    }
}
