package webserver.services.manage;

import shared.RMICall;
import shared.models.manage.Artist;
import shared.models.manage.ManageModel;
import shared.RMIServerInterface;
import ws.WebSocketAnnotation;

import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.util.ArrayList;

public class AddArtistService implements ManageService {

    @Override
    public boolean add(ManageModel manageModel, String email) {

        boolean exit = false;
        RMIServerInterface server = RMICall.waitForServer();
        String rsp;

        while(!exit) {

            try {
                if (manageModel instanceof Artist) {
                    Artist artist = (Artist) manageModel;
                    if (artist.getName() != "" && artist.getDetails() != "") {
                        rsp = server.addArtist(artist.getName(), artist.getDetails(), email);
                        if (rsp.equals("Artist created") || rsp.equals("Artist `" + artist.getName() + "` was edited") || rsp.equals("Artist info added with success")) {
                            ArrayList<String> editors = new ArrayList<>();
                            editors = server.getEditors(artist.getName());
                            for (String ed : editors)
                                WebSocketAnnotation.sendNotification(ed, "Artist " + artist.getName() + " was edited by " + email);

                            return true;
                        } else {
                            return false;
                        }
                    }
                }
                exit = true;

            } catch (RemoteException e) {
                server = RMICall.waitForServer();
            }
        }
        return false;
    }
}
