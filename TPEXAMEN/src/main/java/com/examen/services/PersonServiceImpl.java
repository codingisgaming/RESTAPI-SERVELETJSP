package com.examen.services;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import com.examen.models.Person;

public class PersonServiceImpl implements PersonService {

    private EntityManagerFactory emf;
    private EntityManager em;

    public PersonServiceImpl() {
        emf = Persistence.createEntityManagerFactory("TPEXAMEN");
        em = emf.createEntityManager();
    }

    // INSERT
    @Override
    public boolean addPerson(Person p) {
        try {
            em.getTransaction().begin();
            em.persist(p);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        }
    }

    // SELECT BY ID
    @Override
    public Person getPersonById(int id) {
        return em.find(Person.class, id);
    }

    // SELECT ALL
    @Override
    public List<Person> getAllPersons() {
        return em.createQuery(
                "SELECT p FROM Person p",
                Person.class
        ).getResultList();
    }

    // UPDATE
    @Override
    public boolean updatePerson(Person p) {
        try {
            em.getTransaction().begin();
            em.merge(p);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        }
    }

    // DELETE
    @Override
    public boolean deletePerson(int id) {
        try {
            Person p = em.find(Person.class, id);
            if (p == null) return false;

            em.getTransaction().begin();
            em.remove(p);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        }
    }
}
