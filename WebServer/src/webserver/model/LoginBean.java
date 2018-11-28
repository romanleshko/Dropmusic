/**
 * Raul Barbosa 2014-11-07
 */
package webserver.model;
import rmiserver.RMIServerInterface;
import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;


public class LoginBean {
	private RMIServerInterface server;
	private String username; // username and password supplied by the user
	private String password;

	public LoginBean() {
		try {
			server = (RMIServerInterface) LocateRegistry.getRegistry("localhost", 1099).lookup("rmiserver");
		}
		catch(NotBoundException|RemoteException e) {
			e.printStackTrace(); // what happens *after* we reach this line?
		}
	}



	public boolean getUserMatchesPassword() throws RemoteException {

		boolean r;
		String rsp = server.login(username, password);

		if (rsp.equals("Logged in successfully " + username))
		{
			r = true;
		} else
		{
			r = false;
		}

		return r;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
}