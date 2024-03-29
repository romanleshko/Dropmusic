package webserver.actions;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.SessionAware;
import shared.models.manage.MusicModel;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.Map;

/**
 * This action generates a HTML Tag that is returned to the music.jsp with the url of a given song.
 *
 */

public class PlayAction extends ActionSupport implements SessionAware {
    private Map<String, Object> session;

    private MusicModel  inputModel;  // model that maintains the information of the song to obtain
                                     // artist, album, music

    private String      url;         // url of the song to return, gotten from the RMI
    private InputStream stream;      // HTML tag to return using the url gotten from the RMI

    @Override public String execute() {
        setUrl(getInputModel().getURL(inputModel, (String) session.get("email")));
        String rawHTML = "<audio controls src="+url+"></audio>";
        setStream(new ByteArrayInputStream(rawHTML.getBytes()));
        return Action.SUCCESS;
    }

    @Override
    public void setSession(Map<String, Object> session) {
        this.session = session;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Map<String, Object> getSession() {
        return session;
    }

    public MusicModel getInputModel() {
        return inputModel;
    }

    public void setInputModel(MusicModel inputModel) {
        this.inputModel = inputModel;
    }

    public InputStream getStream() {
        return stream;
    }

    public void setStream(InputStream stream) {
        this.stream = stream;
    }
}
