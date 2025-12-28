package com.examen.services;

import java.util.List;
import com.examen.models.Person;

public interface PersonService {

    boolean addPerson(Person p);

    Person getPersonById(int id);

    List<Person> getAllPersons();

    boolean updatePerson(Person p);

    boolean deletePerson(int id);
}
