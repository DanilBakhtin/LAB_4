package Main;

public class Main {

    public static void main(String[] args) {

        DatabaseHandler dbHandler = new DatabaseHandler();

        System.out.println("Задание 1:");
        dbHandler.printDayOfWeek(2);

        System.out.println("\nЗадание 2:");
        dbHandler.printNumOfClassRooms(3);

        System.out.println("\nЗадание 3:");
        dbHandler.replaceSchedule("Вторник");

    }
}
