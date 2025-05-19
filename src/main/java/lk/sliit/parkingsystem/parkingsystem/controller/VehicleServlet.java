/* Animations */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}

@keyframes fadeInDown {
    from { opacity: 0; transform: translateY(-10px); }
    to { opacity: 1; transform: translateY(0); }
}

@keyframes fadeInUp {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

.animate-fadeIn {
    animation: fadeIn 0.8s ease-in-out;
}package com.app.parking.controller;

import com.app.parking.dao.VehicleDAO;
import com.app.parking.model.*;
        import jakarta.servlet.*;
        import jakarta.servlet.http.*;
        import jakarta.servlet.annotation.*;

        import java.io.IOException;

@WebServlet(name = "VehicleServlet", value = "/vehicles")
public class VehicleServlet extends HttpServlet {
    private VehicleDAO vehicleDAO;

    @Override
    public void init() {
        vehicleDAO = new VehicleDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteVehicle(request, response);
                break;
            default:
                listAllVehicles(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            createVehicle(request, response);
        } else if ("update".equals(action)) {
            updateVehicle(request, response);
        }
    }

    private void listAllVehicles(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("vehicles", vehicleDAO.getAllVehicles());
        request.getRequestDispatcher("vehicle-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("vehicle-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        request.setAttribute("vehicle", vehicleDAO.getVehicleById(id));
        request.getRequestDispatcher("vehicle-form.jsp").forward(request, response);
    }

    private void createVehicle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String licensePlate = request.getParameter("licensePlate");
        String ownerName = request.getParameter("ownerName");
        String type = request.getParameter("type");

        // Check if vehicle already exists
        boolean exists = vehicleDAO.getAllVehicles().stream()
                .anyMatch(v -> v.getLicensePlate().equalsIgnoreCase(licensePlate));

        if (exists) {
            request.setAttribute("error", "Vehicle with this license plate already exists");
            request.getRequestDispatcher("vehicle-form.jsp").forward(request, response);
            return;
        }

        Vehicle vehicle = switch (type) {
            case "Car" -> new Car(licensePlate, ownerName);
            case "Bike" -> new Bike(licensePlate, ownerName);
            case "Truck" -> new Truck(licensePlate, ownerName);
            default -> null;
        };

        if (vehicle != null && vehicleDAO.createVehicle(vehicle)) {
            response.sendRedirect("vehicles");
        } else {
            request.setAttribute("error", "Failed to create vehicle");
            request.getRequestDispatcher("vehicle-form.jsp").forward(request, response);
        }
    }

    private void updateVehicle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String licensePlate = request.getParameter("licensePlate");
        String ownerName = request.getParameter("ownerName");

        Vehicle existingVehicle = vehicleDAO.getVehicleById(id);
        if (existingVehicle == null) {
            response.sendRedirect("vehicles");
            return;
        }

        // Check if new license plate is already taken by another vehicle
        boolean plateTaken = vehicleDAO.getAllVehicles().stream()
                .anyMatch(v -> !v.getVehicleId().equals(id) &&
                        v.getLicensePlate().equalsIgnoreCase(licensePlate));

        if (plateTaken) {
            request.setAttribute("error", "License plate already in use by another vehicle");
            request.setAttribute("vehicle", existingVehicle);
            request.getRequestDispatcher("vehicle-form.jsp").forward(request, response);
            return;
        }

        existingVehicle.setLicensePlate(licensePlate);
        existingVehicle.setOwnerName(ownerName);

        if (vehicleDAO.updateVehicle(existingVehicle)) {
            response.sendRedirect("vehicles");
        } else {
            request.setAttribute("error", "Failed to update vehicle");
            request.setAttribute("vehicle", existingVehicle);
            request.getRequestDispatcher("vehicle-form.jsp").forward(request, response);
        }
    }

    private void deleteVehicle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        vehicleDAO.deleteVehicle(id);
        response.sendRedirect("vehicles");
    }
}

.animate-fadeInDown {
    animation: fadeInDown 0.6s ease-in-out;
}

.animate-fadeInUp {
    animation: fadeInUp 0.7s ease-out;
}

.animate-slideIn {
    animation: fadeIn 1s ease-in-out;
}

/* Alerts */
.alert {
    max-width: 720px;
    margin: 1rem auto;
    padding: 1rem;
    border-radius: 0.5rem;
    font-weight: 500;
}
.alert.error {
    background-color: #fee2e2;
    border-left: 4px solid #dc2626;
    color: #991b1b;
}
.alert.success {
    background-color: #d1fae5;
    border-left: 4px solid #059669;
    color: #065f46;
}

/* Buttons */
.btn-primary {
    @apply inline-flex items-center px-4 py-2 text-white bg-blue-600 hover:bg-blue-700 font-medium rounded-md transition duration-200;
}
.btn-warning {
    @apply px-3 py-2 bg-yellow-500 hover:bg-yellow-600 text-white text-sm rounded-md shadow;
}
.btn-danger {
    @apply px-3 py-2 bg-red-500 hover:bg-red-600 text-white text-sm rounded-md shadow;
}

/* Table */
.th {
    @apply px-4 py-3 text-xs font-bold text-gray-600 uppercase tracking-wider;
}
.td {
    @apply px-4 py-4 text-sm text-gray-700;
}
