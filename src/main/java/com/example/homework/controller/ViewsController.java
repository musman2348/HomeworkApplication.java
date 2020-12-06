/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.example.homework.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import com.example.homework.model.Statictics;
import com.example.homework.model.User;
import com.example.homework.objects.*;
import com.example.homework.repository.StatisticsRepo;
import com.example.homework.repository.UserRepo;
import com.example.homework.security.UserDetail;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.PostConstruct;


@Controller
public class ViewsController {

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private UserRepo userRepo;

    @Autowired
    private StatisticsRepo statsRepo;

    public static Map<String, String> countries;

    // method to fetch coutries names and keys when application is loaded.
    @PostConstruct
    public void getCountriesKeysAndNamesAtApplicationStartUp() {
        countries = new HashMap<>();
        Object object = restTemplate.getForObject("https://api.covid19tracking.narrativa.com/api/countries", Object.class);
        new HashMap<>();
        if (object != null) {
            ObjectMapper objectMapper = new ObjectMapper();
            Country data = objectMapper.convertValue(object, Country.class);
            for (Country_ country : data.getCountries()) {
                countries.put(country.getId(), country.getName());
            }
        }
    }

    // main entry point when user gets authenticated 
    @RequestMapping(value = {"/"}, method = RequestMethod.GET)
    public ModelAndView indexView(

    ) {
        ModelAndView model = new ModelAndView("index");
        model.addObject("countries", countries);
        return model;
    }

    // this method fetched data about a country by date and displays in jsp view
    @GetMapping(value = "/stats")
    public ModelAndView countryStatisticsFromOpenAPIs(
            @RequestParam("date") String date,
            @RequestParam("country") String country

    ) {
        System.out.println("Rreceived hit finally");
        System.out.println("date : " + date);
        System.out.println("Country : " + country);
        ModelAndView model = new ModelAndView("index");
        model.addObject("countries", countries);
        if (!date.isEmpty() && !country.isEmpty()) {
            Object object = restTemplate.getForObject("https://api.covid19tracking.narrativa.com/api/" + date + "/country/" + country, Object.class);
            if (object != null) {
                ObjectMapper mapper = new ObjectMapper();
                StatsMainWrapper mainStats = mapper.convertValue(object, StatsMainWrapper.class);
                for (Map.Entry<String, CountryWrapper> map : mainStats.getDates().entrySet())
                    for (Map.Entry<String, CountryDetail> map1 : map.getValue().getCountries().entrySet()) {
                        model.addObject("stats", map1.getValue());
                    }
                model.addObject("countryName", countries.get(country));
                System.out.println("Data : " + mainStats.getTotal());
            }
        }

        return model;
    }

    // this method returns login page
    @GetMapping("/loginView")
    public ModelAndView login() {
        User user = new User();
        ModelAndView modelAndView = new ModelAndView("login", "user", user);
        return modelAndView;
    }

    // this method saves stats data into database
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public String saveStatsDB(
            @RequestParam("countryName") String countryName,
            @RequestParam("date") String date,
            @RequestParam("totalCases") Integer totalCases,
            @RequestParam("totalDeaths") Integer totalDeaths,
            @RequestParam("newCases") Integer newCases
    ) {

        System.out.println("Did not received object");
        System.out.println("country : " + countryName);
        System.out.println("date : " + date);
        System.out.println("totalCases : " + totalCases);
        System.out.println("totalDeaths : " + totalDeaths);
        System.out.println("newCases : " + newCases);
        UserDetail userDetail = (UserDetail) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String name = userDetail.getUsername();
        System.out.println("UserName : " + name);
        Optional<User> user = userRepo.findByName(name);
        if (user.isPresent()) {
            Optional<Statictics> oldStats = statsRepo.findByCountryNameAndUser_id(countryName, user.get().getId());
            if (oldStats.isPresent()) {
                oldStats.get().setDate(date);
                oldStats.get().setNewCases(newCases);
                oldStats.get().setTotalCases(totalCases);
                oldStats.get().setTotalDeaths(totalDeaths);
                statsRepo.save(oldStats.get());
            } else {
                Statictics stat = new Statictics();
                stat.setCountryName(countryName);
                stat.setDate(date);
                stat.setNewCases(newCases);
                stat.setTotalCases(totalCases);
                stat.setTotalDeaths(totalDeaths);
                user.get().getStatictics().add(stat);
                stat.setUser(user.get());
                statsRepo.save(stat);
                userRepo.save(user.get());
            }
        }
        return "redirect:/";
    }

    // this method returns jsp page of user management 
    @RequestMapping("/user/manage")
    public ModelAndView userManagementView() {
        ModelAndView model = new ModelAndView("userManage");
        model.addObject("users", userRepo.findAll());
        return model;
    }

    // this method is used to create new user if provided username doesn't exists
    @PostMapping("/create/user")
    public String createUser(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            @RequestParam("role") String role
    ) {
        System.out.println("username : " + username);
        System.out.println("password : " + password);
        System.out.println("role : " + role);
        Optional<User> user = userRepo.findByName(username);
        if (!user.isPresent()) {
            User newUser = new User();
            newUser.setName(username);
            newUser.setPassword(password);
            newUser.setRole(role);
            userRepo.save(newUser);
        }
//        statsService.createUser(username, password, role);
        return "redirect:/user/manage";
    }

    // this method deletes user from DB
    @PostMapping("/delete/user")
    public String deleteUser(
            @RequestParam("userId") int id
    ) {
        System.out.println("User Id : " + id);
        userRepo.deleteById(id);
//        statsService.deleteUser(id);
        return "redirect:/user/manage";
    }

    // this method returns view of stats management page
    @GetMapping("/manage/stats")
    public ModelAndView manageStatistics() {
        UserDetail userDetail = (UserDetail) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String name = userDetail.getUsername();
        Optional<User> user = userRepo.findByName(name);
        ModelAndView model = new ModelAndView("stats");
        if (user.isPresent()) {
            model.addObject("role", user.get().getRole());
            if (user.get().getRole().equals("ROLE_ADMIN")) {
                model.addObject("stats", statsRepo.findAll());
            } else {
                model.addObject("stats", statsRepo.findAllByUser_Id(user.get().getId()));
            }
        }
        return model;
    }

    // this end point is used to update stats data changed by admin
    @PostMapping("/update/stat")
    public String updateStatistics(
            @RequestParam("countryName") String countryName,
            @RequestParam("totalCases") int totalCases,
            @RequestParam("totalDeaths") int totalDeaths,
            @RequestParam("newCases") int newCases,
            @RequestParam("statId") int statId
    ) {
        Optional<Statictics> stats = statsRepo.findById(statId);
        if (stats.isPresent()) {
            stats.get().setCountryName(countryName);
            stats.get().setTotalCases(totalCases);
            stats.get().setTotalDeaths(totalDeaths);
            stats.get().setNewCases(newCases);
            statsRepo.save(stats.get());
        }
        return "redirect:/manage/stats";
    }

    // this end point deletes stats record form database
    @GetMapping("/delete/stat")
    public String deleteStatistics(
            @RequestParam("statId") int id
    ) {
        statsRepo.deleteById(id);
        return "redirect:/manage/stats";
    }

}
