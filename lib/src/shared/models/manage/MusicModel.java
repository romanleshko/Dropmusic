package shared.models.manage;

import shared.RMICall;
import shared.RMIServerInterface;

import java.io.Serializable;
import java.rmi.ConnectException;
import java.rmi.RemoteException;

import java.util.Map;

/**
 * A music model following JavaBean convention
 * Connects to RMI
 */

public class MusicModel implements Serializable, ManageModel {
    private static final long serialVersionUID = 1234675L;

    private String track;
    private String title;
    private String lyrics;
    private String albumTitle;
    private String artistName;
    private String fileName;
    private String email; // used in shareMusic


    public MusicModel(String track, String title, String lyrics, String albumTitle, String artistName, String email) {
        setTrack(track);
        setTitle(title);
        setLyrics(lyrics);
        setAlbumTitle(albumTitle);
        setArtistName(artistName);
        setEmail(email);
        System.out.println("constructior "+email );
    }

    public MusicModel()
    {
        this(null , null, null, null, null, null);
    }

    public MusicModel(String track, String title, String lyrics) {
        this.track = track;
        this.title = title;
        this.lyrics = lyrics;
        //  this.musicFiles = new ConcurrentHashMap<String, MusicFile>();
    }

    /**
     * Fetches music's shareable link
     * Calls RMI's .getMusicURL()
     * If RemoteException then tries again
     * @param inputModel music's info
     * @param email to check if he's allowed
     * @return Dropbox's shareable URL
     */

    public String getURL(MusicModel inputModel, String email) {

        boolean r = false, exit = false;
        RMIServerInterface server = RMICall.waitForServer();
        String url = "";

        while(!exit)
        {

            try
            {
                url = server.getMusicURL(inputModel.getArtistName(), inputModel.getAlbumTitle(), inputModel.getTitle(), email);
                exit = true;
            } catch (ConnectException e) {
                System.out.println("RMI server down, retrying...");
            } catch (RemoteException tt) {
                System.out.println("RMI server down, retrying...");
            }
            server = RMICall.waitForServer();
        }

        return url;
    }

    /**
     * Associates a dropbox's shared URL to a Music in DB
     * Calls RMI's .associateMusic()
     * If RemoteException then tries again
     * @param session
     * @param artist
     * @param album
     * @param musicTitle
     * @param fileName
     * @return Whether action was successful or not
     */

    public boolean associateMusic(Map<String, Object> session, String artist, String album, String musicTitle, String fileName) {

        System.out.println("AssociateMusicService - execute()");


        boolean r = false, exit = false, rr = false;
        RMIServerInterface server = RMICall.waitForServer();

        while(!exit)
        {

            try
            {
                rr = server.associateMusic((String) session.get("email"), artist, album, musicTitle, fileName);
                exit = true;

            } catch (ConnectException e) {
                System.out.println("RMI server down, retrying...");
            } catch (RemoteException tt) {
                System.out.println("RMI server down, retrying...");
            }
            server = RMICall.waitForServer();
        }



        return rr;
    }

    /**
     * Allows an user access to this music's link
     * @param email
     * @return Whether operation was successful or not
     */

    public boolean shareMusic(String emailModel, String email) {
        System.out.println("Recebi "+emailModel);

        boolean r = false, exit = false;
        RMIServerInterface server = RMICall.waitForServer();

        while(!exit)
        {

            try
            {

                if (server.shareMusic(emailModel, this.artistName, this.albumTitle, this.title, email))
                {
                    r = true;
                }
                else
                {
                    r = false;
                }

                exit = true;
                
            } catch (ConnectException e) {
                System.out.println("RMI server down, retrying...");
            } catch (RemoteException tt) {
                System.out.println("RMI server down, retrying...");
            }
            server = RMICall.waitForServer();
        }


        return r;
    }

    @Override
    public String toString() {
        return track+ " - "+title;
    }

    public String getAlbumTitle() {
        return albumTitle;
    }

    public void setAlbumTitle(String albumTitle) {
        this.albumTitle = albumTitle;
    }

    public String getArtistName() {
        return artistName;
    }

    public void setArtistName(String artistName) {
        this.artistName = artistName;
    }

    public String getTrack() {
        return track;
    }

    public void setTrack(String track) {
        this.track = track;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }


    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLyrics() {
        return lyrics;
    }

    public void setLyrics(String lyrics) {
        this.lyrics = lyrics;
    }
}



