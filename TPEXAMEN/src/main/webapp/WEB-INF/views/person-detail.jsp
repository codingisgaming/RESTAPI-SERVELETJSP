<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CyberPersonnel Manager | Détails de la personne</title>
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
            max-width: 900px;
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
            color: var(--primary-color);
            border-color: var(--cyber-border);
            background: rgba(0, 243, 255, 0.05);
        }

        .page-title {
            font-size: 2rem;
            margin-bottom: 25px;
            color: var(--primary-color);
            text-shadow: 0 0 15px var(--cyber-glow);
            position: relative;
            display: inline-block;
            padding-left: 15px;
        }

        .page-title::before {
            content: '>';
            position: absolute;
            left: 0;
            color: var(--primary-color);
        }

        .page-title i {
            margin-right: 12px;
            color: var(--primary-color);
        }

        /* Detail Card */
        .detail-card {
            background-color: var(--card-bg);
            border-radius: 8px;
            border: 1px solid var(--card-border);
            padding: 30px;
            margin-bottom: 30px;
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(10px);
        }

        .detail-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 1px;
            background: linear-gradient(90deg, 
                transparent, 
                var(--primary-color), 
                transparent);
        }

        .detail-header {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--card-border);
        }

        .avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, 
                rgba(0, 243, 255, 0.1), 
                rgba(0, 243, 255, 0.2));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: var(--primary-color);
            border: 1px solid var(--cyber-border);
            box-shadow: 0 0 20px var(--cyber-glow);
        }

        .detail-info h2 {
            font-size: 1.8rem;
            margin-bottom: 8px;
            color: var(--text-primary);
            font-weight: 600;
        }

        .detail-info .id-badge {
            display: inline-block;
            background: rgba(0, 243, 255, 0.1);
            color: var(--primary-color);
            padding: 4px 12px;
            border-radius: 4px;
            font-size: 0.85rem;
            font-family: 'Roboto Mono', monospace;
            border: 1px solid var(--cyber-border);
        }

        /* Info Grid */
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .info-item {
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid var(--card-border);
            border-radius: 6px;
            padding: 20px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .info-item:hover {
            border-color: var(--cyber-border);
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(0, 243, 255, 0.05);
        }

        .info-item::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 2px;
            background: var(--primary-color);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .info-item:hover::before {
            opacity: 1;
        }

        .info-label {
            color: var(--text-secondary);
            font-size: 0.85rem;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-label i {
            color: var(--primary-color);
            font-size: 0.9rem;
        }

        .info-value {
            font-size: 1.2rem;
            color: var(--text-primary);
            font-weight: 500;
            font-family: 'Roboto Mono', monospace;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 40px;
            padding-top: 30px;
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

        .btn-primary {
            color: var(--primary-color);
            border-color: var(--cyber-border);
            background: rgba(0, 243, 255, 0.05);
        }

        .btn-primary:hover {
            background: rgba(0, 243, 255, 0.1);
            box-shadow: 0 0 15px var(--cyber-glow);
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

        .btn-warning {
            color: var(--warning-color);
            border-color: rgba(245, 158, 11, 0.3);
            background: rgba(245, 158, 11, 0.05);
        }

        .btn-warning:hover {
            background: rgba(245, 158, 11, 0.1);
            border-color: var(--warning-color);
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
            background: var(--primary-color);
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

            .detail-card {
                padding: 20px;
            }

            .detail-header {
                flex-direction: column;
                text-align: center;
                gap: 15px;
            }

            .info-grid {
                grid-template-columns: 1fr;
                gap: 15px;
            }

            .action-buttons {
                flex-direction: column;
                gap: 10px;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }

        /* Terminal-like effects */
        .terminal-line {
            position: relative;
            padding-left: 20px;
        }

        .terminal-line::before {
            content: '$';
            position: absolute;
            left: 0;
            color: var(--primary-color);
            font-family: 'Roboto Mono', monospace;
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
                var(--primary-color), 
                transparent);
            animation: scan 8s linear infinite;
            opacity: 0.1;
            pointer-events: none;
            z-index: 9999;
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
                <a href="#" class="nav-link active"><i class="fas fa-eye"></i> DETAILS</a>
            </nav>
        </header>

        <main>
            <h1 class="page-title"><i class="fas fa-id-card"></i> DETAILS_PERSONNE</h1>

            <c:choose>
                <c:when test="${not empty person}">
                    <div class="detail-card">
                        <div class="detail-header">
                            <div class="avatar">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="detail-info">
                                <h2>${person.name}</h2>
                                <span class="id-badge">ID_${person.id}</span>
                            </div>
                        </div>

                        <div class="info-grid">
                            <div class="info-item">
                                <div class="info-label">
                                    <i class="fas fa-fingerprint"></i> IDENTIFIANT
                                </div>
                                <div class="info-value">${person.id}</div>
                            </div>

                            <div class="info-item">
                                <div class="info-label">
                                    <i class="fas fa-user-tag"></i> NOM COMPLET
                                </div>
                                <div class="info-value">${person.name}</div>
                            </div>

                            <div class="info-item">
                                <div class="info-label">
                                    <i class="fas fa-calendar-alt"></i> ÂGE
                                </div>
                                <div class="info-value">${person.age} ANS</div>
                            </div>

                            <div class="info-item">
                                <div class="info-label">
                                    <i class="fas fa-clock"></i> DATE ENREGISTREMENT
                                </div>
                                <div class="info-value">${currentDate}</div>
                            </div>
                        </div>

                        <div class="action-buttons">
                            <a href="persons" class="btn btn-secondary">
                                <i class="fas fa-arrow-left btn-icon"></i> RETOUR_LISTE
                            </a>
                            <a href="persons?action=editForm&id=${person.id}" class="btn btn-warning">
                                <i class="fas fa-edit btn-icon"></i> MODIFIER
                            </a>
                            <a href="persons?action=deleteForm&id=${person.id}" class="btn btn-danger">
                                <i class="fas fa-trash-alt btn-icon"></i> SUPPRIMER
                            </a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="detail-card">
                        <div class="empty-state" style="text-align: center; padding: 40px;">
                            <i class="fas fa-user-slash"
                                style="font-size: 3rem; color: var(--text-muted); margin-bottom: 20px; opacity: 0.5;"></i>
                            <h2 style="color: var(--text-secondary); margin-bottom: 15px; font-size: 1.5rem;">
                                PERSONNE_NON_TROUVEE
                            </h2>
                            <p style="color: var(--text-muted); margin-bottom: 25px; font-family: 'Roboto Mono', monospace;">
                                > ERREUR: ENTITE_INTROUVABLE
                            </p>
                            <a href="persons" class="btn btn-primary">
                                <i class="fas fa-arrow-left btn-icon"></i> RETOUR_LISTE
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>

        <footer>
            <p class="footer-text">CYBER_PERSONNEL v2.1 > DETAIL_VIEW > [${currentDate}]</p>
        </footer>
    </div>
</body>

</html>