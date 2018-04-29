package server.exportdata.exportjournal;

import server.controller.Controller;
import server.exceptions.ControllerActionException;
import server.exportdata.ExportException;
import server.exportdata.ExportList;
import server.exportdata.ExportStrategy;

public class OnlyJournalExportStrategy implements ExportStrategy {

    private Controller controller;

    @Override
    public void collectId(ExportList exportList, Integer id) throws ExportException {
        try {
            controller = Controller.getInstance();
            if (controller.containsId(id))
                exportList.addJournalId(id);
            else throw new ExportException();
        } catch (ControllerActionException e) {
            throw new ExportException(e.getMessage());
        }
    }
}
