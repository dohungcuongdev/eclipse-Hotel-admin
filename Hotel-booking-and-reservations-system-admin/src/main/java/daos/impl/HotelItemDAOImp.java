/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos.impl;

import daos.HotelItemDAO;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import statics.provider.ImageEditor;

/**
 *
 * @author Do Hung Cuong
 */
public class HotelItemDAOImp implements HotelItemDAO {

    protected DBCollection collection;

    @Override
    public void editImage(String name, String img, String img2) {
        ImageEditor.editImagebyName(collection, name, "img", img);
        ImageEditor.editImagebyName(collection, name, "img2", img2);
    }
    
    @Override
    public void deleteItem(String name) {
        collection.remove(new BasicDBObject().append("name", name));
    }

}
