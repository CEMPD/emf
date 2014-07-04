package gov.epa.emissions.framework.client.transport;

import gov.epa.emissions.commons.security.User;
import gov.epa.emissions.framework.services.EmfException;
import gov.epa.emissions.framework.services.tempalloc.TemporalAllocation;
import gov.epa.emissions.framework.services.tempalloc.TemporalAllocationResolution;
import gov.epa.emissions.framework.services.tempalloc.TemporalAllocationService;

public class TemporalAllocationServiceTransport implements TemporalAllocationService {

    private CallFactory callFactory;

    private DataMappings mappings;

    private EmfCall call;
    
    public TemporalAllocationServiceTransport(String endpoint) {
        callFactory = new CallFactory(endpoint);
        mappings = new DataMappings();
    }

    private EmfCall call() throws EmfException {
        if (call == null)
            call = callFactory.createSessionEnabledCall("TemporalAllocationService");

        return call;
    }

    public synchronized TemporalAllocation[] getTemporalAllocations() throws EmfException {
        EmfCall call = call();

        call.setOperation("getTemporalAllocations");
        call.setReturnType(mappings.temporalAllocations());

        return (TemporalAllocation[]) call.requestResponse(new Object[] {});
    }
    
    public synchronized int addTemporalAllocation(TemporalAllocation element) throws EmfException {
        EmfCall call = call();
        
        call.setOperation("addTemporalAllocation");
        call.addParam("element", mappings.temporalAllocation());
        call.setIntegerReturnType();

        return (Integer) call.requestResponse(new Object[] { element });
    }

    public synchronized TemporalAllocation obtainLocked(User owner, int id) throws EmfException {
        EmfCall call = call();

        call.setOperation("obtainLocked");
        call.addParam("owner", mappings.user());
        call.addIntegerParam("id");
        call.setReturnType(mappings.temporalAllocation());

        return (TemporalAllocation) call.requestResponse(new Object[] { owner, new Integer(id) });
    }

    public synchronized void releaseLocked(User user, int id) throws EmfException {
        EmfCall call = call();

        call.setOperation("releaseLocked");
        call.addParam("user", mappings.user());
        call.addIntegerParam("id");
        call.setReturnType(mappings.temporalAllocation());

        call.request(new Object[] { user, new Integer(id) });
    }

    public synchronized TemporalAllocation updateTemporalAllocationWithLock(TemporalAllocation element) throws EmfException {
        EmfCall call = call();

        call.setOperation("updateTemporalAllocationWithLock");
        call.addParam("element", mappings.temporalAllocation());
        call.setReturnType(mappings.temporalAllocation());

        return (TemporalAllocation) call.requestResponse(new Object[] { element });
    }
    
    public synchronized TemporalAllocationResolution[] getResolutions() throws EmfException {
        EmfCall call = call();
        
        call.setOperation("getResolutions");
        call.setReturnType(mappings.temporalAllocationResolutions());

        return (TemporalAllocationResolution[]) call.requestResponse(new Object[] {});
    }

    public synchronized void runTemporalAllocation(User user, TemporalAllocation element) throws EmfException {
        EmfCall call = call();

        call.setOperation("runTemporalAllocation");
        call.addParam("user", mappings.user());
        call.addParam("element", mappings.temporalAllocation());
        call.setVoidReturnType();

        call.request(new Object[] { user, element });
    }

    public Long getTemporalAllocationRunningCount() {
        return null;
    }
}