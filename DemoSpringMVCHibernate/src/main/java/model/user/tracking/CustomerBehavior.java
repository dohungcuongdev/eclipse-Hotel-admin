/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.user.tracking;

import java.util.List;
import model.user.Customer;

/**
 *
 * @author HUNGCUONG
 */
public class CustomerBehavior {

    private Customer cus;
    private List roomBooked;
    private List roomCanceled;
    private List dateVisited;
    private List feedbackroom;
    private double avgfeedbackRoom;
    private double avgFeedbackSV;

    public Customer getCus() {
        return cus;
    }

    public void setCus(Customer cus) {
        this.cus = cus;
    }

    public List getRoomBooked() {
        return roomBooked;
    }

    public void setRoomBooked(List roomBooked) {
        this.roomBooked = roomBooked;
    }

    public List getRoomCanceled() {
        return roomCanceled;
    }

    public void setRoomCanceled(List roomCanceled) {
        this.roomCanceled = roomCanceled;
    }

    public List getDateVisited() {
        return dateVisited;
    }

    public void setDateVisited(List dateVisited) {
        this.dateVisited = dateVisited;
    }

    public List getFeedbackroom() {
        return feedbackroom;
    }

    public void setFeedbackroom(List feedbackroom) {
        this.feedbackroom = feedbackroom;
    }

    public double getAvgfeedbackRoom() {
        return avgfeedbackRoom;
    }

    public void setAvgfeedbackRoom(double avgfeedbackRoom) {
        this.avgfeedbackRoom = avgfeedbackRoom;
    }

    public double getAvgFeedbackSV() {
        return avgFeedbackSV;
    }

    public void setAvgFeedbackSV(double avgFeedbackSV) {
        this.avgFeedbackSV = avgFeedbackSV;
    }

    public CustomerBehavior(Customer cus, List roomBooked, List roomCanceled, List dateVisited) {
        this.cus = cus;
        this.roomBooked = roomBooked;
        this.roomCanceled = roomCanceled;
        this.dateVisited = dateVisited;
    }

    public CustomerBehavior(Customer cus, List roomBooked, List roomCanceled, List dateVisited, double avgfeedbackRoom, double avgFeedbackSV) {
        this.cus = cus;
        this.roomBooked = roomBooked;
        this.roomCanceled = roomCanceled;
        this.dateVisited = dateVisited;
        this.avgfeedbackRoom = avgfeedbackRoom;
        this.avgFeedbackSV = avgFeedbackSV;
    }

    public CustomerBehavior(Customer cus, List roomBooked, List roomCanceled, List dateVisited, List feedbackroom, double avgfeedbackRoom, double avgFeedbackSV) {
        this.cus = cus;
        this.roomBooked = roomBooked;
        this.roomCanceled = roomCanceled;
        this.dateVisited = dateVisited;
        this.feedbackroom = feedbackroom;
        this.avgfeedbackRoom = avgfeedbackRoom;
        this.avgFeedbackSV = avgFeedbackSV;
    }
    
    public boolean isReturned() {
        return true;
    }
    
    public boolean isNew() {
        return false;
    }

    @Override
    public String toString() {
        return "CustomerDataCollection{" + "cus=" + cus + ", roomBooked=" + roomBooked + ", roomCanceled=" + roomCanceled + ", dateVisited=" + dateVisited + ", feedbackroom=" + feedbackroom + ", avgfeedbackRoom=" + avgfeedbackRoom + ", avgFeedbackSV=" + avgFeedbackSV + '}';
    }
}
