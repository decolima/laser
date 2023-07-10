package tag.tagmanager;

import java.io.IOException;

public class BluetoothDeviceScanner {
/*
    public void scanDevices() {
        try {
            LocalDevice localDevice = LocalDevice.getLocalDevice();

            DiscoveryAgent agent = localDevice.getDiscoveryAgent();
            agent.startInquiry(DiscoveryAgent.PREKNOWN, new DeviceDiscoveryListener());

            System.out.println("Procurando por dispositivos Bluetooth...");

        } catch (BluetoothStateException e) {
            e.printStackTrace();
        }
    }

    private static class DeviceDiscoveryListener implements DiscoveryListener {

        @Override
        public void deviceDiscovered(RemoteDevice remoteDevice, DeviceClass deviceClass) {
            try {
                String deviceName = remoteDevice.getFriendlyName(false);
                String deviceAddress = remoteDevice.getBluetoothAddress();

                System.out.println("Dispositivo encontrado: " + deviceName + " (" + deviceAddress + ")");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        @Override
        public void inquiryCompleted(int discType) {
            System.out.println("Busca por dispositivos Bluetooth concluída.");
        }

        @Override
        public void serviceSearchCompleted(int transID, int respCode) {}

        @Override
        public void servicesDiscovered(int transID, ServiceRecord[] servRecord) {}
    }
*/
}
