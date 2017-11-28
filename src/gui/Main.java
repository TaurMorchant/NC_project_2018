package gui;

import gui.mainform.MainForm;
import properties.Prop;
import controller.SerializeDeserialize;
import model.Journal;

import javax.swing.*;
import java.io.IOException;

public class Main {
    public static void main(String[] args)
    {

        try
        {
            Prop prop = new Prop(); //поля этого объекта содержат необхдимые значения



        } catch (IOException e)

        {
            System.out.println(e.toString()+" не верно указан файл конфигурации");;
        }

        // todo свернуть в трей
        // todo иниц файл, иниц генератор на журнал
        //Journal journal = null;
          //  journal = new SerializeDeserialize().readJournal();

        //mainform form = new mainform();
        //taskwindow window = new taskwindow(new mainform());
        //window.setVisible(true);
            SwingUtilities.invokeLater(() -> {
                try {
                    Journal journal = new SerializeDeserialize().readJournal();
                    if (journal == null)
                        JOptionPane.showMessageDialog(null, "Incorrect journal in file. You may create a new one",
                                "Error", JOptionPane.ERROR_MESSAGE);
                    new MainForm().setJournal(journal);
                }
                catch (IOException e) {
                    JOptionPane.showMessageDialog(null, "Could not load journal from file. You may create a new one",
                            "Error", JOptionPane.ERROR_MESSAGE);
                    new MainForm().setJournal(null);
                }
            });




        //TaskForm  e = new TaskForm();
        //e.setVisible(true);


    }
}