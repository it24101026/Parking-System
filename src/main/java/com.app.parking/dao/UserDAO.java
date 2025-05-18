package com.app.parking.dao;

import com.app.parking.model.User;
import com.app.parking.model.Admin;
import java.io.*;
import java.nio.file.*;
import java.time.LocalDateTime;
import java.util.*;

public class UserDAO {
    private static final String FILE_PATH = "C:\\Users\\User\\Documents\\GitHub\\Parking-System\\src\\main\\java\\com.app.parking\\dao\\users.txt";
    private static final String DELIMITER = ",";

    static {
        try {
            Files.createDirectories(Paths.get("C:\\Users\\User\\Documents\\GitHub\\Parking-System\\src\\main\\java\\com.app.parking\\dao"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Create a new user
    public boolean createUser(User user) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(user.toString());
            writer.newLine();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all users
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                User user = User.fromString(line);
                if (user != null) {
                    users.add(user);
                }
            }
        } catch (IOException e) {
            // File may not exist yet
        }
        return users;
    }

    // Get user by ID
    public User getUserById(String id) {
        return getAllUsers().stream()
                .filter(user -> user.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    // Get user by username
    public User getUserByUsername(String username) {
        return getAllUsers().stream()
                .filter(user -> user.getUsername().equals(username))
                .findFirst()
                .orElse(null);
    }

    // Update user
    public boolean updateUser(User updatedUser) {
        List<User> users = getAllUsers();
        boolean found = false;

        for (int i = 0; i < users.size(); i++) {
            if (users.get(i).getId().equals(updatedUser.getId())) {
                users.set(i, updatedUser);
                found = true;
                break;
            }
        }

        if (found) {
            return saveAllUsers(users);
        }
        return false;
    }

    // Delete user
    public boolean deleteUser(String id) {
        List<User> users = getAllUsers();
        boolean removed = users.removeIf(user -> user.getId().equals(id));

        if (removed) {
            return saveAllUsers(users);
        }
        return false;
    }

    // Save all users to file (used for update and delete)
    private boolean saveAllUsers(List<User> users) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (User user : users) {
                writer.write(user.toString());
                writer.newLine();
            }
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Authenticate user
    public User authenticate(String username, String password) {
        return getAllUsers().stream()
                .filter(user -> user.getUsername().equals(username) && user.getPassword().equals(password))
                .findFirst()
                .orElse(null);
    }

    public static class Feedback {
        private String feedbackId;
        private String userId;
        private String subject;
        private String message;
        private LocalDateTime submissionDate;
        private boolean isResolved;

        public Feedback(String userId, String subject, String message) {
            this.feedbackId = UUID.randomUUID().toString();
            this.userId = userId;
            this.subject = subject;
            this.message = message;
            this.submissionDate = LocalDateTime.now();
            this.isResolved = false;
        }

        // For loading existing feedback
        public Feedback(String feedbackId, String userId, String subject,
                        String message, LocalDateTime submissionDate, boolean isResolved) {
            this.feedbackId = feedbackId;
            this.userId = userId;
            this.subject = subject;
            this.message = message;
            this.submissionDate = submissionDate;
            this.isResolved = isResolved;
        }

        // Getters and Setters
        public String getFeedbackId() { return feedbackId; }
        public String getUserId() { return userId; }
        public String getSubject() { return subject; }
        public String getMessage() { return message; }
        public LocalDateTime getSubmissionDate() { return submissionDate; }
        public boolean isResolved() { return isResolved; }

        public void setResolved(boolean resolved) { isResolved = resolved; }

        @Override
        public String toString() {
            return String.join("|",
                    this.feedbackId,
                    this.userId,
                    this.subject,
                    this.message,
                    this.submissionDate.toString(),
                    String.valueOf(this.isResolved)
            );
        }

        public static Feedback fromString(String str) {
            String[] parts = str.split("\\|");
            if (parts.length != 6) return null;

            return new Feedback(
                    parts[0], // feedbackId
                    parts[1], // userId
                    parts[2], // subject
                    parts[3], // message
                    LocalDateTime.parse(parts[4]), // submissionDate
                    Boolean.parseBoolean(parts[5]) // isResolved
            );
        }
    }
}