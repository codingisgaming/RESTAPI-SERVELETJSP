package com.examen.api;

import java.util.List;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.examen.models.Person;
import com.examen.services.PersonService;
import com.examen.services.PersonServiceImpl;

@Path("/persons")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class RestRouter {

    private PersonService personService = new PersonServiceImpl();

    // GET ALL
    @GET
    public Response getAllPersons() {
        List<Person> persons = personService.getAllPersons();
        return Response.ok(persons).build();
    }

    // GET BY ID
    @GET
    @Path("/{id}")
    public Response getPersonById(@PathParam("id") int id) {
        Person p = personService.getPersonById(id);
        if (p == null) {
            return Response.status(Response.Status.NOT_FOUND)
                           .entity("Person not found")
                           .build();
        }
        return Response.ok(p).build();
    }

    // CREATE
    @POST
    public Response addPerson(Person p) {
        boolean created = personService.addPerson(p);
        if (created) {
            return Response.status(Response.Status.CREATED)
                           .entity(p)
                           .build();
        }
        return Response.status(Response.Status.BAD_REQUEST)
                       .entity("Error while creating person")
                       .build();
    }

    // UPDATE
    @PUT
    @Path("/{id}")
    public Response updatePerson(@PathParam("id") int id, Person p) {
        p.setId(id);
        boolean updated = personService.updatePerson(p);

        if (updated) {
            return Response.ok(p).build();
        }
        return Response.status(Response.Status.NOT_FOUND)
                       .entity("Person not found")
                       .build();
    }

    // DELETE
    @DELETE
    @Path("/{id}")
    public Response deletePerson(@PathParam("id") int id) {
        boolean deleted = personService.deletePerson(id);
        if (deleted) {
            return Response.ok("Person deleted").build();
        }
        return Response.status(Response.Status.NOT_FOUND)
                       .entity("Person not found")
                       .build();
    }
}
