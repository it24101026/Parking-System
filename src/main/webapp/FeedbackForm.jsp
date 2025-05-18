<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Feedback</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="css/feedback-form.css">
</head>

<body class="bg-gradient-to-br from-blue-100 via-white to-purple-100 min-h-screen flex items-center justify-center font-sans">

<div class="w-full max-w-2xl px-6 py-10">
    <div class="bg-white p-10 rounded-3xl shadow-2xl border border-gray-100 transition-all duration-300 hover:shadow-blue-200">
        <div class="flex justify-between items-center mb-8">
            <h2 class="text-4xl font-extrabold text-gray-800 tracking-tight">💬 Submit Feedback</h2>
            <a href="parking-slots?action=operator-view"
               class="text-sm text-blue-500 hover:text-blue-700 underline transition duration-200">
                ⬅ Back to Dashboard
            </a>
        </div>

        <% if (request.getAttribute("error") != null) { %>
        <div class="mb-5 p-4 bg-red-100 border-l-4 border-red-500 text-red-700 rounded-md shadow-sm">
            <p><%= request.getAttribute("error") %></p>
        </div>
        <% } %>

        <% if (request.getAttribute("success") != null) { %>
        <div class="mb-5 p-4 bg-green-100 border-l-4 border-green-500 text-green-700 rounded-md shadow-sm">
            <p><%= request.getAttribute("success") %></p>
        </div>
        <% } %>

        <form action="feedback" method="post" class="space-y-6">
            <input type="hidden" name="action" value="submit-feedback">

            <div>
                <label for="type" class="block text-sm font-semibold text-gray-700 mb-2">Feedback Type</label>
                <select id="type" name="type" required
                        class="w-full p-3 border border-gray-300 rounded-lg bg-gray-50 focus:ring-2 focus:ring-blue-500 focus:outline-none">
                    <option value="feedback">📝 General Feedback</option>
                    <option value="ticket">🎫 Support Ticket</option>
                </select>
            </div>

            <div>
                <label for="subject" class="block text-sm font-semibold text-gray-700 mb-2">Subject</label>
                <input type="text" id="subject" name="subject" required
                       placeholder="E.g., Issue with booking system"
                       class="w-full p-3 border border-gray-300 rounded-lg bg-gray-50 focus:ring-2 focus:ring-blue-500 focus:outline-none">
            </div>

            <div>
                <label for="message" class="block text-sm font-semibold text-gray-700 mb-2">Message</label>
                <textarea id="message" name="message" rows="5" required
                          placeholder="Write your detailed feedback here..."
                          class="w-full p-3 border border-gray-300 rounded-lg bg-gray-50 focus:ring-2 focus:ring-blue-500 focus:outline-none resize-none"></textarea>
            </div>

            <div class="flex justify-between items-center">
                <button type="submit"
                        class="px-6 py-2.5 bg-blue-600 text-white font-semibold rounded-lg shadow-md hover:bg-blue-700 transition duration-200 focus:outline-none focus:ring-2 focus:ring-blue-500">
                    🚀 Submit
                </button>
                <a href="parking-slots?action=operator-view"
                   class="text-sm text-gray-500 hover:text-gray-700 underline transition">
                    ✖ Cancel
                </a>
            </div>
        </form>
    </div>
</div>

</body>
</html>
