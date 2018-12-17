package webserver.services;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.Token;
import com.github.scribejava.core.model.Verifier;
import com.github.scribejava.core.oauth.OAuthService;
import shared.RMICall;
import shared.RMIServerInterface;
import uc.sd.apis.DropBoxApi2;

import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.util.Map;

public class AssociateDropBoxTokenService {

    String userToken;

    public AssociateDropBoxTokenService() {
        System.out.println("Starting AssociateDropBoxService()");
        String userToken = "";
    }

    public String canLogin(String code) {

        String r = "";
        boolean exit = false;
        RMIServerInterface server = RMICall.waitForServer();

        System.out.println("LoginDropboxService - canLogin()");

        while(!exit) {

            try {
                return server.canLogin(code);

            } catch (RemoteException e) {
                server = RMICall.waitForServer();
            }
        }

        return r;

    }


    public boolean setUserToken(Map<String, Object> session, String code) {



        boolean r = false;
        RMIServerInterface server = null;

        System.out.println("AssociateDropBoxTokenService - execute()");

        try
        {
            server = (RMIServerInterface) LocateRegistry.getRegistry("localhost", 1099).lookup("rmiserver");
        }
        catch(NotBoundException | RemoteException e) {
            e.printStackTrace();
        }

        try {
            if(server.setToken((String) session.get("email"), code)) {
                r = true;
            }
        } catch (RemoteException e) {
            e.printStackTrace();
        }

        return r;

    }
}
