/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package tag.tagmanager;

import com.welie.blessed.BluetoothCentralManager;
import com.welie.blessed.BluetoothCentralManagerCallback;
import com.welie.blessed.BluetoothPeripheral;
import com.welie.blessed.BluetoothPeripheralCallback;
import com.welie.blessed.ScanResult;
import java.time.Duration;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import static tag.tagmanager.Notification.printDevice;
import static tag.tagmanager.Notification.running;
import tinyb.BluetoothDevice;
import tinyb.BluetoothGattCharacteristic;
import tinyb.BluetoothGattService;
import tinyb.BluetoothManager;


/**
 *
 * @author andrelima
 */
public class manager {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws InterruptedException  {
        // TODO code application logic here
        System.out.println("tag.tagmanager.manager.main()");
        
       if (args.length < 1) {
            System.err.println("Run with <device_address> argument");
            System.exit(-1);
        }

    
        BluetoothManager manager = BluetoothManager.getBluetoothManager();

        
        boolean discoveryStarted = manager.startDiscovery();

        System.out.println("The discovery started: " + (discoveryStarted ? "true" : "false"));

        
        BluetoothDevice sensor = manager.find(null, args[0], null, Duration.ofSeconds(10));

        if (sensor == null) {
            System.err.println("No sensor found with the provided address.");
            System.exit(-1);
        }

        sensor.enableConnectedNotifications(new ConnectedNotification());

        System.out.print("Found device: ");
        printDevice(sensor);

        if (sensor.connect())
            System.out.println("Sensor with the provided address connected");
        else {
            System.out.println("Could not connect device.");
            System.exit(-1);
        }

        
        Lock lock = new ReentrantLock();
        Condition cv = lock.newCondition();

        Runtime.getRuntime().addShutdownHook(new Thread() {
            @Override
            public void run() {
                running = false;
                lock.lock();
                try {
                    cv.signalAll();
                } finally {
                    lock.unlock();
                }
            }
        });

        
        BluetoothGattService tempService = sensor.find( "f000aa00-0451-4000-b000-000000000000");

        if (tempService == null) {
            System.err.println("This device does not have the temperature service we are looking for.");
            sensor.disconnect();
            System.exit(-1);
        }
        System.out.println("Found service " + tempService.getUUID());

        BluetoothGattCharacteristic tempValue = tempService.find("f000aa01-0451-4000-b000-000000000000");
        BluetoothGattCharacteristic tempConfig = tempService.find("f000aa02-0451-4000-b000-000000000000");
        BluetoothGattCharacteristic tempPeriod = tempService.find("f000aa03-0451-4000-b000-000000000000");

        if (tempValue == null || tempConfig == null || tempPeriod == null) {
            System.err.println("Could not find the correct characteristics.");
            sensor.disconnect();
            System.exit(-1);
        }

        System.out.println("Found the temperature characteristics");

        
        byte[] config = { 0x01 };
        tempConfig.writeValue(config);
        
        byte[] period = { 100 };
        tempPeriod.writeValue(period);

        tempValue.enableValueNotifications(new ValueNotification());

        lock.lock();
        try {
            while(running)
                cv.await();
        } finally {
            lock.unlock();
        }
        sensor.disconnect();
 
        
    }
    
}
