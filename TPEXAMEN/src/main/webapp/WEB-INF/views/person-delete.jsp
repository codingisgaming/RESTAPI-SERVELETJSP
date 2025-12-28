<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CyberPersonnel Manager | Supprimer une personne</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #00f3ff;
            --primary-dark: #00a8b5;
            --secondary-color: #2d3748;
            --dark-bg: #0a0a0f;
            --darker-bg: #050508;
            --card-bg: #111119;
            --card-border: #1e1e2e;
            --text-primary: #e2e8f0;
            --text-secondary: #94a3b8;
            --text-muted: #64748b;
            --danger-color: #ef4444;
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --cyber-glow: rgba(0, 243, 255, 0.15);
            --danger-glow: rgba(239, 68, 68, 0.2);
            --cyber-border: rgba(0, 243, 255, 0.3);
            --danger-border: rgba(239, 68, 68, 0.5);
            --grid-color: rgba(0, 243, 255, 0.05);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', 'Roboto Mono', 'Consolas', monospace;
        }
        
        body {
            background-color: var(--dark-bg);
            color: var(--text-primary);
            min-height: 100vh;
            background-image: 
                linear-gradient(0deg, transparent 24%, var(--grid-color) 25%, var(--grid-color) 26%, transparent 27%, transparent 74%, var(--grid-color) 75%, var(--grid-color) 76%, transparent 77%, transparent),
                linear-gradient(90deg, transparent 24%, var(--grid-color) 25%, var(--grid-color) 26%, transparent 27%, transparent 74%, var(--grid-color) 75%, var(--grid-color) 76%, transparent 77%, transparent);
            background-size: 50px 50px;
            line-height: 1.6;
            overflow-x: hidden;
        }
        
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 30%, rgba(0, 243, 255, 0.03) 0%, transparent 50%),
                radial-gradient(circle at 80% 70%, rgba(239, 68, 68, 0.02) 0%, transparent 50%);
            pointer-events: none;
            z-index: -1;
        }
        
        .container {
            max-width: 700px;
            margin: 0 auto;
            padding: 20px;
            position: relative;
        }
        
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 0;
            margin-bottom: 30px;
            border-bottom: 1px solid var(--card-border);
            position: relative;
        }
        
        header::after {
            content: '';
            position: absolute;
            bottom: -1px;
            left: 0;
            width: 100%;
            height: 1px;
            background: linear-gradient(90deg, 
                transparent, 
                var(--danger-color), 
                transparent);
        }
        
        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 1.6rem;
            font-weight: 600;
            color: var(--primary-color);
            text-shadow: 0 0 10px var(--cyber-glow);
        }
        
        .logo i {
            font-size: 1.8rem;
            filter: drop-shadow(0 0 5px var(--cyber-glow));
        }
        
        .logo::after {
            content: '>';
            color: var(--danger-color);
            margin-left: 5px;
            animation: blink 1s infinite;
        }
        
        @keyframes blink {
            0%, 100% { opacity: 1; }
            50% { opacity: 0; }
        }
        
        .nav-links {
            display: flex;
            gap: 15px;
        }
        
        .nav-link {
            color: var(--text-secondary);
            text-decoration: none;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 4px;
            transition: all 0.3s ease;
            position: relative;
            border: 1px solid transparent;
        }
        
        .nav-link:hover {
            color: var(--text-primary);
            border-color: var(--cyber-border);
        }
        
        .nav-link.active {
            color: var(--danger-color);
            border-color: var(--danger-border);
            background: rgba(239, 68, 68, 0.05);
        }
        
        .page-title {
            font-size: 2rem;
            margin-bottom: 25px;
            color: var(--danger-color);
            text-shadow: 0 0 15px var(--danger-glow);
            position: relative;
            display: inline-block;
            padding-left: 15px;
        }
        
        .page-title::before {
            content: '!';
            position: absolute;
            left: 0;
            color: var(--danger-color);
            font-family: 'Roboto Mono', monospace;
            font-weight: bold;
        }
        
        .page-title i {
            margin-right: 12px;
            color: var(--danger-color);
        }
        
        /* Confirmation Card */
        .confirmation-card {
            background-color: var(--card-bg);
            border-radius: 8px;
            border: 1px solid var(--card-border);
            padding: 30px;
            margin-bottom: 30px;
            position: relative;
            overflow: hidden;
            text-align: center;
            backdrop-filter: blur(10px);
        }
        
        .confirmation-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 1px;
            background: linear-gradient(90deg, 
                transparent, 
                var(--danger-color), 
                transparent);
        }
        
        .warning-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: rgba(239, 68, 68, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
            font-size: 2.5rem;
            color: var(--danger-color);
            border: 2px solid var(--danger-border);
            animation: dangerPulse 2s infinite;
        }
        
        @keyframes dangerPulse {
            0%, 100% { 
                box-shadow: 0 0 0 0 rgba(239, 68, 68, 0.1);
            }
            50% { 
                box-shadow: 0 0 0 10px rgba(239, 68, 68, 0);
            }
        }
        
        .confirmation-card h2 {
            font-size: 1.6rem;
            margin-bottom: 15px;
            color: var(--text-primary);
        }
        
        .confirmation-card p {
            color: var(--text-secondary);
            margin-bottom: 20px;
            font-size: 1rem;
            font-family: 'Roboto Mono', monospace;
        }
        
        .person-info {
            background: rgba(239, 68, 68, 0.05);
            border: 1px solid var(--danger-border);
            border-radius: 6px;
            padding: 20px;
            margin: 25px 0;
            text-align: left;
        }
        
        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
            padding-bottom: 12px;
            border-bottom: 1px solid rgba(239, 68, 68, 0.2);
        }
        
        .info-row:last-child {
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
        }
        
        .info-label {
            color: var(--text-secondary);
            font-weight: 500;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .info-value {
            color: var(--text-primary);
            font-weight: 600;
            font-family: 'Roboto Mono', monospace;
        }
        
        .highlight {
            color: var(--danger-color);
            font-weight: 700;
            text-shadow: 0 0 5px var(--danger-glow);
        }
        
        .warning-text {
            background: rgba(239, 68, 68, 0.1);
            border-left: 3px solid var(--danger-color);
            padding: 15px;
            margin: 20px 0;
            text-align: left;
            border-radius: 0 4px 4px 0;
        }
        
        .warning-text strong {
            color: var(--danger-color);
        }
        
        /* Action Buttons */
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
            padding-top: 25px;
            border-top: 1px solid var(--card-border);
            flex-wrap: wrap;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            border-radius: 4px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
            border: 1px solid;
            cursor: pointer;
            font-size: 0.95rem;
            min-width: 160px;
            justify-content: center;
            background: transparent;
            position: relative;
            overflow: hidden;
        }
        
        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, 
                transparent, 
                rgba(255, 255, 255, 0.1), 
                transparent);
            transition: left 0.5s ease;
        }
        
        .btn:hover::before {
            left: 100%;
        }
        
        .btn-danger {
            color: var(--danger-color);
            border-color: var(--danger-border);
            background: rgba(239, 68, 68, 0.05);
        }
        
        .btn-danger:hover {
            background: rgba(239, 68, 68, 0.1);
            box-shadow: 0 0 15px var(--danger-glow);
        }
        
        .btn-secondary {
            color: var(--text-secondary);
            border-color: var(--card-border);
            background: rgba(255, 255, 255, 0.02);
        }
        
        .btn-secondary:hover {
            color: var(--text-primary);
            border-color: var(--primary-color);
            background: rgba(0, 243, 255, 0.05);
        }
        
        .btn-icon {
            font-size: 1rem;
        }
        
        /* Footer */
        footer {
            text-align: center;
            margin-top: 50px;
            padding: 20px 0;
            color: var(--text-muted);
            font-size: 0.85rem;
            border-top: 1px solid var(--card-border);
            position: relative;
        }
        
        footer::before {
            content: '';
            position: absolute;
            top: -1px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 1px;
            background: var(--danger-color);
        }
        
        .footer-text {
            font-family: 'Roboto Mono', monospace;
            letter-spacing: 1px;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }
            
            header {
                flex-direction: column;
                gap: 20px;
                text-align: center;
            }
            
            .nav-links {
                justify-content: center;
                flex-wrap: wrap;
            }
            
            .page-title {
                font-size: 1.6rem;
            }
            
            .confirmation-card {
                padding: 20px;
            }
            
            .action-buttons {
                flex-direction: column;
                gap: 10px;
            }
            
            .btn {
                width: 100%;
                min-width: auto;
            }
            
            .info-row {
                flex-direction: column;
                gap: 5px;
                align-items: flex-start;
            }
            
            .warning-icon {
                width: 70px;
                height: 70px;
                font-size: 2rem;
            }
        }
        
        /* Scan line animation */
        @keyframes scan {
            0% {
                transform: translateY(-100%);
            }
            100% {
                transform: translateY(100vh);
            }
        }
        
        .scan-line {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 2px;
            background: linear-gradient(90deg, 
                transparent, 
                var(--danger-color), 
                transparent);
            animation: scan 8s linear infinite;
            opacity: 0.1;
            pointer-events: none;
            z-index: 9999;
        }
        
        /* Terminal style error */
        .terminal-error {
            font-family: 'Roboto Mono', monospace;
            color: var(--danger-color);
            background: rgba(239, 68, 68, 0.05);
            padding: 10px;
            border-radius: 4px;
            margin: 10px 0;
            border-left: 3px solid var(--danger-color);
        }
    </style>
</head>
<body>
    <div class="scan-line"></div>
    <div class="container">
        <header>
            <div class="logo">
                <i class="fas fa-terminal"></i>
                <span>CYBER_PERSONNEL</span>
            </div>
            <nav class="nav-links">
                <a href="persons" class="nav-link"><i class="fas fa-list"></i> LIST</a>
                <a href="#" class="nav-link active"><i class="fas fa-trash-alt"></i> DELETE</a>
            </nav>
        </header>
        
        <main>
            <h1 class="page-title"><i class="fas fa-user-slash"></i> DELETE_PERSON</h1>
            
            <c:choose>
                <c:when test="${not empty person}">
                    <div class="confirmation-card">
                        <div class="warning-icon">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        
                        <h2>CONFIRM_DELETION</h2>
                        <p>> EXECUTE PERMANENT REMOVAL FROM DATABASE</p>
                        
                        <div class="person-info">
                            <div class="info-row">
                                <span class="info-label">ID:</span>
                                <span class="info-value highlight">${person.id}</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">NOM:</span>
                                <span class="info-value">${person.name}</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">ÂGE:</span>
                                <span class="info-value">${person.age} ANS</span>
                            </div>
                        </div>
                        
                        <div class="warning-text">
                            <strong>> WARNING:</strong> ACTION IRREVERSIBLE. DATA CANNOT BE RECOVERED.
                        </div>
                        
	<div class="action-buttons">
	    <a href="persons" class="btn btn-secondary">
	        <i class="fas fa-times btn-icon"></i> ANNULER
	    </a>
	    <form action="persons" method="POST" style="display: inline;">
	        <input type="hidden" name="action" value="delete">
	        <input type="hidden" name="id" value="${person.id}">
	        <input type="hidden" name="_method" value="DELETE">
	        <button type="submit" class="btn btn-danger">
	            <i class="fas fa-trash-alt btn-icon"></i> CONFIRMER_SUPPRESSION
	        </button>
	    </form>
	</div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="confirmation-card">
                        <div class="warning-icon" style="background: rgba(0, 243, 255, 0.1); border-color: var(--cyber-border); color: var(--primary-color);">
                            <i class="fas fa-question-circle"></i>
                        </div>
                        
                        <h2>PERSONNE_NON_TROUVEE</h2>
                        <p>> ERROR: ENTITY NOT FOUND OR ALREADY DELETED</p>
                        
                        <div class="terminal-error">
                            > STATUS: 404_NOT_FOUND<br>
                            > ACTION: ABORT_DELETION
                        </div>
                        
                        <div class="action-buttons">
                            <a href="persons" class="btn btn-secondary">
                                <i class="fas fa-arrow-left btn-icon"></i> RETOUR_LISTE
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
        
        <footer>
            <p class="footer-text">CYBER_PERSONNEL v2.1 > DELETE_VIEW > [${currentDate}]</p>
        </footer>
    </div>
</body>
</html>