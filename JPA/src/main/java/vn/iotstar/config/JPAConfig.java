package vn.iotstar.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAConfig {
    private static EntityManagerFactory factory;

    public static synchronized EntityManager getEntityManager() {
        if (factory == null || !factory.isOpen()) {
            factory = Persistence.createEntityManagerFactory("BT02_JPA_PU");
        }
        return factory.createEntityManager();
    }

    public static synchronized void closeFactory() {
        if (factory != null && factory.isOpen()) {
            factory.close();
        }
    }
}