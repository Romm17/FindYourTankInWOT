package com.wot.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by romm on 03.01.17.
 */
public class TankFeatures extends Features {

    protected String getTableName() {
        return "tank_features";
    }

    protected String getIdFieldName() {
        return "tank_id";
    }

    protected int getNFeatures() {
        return 17;
    }

}
