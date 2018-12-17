package webserver.services.manage;

import shared.RMICall;
import shared.RMIServerInterface;
import shared.models.manage.AlbumModel;
import shared.models.manage.ManageModel;
import ws.WebSocketAnnotation;

import java.rmi.RemoteException;
import java.util.ArrayList;

public class AddAlbumService implements ManageService {

    @Override
    public boolean add(ManageModel manageModel, String email) {

        boolean r = false;
        boolean exit = false;
        RMIServerInterface server;
        String rsp;

        server = RMICall.waitForServer();

        while (!exit) {
            try {
                if (manageModel instanceof AlbumModel) {
                    AlbumModel album = (AlbumModel) manageModel;
                    if (album.getArtist() != "" && album.getTitle() != "" && album.getDescription() != "" && album.getGenre() != "" && album.getLaunchDate() != "" && album.getEditorLabel() != "") {
                        rsp = server.addAlbum(album.getArtist(), album.getTitle(), album.getDescription(), album.getGenre(), album.getLaunchDate(), album.getEditorLabel(), email);
                        if (rsp.equals("AlbumModel info added with success")) {
                            ArrayList<String> editors;
                            editors = server.getEditors(album.getArtist());
                            for (String ed : editors) {
                                WebSocketAnnotation.sendNotification(ed, "AlbumModel `" + album.getTitle() + "` by " + album.getArtist() + " was edited");
                            }
                            r = true;
                        }
                    }

                }
                exit = true;

            } catch (RemoteException e) {
                server = RMICall.waitForServer();
            }
        }

        return r;
    }

}
