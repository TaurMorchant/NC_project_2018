package gui;

import controller.IDGenerator;
import exceptions.IllegalPropertyException;
import gui.mainform.MainForm;
import properties.ParserProperties;
import controller.SerializeDeserialize;
import model.Journal;

import javax.swing.*;
import java.io.IOException;

public class Main {
    public static void main(String[] args) {
        if (ParserProperties.getInstance() == null) {

            JOptionPane.showMessageDialog(null, "Config file not found or damaged!", "Error", JOptionPane.ERROR_MESSAGE);

        } else {
            SwingUtilities.invokeLater(() -> {
                try {
                    Journal journal = new SerializeDeserialize().readJournal(ParserProperties.getInstance().getProperties("PATH_TO_JOURNAL"));//todo константы стоит выносить в public static final переменные
                    if (journal == null) {
                        IDGenerator.getInstance();
                        JOptionPane.showMessageDialog(null, "Incorrect journal in file. You may create a new one", "Error", JOptionPane.ERROR_MESSAGE);
                    } else
                        IDGenerator.getInstance(journal.getMaxId());
                    new MainForm().setJournal(journal);
                } catch (IllegalPropertyException ex) {
                    JOptionPane.showMessageDialog(null, "Illegal value of property",
                            "Error", JOptionPane.ERROR_MESSAGE);
                } catch (IOException e) {
                    JOptionPane.showMessageDialog(null, "Could not load journal from file. You may create a new one", "Error", JOptionPane.ERROR_MESSAGE);
                    IDGenerator.getInstance();
                    new MainForm().setJournal(null);
                }

            });
        }
    }
}