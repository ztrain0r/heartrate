package com.example;
import org.atsign.client.api.AtClient;
import org.atsign.common.AtSign;
import org.atsign.common.KeyBuilders;
import org.atsign.common.Keys.SharedKey;
import java.io.PrintWriter;


public class App 
{
    public static void main( String[] args ) throws Exception
    {
        AtSign java = new AtSign("@"); // RECEIVING ATSIGN
        AtSign esp32 = new AtSign("@"); // SENDING (ESP32) ATSIGN

        AtClient atClient = AtClient.withRemoteSecondary("root.atsign.org:64", java);

        SharedKey sharedKey = new KeyBuilders.SharedKeyBuilder(esp32, java).key("heartrate").build();

        String data = atClient.get(sharedKey).get(); // get the heartrate sent from the ESP32
        PrintWriter writer = new PrintWriter("heartrate.txt", "UTF-8"); // output a file
        writer.println(data); // writes to new file outputting heartrate (just a number)
        writer.close();
        System.out.println("Heart rate: " + data + "bpm"); // prints heartrate to terminal (testing purposes)
    }
}
