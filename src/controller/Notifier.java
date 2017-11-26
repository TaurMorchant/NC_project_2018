package controller;

import model.Task;
import java.util.*;

public class Notifier {

    private Map<Integer, Timer> timers;

    protected Notifier() {
        timers = new HashMap<Integer, Timer>();
    }

    //выставление таймера для таски
    protected void addNotification(Task task) {
        NotificationTimer notificationTimer = new NotificationTimer(task);
        Timer timer = new Timer(true);
        System.out.println(task.getNotificationDate().getTime() - System.currentTimeMillis());
        timer.schedule(notificationTimer, task.getNotificationDate().getTime() - System.currentTimeMillis());
        timers.put(task.getId(),timer);
    }

    //отменяет таймер для таски
    protected void cancelNotification(int id){
        if(timers.containsKey(id)) {
            Timer timer = timers.get(id);
            timer.cancel();
        }
        else
            System.out.println("Error! Cancel is impossible!!!");
    }

    //приходит уже измененный таск с перенесенным временем
    protected void editNotification(int id, Task task) {
        if(timers.containsKey(id)) {
            Timer timer_old = timers.get(id);
            timer_old.cancel();
            NotificationTimer notificationTimer = new NotificationTimer(task);
            Timer timer = new Timer(true);
            System.out.println(task.getNotificationDate().getTime() - System.currentTimeMillis());
            timer.schedule(notificationTimer, task.getNotificationDate().getTime() - System.currentTimeMillis());
            timers.put(task.getId(),timer);
        }
        else
            System.out.println("Error! Edit is impossible!!!");
    }
}
