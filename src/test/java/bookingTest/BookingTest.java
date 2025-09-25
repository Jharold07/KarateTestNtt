package bookingTest;

import com.intuit.karate.Runner;

public class BookingTest {
    public static void main(String[] args) {
        Runner.path("src/test/java/BookingTest") // Ruta de la carpeta específica
                .outputCucumberJson(true) // Habilitar reporte Cucumber JSON
                .parallel(1); // Ejecutar de forma secuencial
    }
}
