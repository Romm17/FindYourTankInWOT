package com.wot.model;

/**
 * Created by romm on 03.01.17.
 */
public class Predictor {

    private static UserFeatures u;
    private static DiagonalFeatures d;
    private static TankFeatures v;

    static {
        u = new UserFeatures();
        d = new DiagonalFeatures();
        v = new TankFeatures();
    }

    public static int getUserXPOnTank(int account_id, int tank_id) {
        float[] u_i = u.getFeaturesById(account_id);
        float[] d_vector = d.getFeatures();
        float[] v_i = v.getFeaturesById(tank_id);
        float result = 0;
        for (int j = 0; j < u_i.length; j++) {
            result += u_i[j] * d_vector[j] * v_i[j];
        }
        return Math.round(result);
    }

    public static void main(String[] args) {
        System.out.println(getUserXPOnTank(1592, 609));
    }
}
