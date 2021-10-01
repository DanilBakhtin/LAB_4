package Main;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * Класс, организующий подключение к БД
 */
public class DatabaseHandler extends Config{

    Connection dbConnection;

    public Connection getDbConnection()
            throws ClassCastException, SQLException, ClassNotFoundException {

        Class.forName("com.mysql.cj.jdbc.Driver");

        String connectionString = "jdbc:mysql://" + dbHost + ":" + dbPort + "/" + dbName;

        dbConnection = DriverManager.getConnection(connectionString, dbUser, dbPass);

        return dbConnection;
    }

    /**
     * Функция выводит название дней недели, в которых проводится заданное кол-во занятий
     * @param count - заданное количество занятий
     */
    public void printDayOfWeek(int count){

        try {
            //SQL запрос, считывающий таблицу занятий
            String sql = "SELECT * FROM " + Const.SCHEDULE_TABLE;
            ResultSet res = getDbConnection().prepareStatement(sql).executeQuery();
            HashMap<String,Integer> mass = new HashMap<>();
            mass.put("Понедельник",0);
            mass.put("Вторник",0);
            mass.put("Среда",0);
            mass.put("Четверг",0);
            mass.put("Пятница",0);
            mass.put("Суббота",0);

            while (res.next()) {
                String str = res.getString(Const.SCHEDULE_DAY);
                mass.put(str, mass.get(str) + 1);
            }

            for (String s: mass.keySet()){
                if (mass.get(s) == count)
                    System.out.println(s);
            }


        }catch (SQLException e){
            e.printStackTrace();
        }catch (ClassNotFoundException e){
            e.printStackTrace();
        }

    }

    //вывести дни недели, в которые занято заданное кол-во аудиторий
    public void printNumOfClassRooms(int count){

        try {
            String sql = "SELECT " + Const.SCHEDULE_DAY + ", COUNT(" + Const.SCHEDULE_CLASSROOM
                    + ") as count FROM " + Const.SCHEDULE_TABLE + " GROUP BY " + Const.SCHEDULE_DAY;
            ResultSet res = getDbConnection().prepareStatement(sql).executeQuery();

            while (res.next()) {
                if (res.getInt("count") == count) {
                    System.out.println(res.getString(Const.SCHEDULE_DAY));
                }
            }

        }catch (SQLException e){
            e.printStackTrace();
        }catch (ClassNotFoundException e){
            e.printStackTrace();
        }


    }

    public void replaceSchedule(String day){

        //SQL запрос, выбирающий из таблицы расписание строку с указанным днем и минимальным ID
        String sql = "SELECT * FROM  "+ Const.SCHEDULE_TABLE + " WHERE "+ Const.SCHEDULE_ID +
                " IN (SELECT MIN(" + Const.SCHEDULE_ID + ") FROM "+ Const.SCHEDULE_TABLE + " WHERE " + Const.SCHEDULE_DAY +" = '" + day + "')";

        try {

            ResultSet res = getDbConnection().prepareStatement(sql).executeQuery();

            ArrayList<String> data = new ArrayList<>();
            int id = 0;
            //Записываем в массив всю строку
            if (res.next()) {
                id = Integer.parseInt(res.getString(Const.TEACHERS_ID));
                data.add(String.valueOf(res.getInt(Const.SCHEDULE_TEACHER)));
                data.add(String.valueOf(res.getInt(Const.SCHEDULE_SUBJECT)));
                data.add(res.getString(Const.SCHEDULE_DAY));
                data.add(res.getString(Const.SCHEDULE_CLASSROOM));
                data.add(String.valueOf(res.getInt(Const.SCHEDULE_QUANTITY)));
            }

            //SQL запрос, удаляющий из таблицы расписание строку c id
            String sqlDelete = "DELETE FROM schedule WHERE ID = " + id;
            //Удаление строки
            getDbConnection().prepareStatement(sqlDelete).executeUpdate();

            String sqlInsert = "INSERT INTO "+ Const.SCHEDULE_TABLE+" " +
                    "("+Const.SCHEDULE_TEACHER+", " +
                     Const.SCHEDULE_SUBJECT +", " +
                    Const.SCHEDULE_DAY+", " +
                    Const.SCHEDULE_CLASSROOM+", " +
                    Const.SCHEDULE_QUANTITY+") " +
                    "value ("
                    + Integer.parseInt(data.get(0)) + ","
                    + Integer.parseInt(data.get(1)) + ",'"
                    + data.get(2) + "','"
                    + data.get(3) + "',"
                    + Integer.parseInt(data.get(4)) + ")";

            //Вставка новой строк
            getDbConnection().prepareStatement(sqlInsert).executeUpdate();

        System.out.printf("Перемещена запись: %d %s %s %s %s %s",id,data.get(0),data.get(1),data.get(2),data.get(3),data.get(4));

        }catch (SQLException e){
        e.printStackTrace();
        }catch (ClassNotFoundException e){
        e.printStackTrace();
    }
    }

}
