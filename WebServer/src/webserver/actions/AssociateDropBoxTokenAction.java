package webserver.actions;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.SessionAware;
import webserver.services.AssociateDropBoxTokenService;

import java.util.Map;

public class AssociateDropBoxTokenAction extends ActionSupport implements SessionAware {

    private AssociateDropBoxTokenService service = new AssociateDropBoxTokenService();
    private String oauth_token;
    private String code;
    private Map<String, Object> session;
    private String error = null;
    private String error_description = null;

    @Override
    public String execute() {
        String rsp;

        // System.out.println("AssociateDropBoxTokenAction - execute()");
        System.out.println("Code for OAuth " + code);
        System.out.println("token  " + oauth_token);


        if(error == null && error_description == null) {

            if (getSession().get("loggedin") != null) {

                // inside App - associate

                if (getService().setUserToken(session, getCode())) {
                    return "profile";
                } else {
                    return "failed";
                }

            } else {

                // outside App - login
                String email = getService().canLogin(getCode());

                if (!email.equals("null")) {
                    session.put("email", email);
                    session.put("loggedin", true);
                    return "dropmusic";
                } else {
                    return "failed";
                }
            }
        }
        System.out.println(error);

        return "failed";

    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public String getError_description() {
        return error_description;
    }

    public void setError_description(String error_description) {
        this.error_description = error_description;
    }

    public AssociateDropBoxTokenService getService() {
        return service;
    }

    public void setService(AssociateDropBoxTokenService service) {
        this.service = service;
    }

    public String getOauth_token() {
        return oauth_token;
    }

    public void setOauth_token(String oauth_token) {
        this.oauth_token = oauth_token;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Map<String, Object> getSession() {
        return session;
    }

    @Override
    public void setSession(Map<String, Object> session) {
        this.session = session;
    }
}
