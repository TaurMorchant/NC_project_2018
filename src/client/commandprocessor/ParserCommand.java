package client.commandprocessor;


import client.gui.authforms.AuthForm;
import client.gui.authforms.SignUpForm;
import server.gui.mainform.MainForm;
import server.gui.notificationwindow.NotificationForm;
import client.model.Journal;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;
import java.io.InputStream;

public class ParserCommand {

    public static Command parseToCommand (InputStream in) {
        Command command;
        try {
            System.out.println("Start reading command");
            JAXBContext context = JAXBContext.newInstance(server.commandproccessor.Command.class);
            System.out.println("1");
            Unmarshaller unmarshaller = context.createUnmarshaller();
            System.out.println("2");
            command = (Command) unmarshaller.unmarshal(in);
            System.out.println("Command reading success");
        } catch (JAXBException e) {
            e.printStackTrace();
            e.getMessage();
            System.out.println("Parse error!");
            return null;
        }
        return command;
    }

    public static void doCommandAction(Command command) {
        if (command != null) {
            MainForm mainForm;
            AuthForm authForm;
            SignUpForm signUpForm;
            switch (command.getName()) {
                case "Update" :
                    mainForm = MainForm.getInstance();
                    if (mainForm == null) mainForm = new MainForm();
                    //mainForm.setJournal((Journal) command.getObject()); // при update приходит журнал
                    mainForm.setVisible(true);
                    break;
                case "Notification" :
                    new NotificationForm().setTask((server.model.Task) command.getObject());
                    break;
                case "Unsuccessful auth":
                    authForm = AuthForm.getInstance();
                    if (authForm == null) authForm = new AuthForm();
                    authForm.setVisible(true);
                    authForm.showUnsuccessfulAuthMessage();
                    break;
                case "Unsuccessful sign up" :
                    signUpForm = SignUpForm.getInstance();
                    if (signUpForm == null) signUpForm = new SignUpForm();
                    signUpForm.setVisible(true);
                    signUpForm.showUnsuccessfulSignUpMessage();
                    break;
                case "Successful auth":
                    mainForm = MainForm.getInstance();
                    if (mainForm == null) mainForm = new MainForm();
                    new MainForm().setVisible(true);
                    break;
            }
        }
    }
}
