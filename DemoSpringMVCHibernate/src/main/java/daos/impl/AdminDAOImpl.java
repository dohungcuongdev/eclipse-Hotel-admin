/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos.impl;

import daos.AdminDAO;
import com.google.gson.Gson;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.util.JSON;
import database.MongoDBConnector;
import java.net.UnknownHostException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.user.Administrator;
import statics.provider.ImageEditor;

/**
 *
 * @author Do Hung Cuong
 */
public class AdminDAOImpl implements AdminDAO {

    private final Gson gson = new Gson();
    private DBCollection collection;

    {
        try {
            collection = MongoDBConnector.createConnection("admin");
        } catch (UnknownHostException ex) {
            Logger.getLogger(AdminDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public Administrator getAdminByUserName(String username) {
        BasicDBObject whereQuery = new BasicDBObject();
        whereQuery.put("username", username);
        DBCursor cursor = collection.find(whereQuery);
        while (cursor.hasNext()) {
            return gson.fromJson(cursor.next().toString(), Administrator.class);
        }
        return null;
    }

    @Override
    public void updateAdmin(Administrator ad) {
        DBObject document = (DBObject) JSON.parse(gson.toJson(ad));
        DBObject searchObject = new BasicDBObject();
        searchObject.put("username", ad.getUsername());
        collection.update(searchObject, document);
    }

    @Override
    public void updatePassword(String currentpassword, String correctpassword, String newpassword, String confirm) {
        if (currentpassword.equals(correctpassword) && newpassword.equals(confirm)) {
            BasicDBObject document = new BasicDBObject();
            document.append("$set", new BasicDBObject().append("password", newpassword));
            BasicDBObject searchQuery = new BasicDBObject().append("username", "cuongvip1295@yahoo.com.vn");
            collection.update(searchQuery, document);
        }
    }

    @Override
    public void editProfileImg(String username, String img) {
        ImageEditor.editImagebyUserName(collection, username, img);
    }
}
