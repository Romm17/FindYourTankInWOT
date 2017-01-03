package com.wot.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by romm on 03.01.17.
 */
public abstract class Features {

    protected abstract String getTableName();

    protected abstract String getIdFieldName();

    protected abstract int getNFeatures();

    private Map<Integer, float[]> u;

    public Features() {
        u = new HashMap<>();
        try {
            Connection connection = DBConnection.dbConnect();
            Statement stmt = connection.createStatement();
            stmt.setFetchSize(500000);
            String sql = "SELECT * FROM " + getTableName();
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()) {
                float[] values = new float[getNFeatures()];
                Integer account_id = rs.getInt(getIdFieldName());
                for (int i = 1; i <= getNFeatures(); i++) {
                    values[i - 1] = rs.getFloat("F" + i);
                }
                u.put(account_id, values);
            }
            rs.close();
            stmt.close();
            DBConnection.dbDisconnect(connection);
        } catch ( Exception e ) {
            e.printStackTrace();
        }
    }

    protected float[] getFeaturesById(int i) {
        return u.get(i);
    }
}
