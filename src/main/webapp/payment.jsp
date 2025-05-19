body {
    margin: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(to right, #edf2f7, #cbd5e0);
    padding: 40px 20px;
}

.container {
    max-width: 1200px;
    margin: auto;
}

.card {
    background-color: white;
    border-radius: 12px;
    padding: 30px;
    box-shadow: 0 12px 28px rgba(0, 0, 0, 0.1);
    animation: slideUp 0.6s ease;
}

.title {
    font-size: 26px;
    color: #2d3748;
    margin-bottom: 20px;
    text-align: center;
    font-weight: bold;
}

.table-wrapper {
    overflow-x: auto;
    animation: fadeIn 1s ease;
}

.transaction-table {
    width: 100%;
    border-collapse: collapse;
    min-width: 1000px;
}

.transaction-table th, .transaction-table td {
    padding: 14px 16px;
    border: 1px solid #e2e8f0;
    text-align: left;
    font-size: 14px;
}

.transaction-table th {
    background-color: #f7fafc;
    color: #4a5568;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.05em;
}

.hover-row:hover {
    background-color: #f1f5f9;
    transition: background-color 0.3s ease;
}

.status-paid {
    color: #38a169;
    font-weight: bold;
}

.status-unpaid {
    color: #e53e3e;
    font-weight: bold;
}

.btn-wrapper {
    margin-top: 25px;
    text-align: center;
}

.btn-back {
    display: inline-block;
    background-color: #3182ce;
    color: white;
    padding: 10px 20px;
    font-weight: 600;
    border-radius: 8px;
    text-decoration: none;
    transition: background-color 0.3s ease, transform 0.2s;
}

.btn-back:hover {
    background-color: #2b6cb0;
    transform: scale(1.05);
}

/* Animations */
@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

@keyframes slideUp {
    from { transform: translateY(30px); opacity: 0; }
    to { transform: translateY(0); opacity: 1; }
}

.animate-fadeIn {
    animation: fadeIn 1s ease;
}

.animate-slideUp {
    animation: slideUp 0.6s ease;
}
