package com.examen.web;

import com.examen.models.Person;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.util.stream.Collectors;

@WebServlet("/persons")
public class PersonController extends HttpServlet {

    private final String API_BASE_URL = "http://localhost:8081/TPEXAMEN/api/persons";
    private SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    private Gson gson = new Gson();

    // Méthode utilitaire pour les requêtes GET
    private String sendGetRequest(String url) throws IOException {
        URL apiUrl = new URL(url);
        HttpURLConnection conn = (HttpURLConnection) apiUrl.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Accept", "application/json");

        if (conn.getResponseCode() != HttpURLConnection.HTTP_OK) {
            throw new IOException("Failed : HTTP error code : " + conn.getResponseCode());
        }

        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        StringBuilder response = new StringBuilder();
        String output;
        while ((output = br.readLine()) != null) {
            response.append(output);
        }
        conn.disconnect();
        return response.toString();
    }

    // Méthode utilitaire pour les requêtes POST
    private String sendPostRequest(String url, String jsonInput) throws IOException {
        URL apiUrl = new URL(url);
        HttpURLConnection conn = (HttpURLConnection) apiUrl.openConnection();
        conn.setDoOutput(true);
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Accept", "application/json");

        OutputStream os = conn.getOutputStream();
        os.write(jsonInput.getBytes());
        os.flush();

        if (conn.getResponseCode() != HttpURLConnection.HTTP_CREATED && 
            conn.getResponseCode() != HttpURLConnection.HTTP_OK) {
            throw new IOException("Failed : HTTP error code : " + conn.getResponseCode());
        }

        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        StringBuilder response = new StringBuilder();
        String output;
        while ((output = br.readLine()) != null) {
            response.append(output);
        }
        conn.disconnect();
        return response.toString();
    }

    // Méthode utilitaire pour les requêtes PUT
    private String sendPutRequest(String url, String jsonInput) throws IOException {
        URL apiUrl = new URL(url);
        HttpURLConnection conn = (HttpURLConnection) apiUrl.openConnection();
        conn.setDoOutput(true);
        conn.setRequestMethod("PUT");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Accept", "application/json");

        OutputStream os = conn.getOutputStream();
        os.write(jsonInput.getBytes());
        os.flush();

        if (conn.getResponseCode() != HttpURLConnection.HTTP_OK) {
            throw new IOException("Failed : HTTP error code : " + conn.getResponseCode());
        }

        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        StringBuilder response = new StringBuilder();
        String output;
        while ((output = br.readLine()) != null) {
            response.append(output);
        }
        conn.disconnect();
        return response.toString();
    }

    // Méthode utilitaire pour les requêtes DELETE
    private boolean sendDeleteRequest(String url) throws IOException {
        URL apiUrl = new URL(url);
        HttpURLConnection conn = (HttpURLConnection) apiUrl.openConnection();
        conn.setRequestMethod("DELETE");
        conn.setRequestProperty("Accept", "application/json");

        int responseCode = conn.getResponseCode();
        System.out.println("DELETE request to: " + url + " - Response Code: " + responseCode);
        
        // Accepter les codes 200 (OK) et 204 (No Content) comme succès
        return responseCode == HttpURLConnection.HTTP_OK || responseCode == HttpURLConnection.HTTP_NO_CONTENT;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String idParam = request.getParameter("id");
        String search = request.getParameter("search");

        try {
            if ("searchForm".equals(action)) {
                // Afficher formulaire de recherche
                request.getRequestDispatcher("/WEB-INF/views/person-search.jsp")
                       .forward(request, response);
            }
            else if ("search".equals(action) && search != null && !search.trim().isEmpty()) {
                // Effectuer la recherche
                try {
                    String apiResponse = sendGetRequest(API_BASE_URL);
                    List<Person> allPersons = gson.fromJson(apiResponse, new TypeToken<List<Person>>(){}.getType());
                    
                    // Filtrer par nom contenant la recherche (insensible à la casse)
                    List<Person> searchResults = allPersons.stream()
                        .filter(person -> person.getName().toLowerCase().contains(search.toLowerCase()))
                        .collect(Collectors.toList());
                    
                    request.setAttribute("persons", searchResults);
                    request.setAttribute("searchTerm", search);
                    request.setAttribute("resultCount", searchResults.size());
                    request.setAttribute("currentDate", dateFormat.format(new Date()));
                    
                } catch (IOException e) {
                    request.setAttribute("error", "Erreur lors de la recherche");
                    request.setAttribute("persons", new ArrayList<Person>());
                    request.setAttribute("resultCount", 0);
                }
                request.getRequestDispatcher("/WEB-INF/views/person-search-results.jsp")
                       .forward(request, response);
            }
            else if ("addForm".equals(action)) {
                // Afficher formulaire d'ajout
                request.getRequestDispatcher("/WEB-INF/views/person-form.jsp")
                       .forward(request, response);
            } 
            else if ("editForm".equals(action) && idParam != null) {
                // Afficher formulaire de modification
                int id = Integer.parseInt(idParam);
                try {
                    String apiResponse = sendGetRequest(API_BASE_URL + "/" + id);
                    Person p = gson.fromJson(apiResponse, Person.class);
                    request.setAttribute("person", p);
                } catch (IOException e) {
                    request.setAttribute("error", "Personne non trouvée");
                }
                request.getRequestDispatcher("/WEB-INF/views/person-edit.jsp")
                       .forward(request, response);
            } 
            else if ("deleteForm".equals(action) && idParam != null) {
                // Afficher confirmation de suppression
                int id = Integer.parseInt(idParam);
                try {
                    String apiResponse = sendGetRequest(API_BASE_URL + "/" + id);
                    Person p = gson.fromJson(apiResponse, Person.class);
                    request.setAttribute("person", p);
                    request.setAttribute("currentDate", dateFormat.format(new Date()));
                } catch (IOException e) {
                    request.setAttribute("error", "Personne non trouvée");
                }
                request.getRequestDispatcher("/WEB-INF/views/person-delete.jsp")
                       .forward(request, response);
            } 
            else if ("detail".equals(action) && idParam != null) {
                // Afficher détails d'une personne
                int id = Integer.parseInt(idParam);
                try {
                    String apiResponse = sendGetRequest(API_BASE_URL + "/" + id);
                    Person p = gson.fromJson(apiResponse, Person.class);
                    request.setAttribute("person", p);
                    request.setAttribute("currentDate", dateFormat.format(new Date()));
                } catch (IOException e) {
                    request.setAttribute("error", "Personne non trouvée");
                }
                request.getRequestDispatcher("/WEB-INF/views/person-detail.jsp")
                       .forward(request, response);
            } 
            else {
                // Afficher liste par défaut
                try {
                    String apiResponse = sendGetRequest(API_BASE_URL);
                    List<Person> persons = gson.fromJson(apiResponse, new TypeToken<List<Person>>(){}.getType());
                    request.setAttribute("persons", persons);
                } catch (IOException e) {
                    request.setAttribute("error", "Erreur lors du chargement des données");
                    request.setAttribute("persons", new ArrayList<Person>());
                }
                request.getRequestDispatcher("/WEB-INF/views/persons.jsp")
                       .forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID invalide");
            try {
                String apiResponse = sendGetRequest(API_BASE_URL);
                List<Person> persons = gson.fromJson(apiResponse, new TypeToken<List<Person>>(){}.getType());
                request.setAttribute("persons", persons);
            } catch (IOException ex) {
                request.setAttribute("persons", new ArrayList<Person>());
            }
            request.getRequestDispatcher("/WEB-INF/views/persons.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        try {
            if ("update".equals(action) && idParam != null) {
                // Mettre à jour une personne
                int id = Integer.parseInt(idParam);
                String name = request.getParameter("name");
                String ageStr = request.getParameter("age");
                
                int age = Integer.parseInt(ageStr);
                Person p = new Person();
                p.setId(id);
                p.setName(name);
                p.setAge(age);
                
                String jsonInput = gson.toJson(p);
                
                try {
                    sendPutRequest(API_BASE_URL + "/" + id, jsonInput);
                    response.sendRedirect("persons?action=detail&id=" + id);
                } catch (IOException e) {
                    request.setAttribute("error", "Échec de la mise à jour");
                    request.setAttribute("person", p);
                    request.getRequestDispatcher("/WEB-INF/views/person-edit.jsp")
                           .forward(request, response);
                }
            } 
            else if ("delete".equals(action) && idParam != null) {
                // Supprimer une personne via l'API REST
                int id = Integer.parseInt(idParam);
                System.out.println("Attempting to delete person with ID: " + id);
                
                try {
                    // Appeler l'API REST pour supprimer la personne
                    boolean deleted = sendDeleteRequest(API_BASE_URL + "/" + id);
                    
                    if (deleted) {
                        System.out.println("Person deleted successfully, redirecting to list...");
                        // Rediriger vers la liste après suppression réussie
                        response.sendRedirect("persons");
                        return;
                    } else {
                        System.out.println("Failed to delete person via API");
                        // Si l'API retourne une erreur, afficher un message d'erreur
                        request.setAttribute("error", "Échec de la suppression : Personne non trouvée ou erreur serveur");
                        
                        // Recharger la liste des personnes
                        try {
                            String apiResponse = sendGetRequest(API_BASE_URL);
                            List<Person> persons = gson.fromJson(apiResponse, new TypeToken<List<Person>>(){}.getType());
                            request.setAttribute("persons", persons);
                        } catch (IOException ex) {
                            request.setAttribute("persons", new ArrayList<Person>());
                        }
                        
                        request.getRequestDispatcher("/WEB-INF/views/persons.jsp")
                               .forward(request, response);
                    }
                } catch (IOException e) {
                    System.out.println("IOException during delete: " + e.getMessage());
                    e.printStackTrace();
                    
                    // En cas d'erreur réseau ou autre
                    request.setAttribute("error", "Erreur lors de la suppression : " + e.getMessage());
                    
                    // Recharger la liste des personnes
                    try {
                        String apiResponse = sendGetRequest(API_BASE_URL);
                        List<Person> persons = gson.fromJson(apiResponse, new TypeToken<List<Person>>(){}.getType());
                        request.setAttribute("persons", persons);
                    } catch (IOException ex) {
                        request.setAttribute("persons", new ArrayList<Person>());
                    }
                    
                    request.getRequestDispatcher("/WEB-INF/views/persons.jsp")
                           .forward(request, response);
                }
            } 
            else {
                // Créer une nouvelle personne (POST par défaut)
                String name = request.getParameter("name");
                String ageStr = request.getParameter("age");
                
                int age = Integer.parseInt(ageStr);
                Person p = new Person();
                p.setName(name);
                p.setAge(age);
                
                String jsonInput = gson.toJson(p);
                
                try {
                    String apiResponse = sendPostRequest(API_BASE_URL, jsonInput);
                    Person createdPerson = gson.fromJson(apiResponse, Person.class);
                    response.sendRedirect("persons");
                } catch (IOException e) {
                    request.setAttribute("error", "Échec de la création");
                    request.getRequestDispatcher("/WEB-INF/views/person-form.jsp")
                           .forward(request, response);
                }
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Données invalides");
            
            if ("update".equals(action) && idParam != null) {
                try {
                    int id = Integer.parseInt(idParam);
                    String apiResponse = sendGetRequest(API_BASE_URL + "/" + id);
                    Person p = gson.fromJson(apiResponse, Person.class);
                    if (p != null) {
                        request.setAttribute("person", p);
                        request.getRequestDispatcher("/WEB-INF/views/person-edit.jsp")
                               .forward(request, response);
                    } else {
                        response.sendRedirect("persons");
                    }
                } catch (Exception ex) {
                    response.sendRedirect("persons");
                }
            } else {
                request.getRequestDispatcher("/WEB-INF/views/person-form.jsp")
                       .forward(request, response);
            }
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Cette méthode est appelée par les requêtes HTTP DELETE directes
        System.out.println("doDelete method called");
        
        String idParam = request.getParameter("id");
        if (idParam == null) {
            // Essayer de récupérer l'ID depuis l'URL
            String pathInfo = request.getPathInfo();
            if (pathInfo != null && pathInfo.length() > 1) {
                idParam = pathInfo.substring(1);
            }
        }
        
        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                System.out.println("Direct DELETE request for person with ID: " + id);
                
                boolean deleted = sendDeleteRequest(API_BASE_URL + "/" + id);
                
                if (deleted) {
                    System.out.println("Person deleted successfully via direct DELETE");
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.sendRedirect("persons");
                } else {
                    System.out.println("Failed to delete person via direct DELETE");
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.sendRedirect("persons");
                }
            } catch (NumberFormatException e) {
                System.out.println("Invalid ID format: " + idParam);
                response.sendRedirect("persons");
            }
        } else {
            System.out.println("No ID parameter provided for direct DELETE");
            response.sendRedirect("persons");
        }
    }
}