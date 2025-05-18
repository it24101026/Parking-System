package com.app.parking.dao;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.stream.Collectors;

public class FeedbackDAO {
    private static final String FILE_PATH = "C:\\Users\\User\\Documents\\GitHub\\Parking-System\\src\\main\\java\\com.app.parking\\dao\\feedback.txt";

    static {
        try {
            Files.createDirectories(Paths.get("C:\\Users\\User\\Documents\\GitHub\\Parking-System\\src\\main\\java\\com.app.parking\\dao"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Create new feedback or ticket
    public boolean createFeedback(UserDAO.Feedback feedback) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(feedback.toString());
            writer.newLine();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all feedback items
    public List<UserDAO.Feedback> getAllFeedback() {
        List<UserDAO.Feedback> feedbackList = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                UserDAO.Feedback feedback = parseFeedbackLine(line);
                if (feedback != null) {
                    feedbackList.add(feedback);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            // File may not exist yet
        }
        return feedbackList;
    }

    // Get feedback by ID
    public UserDAO.Feedback getFeedbackById(String id) {
        return getAllFeedback().stream()
                .filter(f -> f.getFeedbackId().equals(id))
                .findFirst()
                .orElse(null);
    }

    // Get feedback by user
    public List<UserDAO.Feedback> getFeedbackByUser(String userId) {
        return getAllFeedback().stream()
                .filter(f -> f.getUserId().equals(userId))
                .collect(Collectors.toList());
    }

    // Get unresolved tickets
    public List<ParkingTransactionDAO.SupportTicket> getUnresolvedTickets() {
        return getAllFeedback().stream()
                .filter(f -> f instanceof ParkingTransactionDAO.SupportTicket && !f.isResolved())
                .map(f -> (ParkingTransactionDAO.SupportTicket) f)
                .collect(Collectors.toList());
    }

    // Update feedback (primarily for admin responses)
    public boolean updateFeedback(UserDAO.Feedback updatedFeedback) {
        List<UserDAO.Feedback> feedbackList = getAllFeedback();
        boolean found = false;

        for (int i = 0; i < feedbackList.size(); i++) {
            if (feedbackList.get(i).getFeedbackId().equals(updatedFeedback.getFeedbackId())) {
                feedbackList.set(i, updatedFeedback);
                found = true;
                break;
            }
        }

        if (found) {
            return saveAllFeedback(feedbackList);
        }
        return false;
    }

    private UserDAO.Feedback parseFeedbackLine(String line) {
        String[] parts = line.split("\\|");
        if (parts.length == 6) { // Regular feedback
            return UserDAO.Feedback.fromString(line);
        } else if (parts.length == 8) { // Support ticket
            return ParkingTransactionDAO.SupportTicket.fromString(line);
        }
        return null;
    }

    private boolean saveAllFeedback(List<UserDAO.Feedback> feedbackList) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (UserDAO.Feedback f : feedbackList) {
                writer.write(f.toString());
                writer.newLine();
            }
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteFeedback(String feedbackId) {
        List<UserDAO.Feedback> feedbackList = getAllFeedback();
        boolean removed = feedbackList.removeIf(f -> f.getFeedbackId().equals(feedbackId));

        if (removed) {
            return saveAllFeedback(feedbackList);
        }
        return false;
    }
}