package com.wot.model;

/**
 * Created by romm on 03.01.17.
 */
public class DiagonalFeatures extends Features {

    protected String getTableName() {
        return "d_vector";
    }

    protected String getIdFieldName() {
        return "d_id";
    }

    protected int getNFeatures() {
        return 17;
    }

    public float[] getFeatures() {
        return super.getFeaturesById(1);
    }
}
