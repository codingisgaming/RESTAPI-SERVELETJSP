<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CyberPersonnel Manager | Modifier une personne</title>
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
            --warning-color: #00a8b5;
            --cyber-glow: rgba(0, 243, 255, 0.15);
            --cyber-border: rgba(0, 243, 255, 0.3);
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
                radial-gradient(circle at 80% 70%, rgba(0, 243, 255, 0.02) 0%, transparent 50%);
            pointer-events: none;
            z-index: -1;
        }
        
        .container {
            max-width: 800px;
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
                var(--primary-color), 
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
            color: var(--primary-color);
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
            color: var(--primary-color);
            border-color: var(--cyber-border);
        }
        
        .nav-link.active {
            color: var(--warning-color);
            border-color: rgba(245, 158, 11, 0.3);
            background: rgba(245, 158, 11, 0.05);
        }
        
        .page-title {
            font-size: 2rem;
            margin-bottom: 25px;
            color: var(--warning-color);
            text-shadow: 0 0 15px rgba(245, 158, 11, 0.3);
            position: relative;
            display: inline-block;
            padding-left: 15px;
        }
        
        .page-title::before {
            content: '$';
            position: absolute;
            left: 0;
            color: var(--warning-color);
            font-family: 'Roboto Mono', monospace;
        }
        
        .page-title i {
            margin-right: 12px;
            color: var(--warning-color);
        }
        
        /* Form Container */
        .form-container {
            background-color: var(--card-bg);
            border-radius: 8px;
            border: 1px solid var(--card-border);
            padding: 30px;
            margin-bottom: 30px;
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(10px);
        }
        
        .form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 1px;
            background: linear-gradient(90deg, 
                transparent, 
                var(--warning-color), 
                transparent);
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--card-border);
        }
        
        .form-header i {
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: var(--warning-color);
            filter: drop-shadow(0 0 10px rgba(245, 158, 11, 0.3));
        }
        
        .form-header h2 {
            font-size: 1.6rem;
            margin-bottom: 10px;
            color: var(--text-primary);
        }
        
        .form-header p {
            color: var(--text-secondary);
            font-size: 0.9rem;
            font-family: 'Roboto Mono', monospace;
        }
        
        .id-display {
            display: inline-block;
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning-color);
            padding: 4px 12px;
            border-radius: 4px;
            font-size: 0.85rem;
            font-family: 'Roboto Mono', monospace;
            border: 1px solid rgba(245, 158, 11, 0.3);
            margin-top: 10px;
        }
        
        /* Form Styles */
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 10px;
            color: var(--text-secondary);
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.85rem;
        }
        
        .form-label i {
            color: var(--warning-color);
            font-size: 0.9rem;
        }
        
        .form-control {
            width: 100%;
            padding: 14px 16px;
            background-color: rgba(255, 255, 255, 0.02);
            border: 1px solid var(--card-border);
            border-radius: 4px;
            color: var(--text-primary);
            font-size: 1rem;
            transition: all 0.3s ease;
            font-family: 'Roboto Mono', monospace;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--warning-color);
            background-color: rgba(255, 255, 255, 0.05);
            box-shadow: 0 0 0 1px var(--warning-color);
        }
        
        .form-hint {
            display: block;
            margin-top: 8px;
            font-size: 0.8rem;
            color: var(--text-muted);
            font-family: 'Roboto Mono', monospace;
            font-style: italic;
        }
        
        /* Form Actions */
        .form-actions {
            display: flex;
            justify-content: space-between;
            gap: 15px;
            margin-top: 40px;
            padding-top: 20px;
            border-top: 1px solid var(--card-border);
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
        
        .btn-warning {
            color: var(--warning-color);
            border-color: rgba(245, 158, 11, 0.3);
            background: rgba(245, 158, 11, 0.05);
        }
        
        .btn-warning:hover {
            background: rgba(245, 158, 11, 0.1);
            border-color: var(--warning-color);
            box-shadow: 0 0 15px rgba(245, 158, 11, 0.2);
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
        
        .btn-danger {
            color: var(--danger-color);
            border-color: rgba(239, 68, 68, 0.3);
            background: rgba(239, 68, 68, 0.05);
        }
        
        .btn-danger:hover {
            background: rgba(239, 68, 68, 0.1);
            border-color: var(--danger-color);
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
            background: var(--warning-color);
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
            
            .form-container {
                padding: 20px;
            }
            
            .form-actions {
                flex-direction: column;
                gap: 10px;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
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
                var(--warning-color), 
                transparent);
            animation: scan 8s linear infinite;
            opacity: 0.1;
            pointer-events: none;
            z-index: 9999;
        }
        
        /* Input focus animation */
        .form-control:focus {
            animation: inputPulse 2s infinite;
        }
        
        @keyframes inputPulse {
            0%, 100% {
                box-shadow: 0 0 0 1px var(--warning-color);
            }
            50% {
                box-shadow: 0 0 0 1px var(--warning-color), 0 0 10px rgba(245, 158, 11, 0.3);
            }
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
                <a href="#" class="nav-link active"><i class="fas fa-edit"></i> EDIT</a>
            </nav>
        </header>
        
        <main>
            <h1 class="page-title"><i class="fas fa-user-edit"></i> EDIT_PERSON</h1>
            
            <c:choose>
                <c:when test="${not empty person}">
                    <div class="form-container">
                        <div class="form-header">
                            <i class="fas fa-user-edit"></i>
                            <h2>MODIFIER_PROFIL</h2>
                            <p>UPDATE_PERSON_DATA</p>
                            <span class="id-display">ID_${person.id}</span>
                        </div>
                        
                        <form action="persons" method="post">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="${person.id}">
                            
                            <div class="form-group">
                                <label class="form-label" for="name">
                                    <i class="fas fa-user"></i> NOM_COMPLET
                                </label>
                                <input type="text" id="name" name="name" class="form-control" 
                                       value="${person.name}" required placeholder="EX: JEAN_DUPONT" />
                                <span class="form-hint">ENTREZ_LE_NOUVEAU_NOM</span>
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label" for="age">
                                    <i class="fas fa-calendar-alt"></i> ÂGE
                                </label>
                                <input type="number" id="age" name="age" class="form-control" 
                                       value="${person.age}" required min="1" max="120" placeholder="EX: 28" />
                                <span class="form-hint">ÂGE_EN_ANNÉES_[1-120]</span>
                            </div>
                            
                            <div class="form-actions">
                                <a href="persons" class="btn btn-secondary">
                                    <i class="fas fa-times btn-icon"></i> ANNULER
                                </a>
                                <a href="persons?action=deleteForm&id=${person.id}" class="btn btn-danger">
                                    <i class="fas fa-trash-alt btn-icon"></i> SUPPRIMER
                                </a>
                                <button type="submit" class="btn btn-warning">
                                    <i class="fas fa-save btn-icon"></i> MISE_À_JOUR
                                </button>
                            </div>
                        </form>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="form-container">
                        <div class="empty-state" style="text-align: center; padding: 40px;">
                            <i class="fas fa-exclamation-triangle" style="font-size: 3rem; color: var(--warning-color); margin-bottom: 20px; opacity: 0.5;"></i>
                            <h2 style="color: var(--text-secondary); margin-bottom: 15px; font-size: 1.5rem;">
                                PERSONNE_NON_TROUVEE
                            </h2>
                            <p style="color: var(--text-muted); margin-bottom: 25px; font-family: 'Roboto Mono', monospace;">
                                > ERREUR: IMPOSSIBLE_DE_MODIFIER
                            </p>
                            <a href="persons" class="btn btn-secondary">
                                <i class="fas fa-arrow-left btn-icon"></i> RETOUR_LISTE
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
        
        <footer>
            <p class="footer-text">CYBER_PERSONNEL v2.1 > EDIT_VIEW > [${currentDate}]</p>
        </footer>
    </div>
</body>
</html>