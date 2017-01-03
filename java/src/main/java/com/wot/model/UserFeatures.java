package com.wot.model;

/**
 * Created by romm on 03.01.17.
 */
public class UserFeatures extends Features {

    protected String getTableName() {
        return "user_features";
    }

    protected String getIdFieldName() {
        return "account_id";
    }

    protected int getNFeatures() {
        return 17;
    }

}
