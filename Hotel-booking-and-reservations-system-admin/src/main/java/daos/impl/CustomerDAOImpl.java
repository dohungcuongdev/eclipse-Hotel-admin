/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos.impl;

import daos.CustomerDAO;
import com.google.gson.Gson;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import daos.ActivityDAO;
import daos.UserDAO;
import database.MongoDBConnector;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.user.tracking.Activity;
import model.user.tracking.CustomerBehavior;
import model.user.tracking.DataCollection;
import model.user.tracking.FeedbackRoom;
import model.user.Customer;
import statics.provider.DateTimeCalculator;
import statics.provider.MathCalculator;

/**
 *
 * @author Do Hung Cuong
 */
public class CustomerDAOImpl implements CustomerDAO {

    private final Gson gson = new Gson();
    private final ActivityDAO activityDAO = new ActivityDAOImpl();
    private final UserDAO userDAO = new UserDAOImpl();
    private DBCollection collection;

    {
        try {
            collection = MongoDBConnector.createConnection("customers");
        } catch (UnknownHostException ex) {
            Logger.getLogger(RoomDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public Customer getCustomerByName(String username) {
        BasicDBObject whereQuery = new BasicDBObject();
        whereQuery.put("username", username);
        DBCursor cursor = collection.find(whereQuery);
        Customer cus = new Customer();
        while (cursor.hasNext()) {
            DBObject obj = cursor.next();
            cus = gson.fromJson(obj + "", Customer.class);
            cus.setRegistered_date(DateTimeCalculator.getDateTime(obj.get("created_at") + ""));
        }
        return cus;
    }

    @Override
    public List<Customer> getAllCustomers() {
        ArrayList<Customer> customers = new ArrayList<>();
        DBCursor cursor = collection.find();
        while (cursor.hasNext()) {
            DBObject obj = cursor.next();
            Customer cus = gson.fromJson(obj + "", Customer.class);
            cus.setRegistered_date(DateTimeCalculator.getDateTime(obj.get("created_at") + ""));
            cus.setDateVisit(getDateVisit(cus.getUsername()));
            customers.add(cus);
        }
        return customers;
    }

    @Override
    public boolean checkexsitCustomer(String username) {
        return getAllCustomers().stream().anyMatch((customer) -> (customer.getUsername().equals(username)));
    }

    @Override
    public List<String> getDateVisit(String username) {
        List<String> dateVisits = new ArrayList<>();
        userDAO.getListFollowUsers().stream().filter((fu) -> (fu.getUsername() != null && fu.getUsername().equals(username))).map((fu) -> fu.getDate_access().toString().substring(0, 10) + fu.getDate_access().toString().substring(19, 28)).forEach((dateVisit) -> {
            if (dateVisits.isEmpty()) {
                dateVisits.add(dateVisit);
            } else if (!dateVisits.contains(dateVisit)) {
                dateVisits.add(dateVisit);
            }
        });
        return dateVisits;
    }

    @Override
    public List<DataCollection> getListRoomBooked(String username) {
        List<DataCollection> roombooked = new ArrayList<>();
        activityDAO.getAllActivityByUserName(username).stream().filter((act) -> (act.getName().equals("Book Room"))).forEach((act) -> {
            roombooked.add(new DataCollection(act.getTime() + "", act.getDetails().substring(12)));
        });
        return roombooked;
    }

    @Override
    public List<DataCollection> getListRoomCanceled(String username) {
        List<DataCollection> roomcanceled = new ArrayList<>();
        activityDAO.getAllActivityByUserName(username).stream().filter((act) -> (act.getName().equals("Cancel Room"))).forEach((act) -> {
            roomcanceled.add(new DataCollection(act.getTime() + "", act.getDetails().substring(20)));
        });
        return roomcanceled;
    }

    @Override
    public double getAvgStarRoomFeedback(String username) {
        int star = 0, count = 0;
        for (Activity act : activityDAO.getAllActivityByUserName(username)) {
            if (act.getName().equals("Feedback Room")) {
                star += act.getNote().charAt(21) - 48;
                ++count;
            }
        }
        return MathCalculator.round(star * 1.0 / count, 2);
    }

    public int getTotalStarRoomFeedback(String username) {
        int star = 0;
        star = activityDAO.getAllActivityByUserName(username).stream().filter((act) -> (act.getName().equals("Feedback Room"))).map((act) -> act.getNote().charAt(21) - 48).reduce(star, Integer::sum);
        return star;
    }

    @Override
    public double getAvgStarFeedback(String username) {
        int star = 0, count = 0;
        for (Activity act : activityDAO.getAllActivityByUserName(username)) {
            if (act.getName().equals("Feedback")) {
                star += act.getNote().charAt(12) - 48;
                ++count;
            }
        }
        return MathCalculator.round(star * 1.0 / count, 2);
    }

    public double getTotalStarFeedback(String username) {
        int star = 0;
        star = activityDAO.getAllActivityByUserName(username).stream().filter((act) -> (act.getName().equals("Feedback"))).map((act) -> act.getNote().charAt(12) - 48).reduce(star, Integer::sum);
        return star;
    }

    @Override
    public List<CustomerBehavior> getDataCollection() {
        List<CustomerBehavior> cdc = new ArrayList<>();
        List<Customer> customers = getAllCustomers();
        customers.stream().forEach((c) -> {
            String un = c.getUsername();
            cdc.add(new CustomerBehavior(c, getListRoomBooked(un), getListRoomCanceled(un), getDateVisit(un), getListFeedbackRoom(un), getAvgStarRoomFeedback(un), getAvgStarFeedback(un)));
        });
        return cdc;
    }

    @Override
    public CustomerBehavior getOneDataCollection(String un) {
        return new CustomerBehavior(getCustomerByName(un), getListRoomBooked(un), getListRoomCanceled(un), getDateVisit(un), getListFeedbackRoom(un), getAvgStarRoomFeedback(un), getAvgStarFeedback(un));
    }

    @Override
    public List<FeedbackRoom> getListFeedbackRoom(String username) {
        List<FeedbackRoom> fbr = new ArrayList();
        new ActivityDAOImpl().getAllActivityByUserName(username).stream().filter((act) -> (act.getName().equals("Feedback Room"))).forEach((act) -> {
            String date = act.getTime() + "";
            String room = act.getNote().substring(12, 15);
            int star = act.getNote().charAt(21) - 48;
            String feedback = act.getContent();
            fbr.add(new FeedbackRoom(date, room, star, feedback));
        });
        return fbr;
    }
}
