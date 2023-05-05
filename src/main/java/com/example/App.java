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
        AtSign java = new AtSign("@bittersweet8");
        AtSign esp32 = new AtSign("@the60melted");

        AtClient atClient = AtClient.withRemoteSecondary("root.atsign.org:64", java);

        SharedKey sharedKey = new KeyBuilders.SharedKeyBuilder(esp32, java).key("heartrate").build();

        String data = atClient.get(sharedKey).get();
        PrintWriter writer = new PrintWriter("heartrate.txt", "UTF-8");
        writer.println(data);
        writer.close();
        System.out.println("Heart rate: " + data + "bpm");
    }
}
