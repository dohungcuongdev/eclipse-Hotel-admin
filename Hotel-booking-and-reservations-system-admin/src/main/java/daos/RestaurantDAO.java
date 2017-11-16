/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import java.util.List;
import model.hotel.HotelService;

/**
 *
 * @author Do Hung Cuong
 */
public interface RestaurantDAO {

    public HotelService getHotelServiceByName(String name);

    public List<HotelService> getAllHotelServices();
    
    public List<HotelService> getRelatedHotelServices(String type);
    
    public void updateService(HotelService service);
}
