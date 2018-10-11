import java.io.IOException;
import java.net.DatagramPacket;
import java.net.InetAddress;
import java.net.MulticastSocket;
import java.util.concurrent.CopyOnWriteArrayList;

public class MulticastServerResponse extends Thread {

    private DatagramPacket packet;
    private MulticastSocket sendSocket = null; // socket to respond to Multicast group
    private int PORT;
    private String MULTICAST_ADDRESS;
    private CopyOnWriteArrayList<User> users;

    MulticastServerResponse(DatagramPacket packet, int port, String ip, CopyOnWriteArrayList<User> users) {

        this.packet = packet;
        PORT = port;
        MULTICAST_ADDRESS = ip;
        this.users = users;
    }

    public void sendResponseMulticast(String resp) {

        try {
            MulticastSocket socket = new MulticastSocket();
            byte[] buffer = resp.getBytes();
            InetAddress group = InetAddress.getByName(MULTICAST_ADDRESS);
            DatagramPacket packet = new DatagramPacket(buffer, buffer.length, group, PORT);
            socket.send(packet);

        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    public void register(String[] tokens) {
        // type | register; flag | (s/r); username | name; password | pw; result | (y/n)
        // [0] [1]   [2]    [3] [4] [5]      [6]  [7] [8]   [9]   [10] [11] [12]

        // Verificar se existe

        String name = tokens[8].substring(0, tokens[8].length() - 1);
        String password = tokens[11].substring(0, tokens[11].length() - 1);

        System.out.println("Gonna register " + name +" with password ********");

        // Fazer registo e adicionar a BD o novo user

        System.out.println(name + password);
        this.users.add(new User(name, password));
        System.out.println("Users: ");

        for (User u : this.users)
            System.out.println(u);


        String rsp = "type | register; flag | r; username | "+name+"; password | "+password+"; result | y";
        sendResponseMulticast(rsp);

    }

    public void run() {

        System.out.println("Received packet from " + packet.getAddress().getHostAddress() + ":" + packet.getPort() + " with message:");
        String message = new String(packet.getData(), 0, packet.getLength());
        System.out.println(message);

        // Decode message
        String[] tokens = message.split(" ");

        if (tokens[2].equals("register;") && tokens[5].equals("s;")) {
            register(tokens);
        } else {
            System.out.println("Invalid protocol message");
        }


    }


}
