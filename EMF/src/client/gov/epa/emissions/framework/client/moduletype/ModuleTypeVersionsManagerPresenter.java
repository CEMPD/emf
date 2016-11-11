package gov.epa.emissions.framework.client.moduletype;

import gov.epa.emissions.commons.security.User;
import gov.epa.emissions.framework.client.EmfSession;
import gov.epa.emissions.framework.services.EmfException;
import gov.epa.emissions.framework.services.data.DataCommonsService;
import gov.epa.emissions.framework.services.module.Module;
import gov.epa.emissions.framework.services.module.ModuleType;
import gov.epa.emissions.framework.services.module.ModuleTypeVersion;
import gov.epa.emissions.framework.ui.RefreshObserver;

import java.util.ArrayList;
import java.util.List;

public class ModuleTypeVersionsManagerPresenter {

    private ModuleTypeVersionsManagerView view;

    private EmfSession session;

    public ModuleTypeVersionsManagerPresenter(EmfSession session, ModuleTypeVersionsManagerView view) {
        this.session = session;
        this.view = view;
    }

    public void doDisplay() throws EmfException {
        view.observe(this);
        view.display();
    }

    public void doClose() {
        view.disposeView();
    }

    public void displayNewModuleTypeView(ModuleTypeVersionPropertiesView view) {
        ModuleTypeVersionPropertiesPresenter presenter = new ModuleTypeVersionPropertiesPresenter(session, view);
        presenter.doDisplay();
    }

    public Module[] getModules() throws EmfException {
        return session.moduleService().getModules();
    }

    public ModuleType obtainLockedModuleType(User owner, ModuleType moduleType) throws EmfException {
        return session.moduleService().obtainLockedModuleType(owner, moduleType);
    }

    public ModuleType releaseLockedModuleType(User owner, ModuleType moduleType) throws EmfException {
        return session.moduleService().releaseLockedModuleType(owner, moduleType);
    }
    
    public ModuleType getModuleType(int id) throws EmfException {
        return session.moduleService().getModuleType(id);
    }
    
    public void doRemove(ModuleTypeVersion[] moduleTypeVersions) throws EmfException {
//        try {
//            session.moduleService().deleteModuleTypeVersions(session.user(), moduleTypeVersions);
//        } catch (EmfException e) {
//            throw new EmfException(e.getMessage());
//        } finally {
//        }
    }
}
