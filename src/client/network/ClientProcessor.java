package client.network;

import auxiliaryclasses.MessageBox;
import client.gui.authforms.AuthForm;
import client.properties.ParserProperties;
import auxiliaryclasses.ConstantsClass;
import server.exceptions.IllegalPropertyException;

import javax.swing.*;
import java.io.IOException;

public class ClientProcessor {

    public static void main(String[] args) {
        try {
            ParserProperties.getInstance().getProperties(ConstantsClass.MAIN_FORM_ICON);
            ParserProperties.getInstance().getProperties(ConstantsClass.NOTIF_SOUND);
        } catch (IllegalPropertyException | IOException e) {
            MessageBox.getInstance().showMessage(ConstantsClass.ERROR_PROPERTY);
            return;
        }
        System.out.println("Client logs: ");
        System.out.println();
        SwingUtilities.invokeLater(() -> {
            new AuthForm().setVisible(true);
        });
    }
}