package webserver.actions;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.SessionAware;
import shared.manage.ManageModel;
import webserver.services.manage.ManageService;

import java.util.Map;

public class ManageAction extends ActionSupport implements SessionAware {


    private Map<String, Object> session;

    private ManageService manageService;
    private ManageModel manageModel;

    @Override
    public String execute()
    {
        System.out.println("Executing ManageAction - execute()");
        session = ActionContext.getContext().getSession();
        boolean r = getManageService().add(getManageModel(), (String) session.get("email"));

        if(r)
        {
            return "success";
        }
        else
        {
            return "failed";
        }
    }

    @Override
    public void setSession(Map<String, Object> session) {
        this.session = session;
    }

    public ManageService getManageService() {
        return manageService;
    }

    public void setManageService(ManageService manageService) {
        this.manageService = manageService;
    }

    public ManageModel getManageModel() {
        return manageModel;
    }

    public void setManageModel(ManageModel manageModel) {
        this.manageModel = manageModel;
    }
}
