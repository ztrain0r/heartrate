<h1 id="toc_0">IOMT Heart Rate Monitor</h1>

<p>Heart rate is serious indicator of varying health issues that may otherwise go unnoticed. Monitoring the heart rate closely is important, which becomes easier and even safer with the convinence of a mobile application receiving data securely with end-to-end encryption via AtSign.</p>

<h2 id="toc_1">1. Setting Up ESP32 Software</h2>

<p>Files needed to use your ESP32 will be located in the <code>Heart Monitor</code> file.</p>

<ol>
<li>First, you will need to get two <a href="https://my.atsign.com/dashboard">AtSign Keys</a>, one to send data and one to receive data.</li>
<li>Download the PlatformIO extension on VS Code. Open a new PlatformIO project with the <code>Heart Monitor</code> folder. </li>
<li>In the <code>Heart Monitor/include/constants.h</code>, add your Wifi name and password. </li>
<li>Put your two AtSign key files in <code>Heart Monitor/data</code>.</li>
<li>Edit <code>Heart Monitor/src/main.cpp</code> to your two AtSigns: one that represents your ESP32 and one that represents the app.</li>
</ol>

<h2 id="toc_2">2. Setting up ESP32 Hardware</h2>

<p>For the hardware, you will need:</p>

<ul>
<li>KS0015 Keyestudio Pulse Rate Monitor</li>
<li>Breadboard</li>
<li>An ESP32</li>
<li>3 jumper wires</li>
<li>Micro-USB data cable</li>
</ul>

<p>To wire up the ESP32:</p>

<ol>
<li>Connect the sensor signal pin to PIN36 of the ESP32.</li>
<li>Connect the sensor positive pin to the 3V pin of the ESP32</li>
<li>Connect the sensor negative pin to the GND pin of the ESP32.</li>
<li>Connect the ESP32 to a computer via USB cable. Upload and monitor main.cpp while the ESP32 is in download mode (by holding the power button and pressing the restart button once), and once the ESP32 begins writing, release the power button and put your finger on the sensor.</li>
<li>After about 10 seconds, you will start seeing beats appear in the terminal. After 15 seconds, your total beats and calculated heartrate will be printed.</li>
</ol>

<p><strong>A picture of the wired up ESP32:</strong></p>

<p><img src="https://media.discordapp.net/attachments/833554069070938116/1105699368381714472/image.png?width=942&amp;height=866" alt=""></p>

<h2 id="toc_3">Java App</h2>

<p>The Java app is used to receive the data sent from the ESP32 and write an output file with the heartrate. In order to set this up, you must:</p>

<ol>
<li>Download Maven on VS Code</li>
<li>Open a Maven Project with <code>/javadata</code></li>
<li>Add your receiving AtSign key to <code>javadata/keys</code></li>
<li>Update your AtKeys in <code>javadata/src/main/.../App.java</code> with your sending and receiving @ signs.</li>
<li>Run app.java. Your read heartrate should be printed in the terminal along with an output .txt file containing your heartrate.</li>
</ol>

<h2 id="toc_4">Flutter App</h2>

<p>After the java app outputted a file, we can now use Flutter to run a real mobile application and read the data from this file.</p>

<ol>
<li>In <code>FlutterApp/lib/main.dart</code>, on line 28 update the path of file contents to reflect the true path of <code>heartrate.txt</code></li>
<li>Navigate to the FlutterApp folder and run <code>flutter run</code> on the folder. The app should then run on a simulator of your choice and display the heart rate read from the ESP32.</li>
</ol>

<p>What the app looks like:</p>
<img src="https://media.discordapp.net/attachments/833554069070938116/1105701131155406878/image.png?width=508&amp;height=1056" alt="">
<img src="https://media.discordapp.net/attachments/833554069070938116/1105701176617476159/image.png?width=490&amp;height=1056" alt="">
