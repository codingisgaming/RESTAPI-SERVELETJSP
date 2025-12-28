<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CyberPersonnel Manager | Résultats de Recherche</title>
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
            --search-color: #9d4edd;
            --cyber-glow: rgba(0, 243, 255, 0.15);
            --cyber-border: rgba(0, 243, 255, 0.3);
            --search-glow: rgba(157, 78, 221, 0.15);
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
            max-width: 1200px;
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
            content: '#';
            position: absolute;
            left: 0;
            color: var(--primary-color);
            font-family: 'Roboto Mono', monospace;
        }
        
        .page-title i {
            margin-right: 12px;
            color: var(--primary-color);
        }
        
        /* Search Results Header */
        .search-header {
            background-color: var(--card-bg);
            border-radius: 8px;
            border: 1px solid var(--card-border);
            padding: 20px;
            margin-bottom: 30px;
            position: relative;
        }
        
        .search-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 1px;
            background: linear-gradient(90deg, 
                transparent, 
                var(--search-color), 
                transparent);
        }
        
        .search-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .search-title {
            color: var(--search-color);
            font-size: 1.4rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .search-title i {
            font-size: 1.5rem;
            filter: drop-shadow(0 0 5px var(--search-glow));
        }
        
        .search-stats {
            text-align: right;
        }
        
        .search-count {
            font-size: 2.5rem;
            color: var(--search-color);
            font-family: 'Roboto Mono', monospace;
            font-weight: 600;
        }
        
        .search-label {
            color: var(--text-secondary);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .search-term-container {
            background-color: rgba(157, 78, 221, 0.05);
            border: 1px solid rgba(157, 78, 221, 0.2);
            border-radius: 4px;
            padding: 12px 15px;
            margin-top: 15px;
            font-family: 'Roboto Mono', monospace;
        }
        
        .search-term-label {
            color: var(--text-secondary);
            font-size: 0.9rem;
            margin-bottom: 5px;
        }
        
        .search-term-value {
            color: var(--search-color);
            font-size: 1.1rem;
            font-weight: 600;
            word-break: break-word;
        }
        
        /* No Results State */
        .no-results {
            background-color: var(--card-bg);
            border-radius: 8px;
            border: 1px solid var(--card-border);
            padding: 40px 30px;
            text-align: center;
            margin-bottom: 30px;
        }
        
        .no-results-icon {
            font-size: 3rem;
            color: var(--warning-color);
            margin-bottom: 20px;
            opacity: 0.8;
        }
        
        .no-results-title {
            color: var(--warning-color);
            font-size: 1.4rem;
            margin-bottom: 15px;
        }
        
        .no-results-message {
            color: var(--text-secondary);
            margin-bottom: 25px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .suggestions {
            background-color: rgba(245, 158, 11, 0.05);
            border: 1px solid rgba(245, 158, 11, 0.2);
            border-radius: 6px;
            padding: 20px;
            margin-top: 20px;
            text-align: left;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .suggestions-title {
            color: var(--warning-color);
            font-size: 1rem;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .suggestions-list {
            list-style-type: none;
            padding-left: 0;
        }
        
        .suggestions-list li {
            color: var(--text-secondary);
            margin-bottom: 8px;
            padding-left: 20px;
            position: relative;
        }
        
        .suggestions-list li:before {
            content: '>';
            position: absolute;
            left: 0;
            color: var(--warning-color);
            font-family: 'Roboto Mono', monospace;
        }
        
        /* Table Container */
        .table-container {
            background-color: var(--card-bg);
            border-radius: 8px;
            border: 1px solid var(--card-border);
            overflow: hidden;
            margin-bottom: 30px;
            position: relative;
            backdrop-filter: blur(10px);
        }
        
        .table-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 1px;
            background: linear-gradient(90deg, 
                transparent, 
                var(--primary-color), 
                transparent);
        }
        
        /* Table Styles */
        .data-table {
            width: 100%;
            border-collapse: collapse;
            font-family: 'Roboto Mono', monospace;
        }
        
        .data-table thead {
            background: rgba(0, 243, 255, 0.05);
            border-bottom: 1px solid var(--cyber-border);
        }
        
        .data-table th {
            padding: 15px 20px;
            text-align: left;
            font-weight: 600;
            color: var(--primary-color);
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 1px;
            border-right: 1px solid rgba(0, 243, 255, 0.1);
        }
        
        .data-table th:last-child {
            border-right: none;
        }
        
        .data-table tbody tr {
            border-bottom: 1px solid var(--card-border);
            transition: all 0.3s ease;
        }
        
        .data-table tbody tr:hover {
            background-color: rgba(0, 243, 255, 0.03);
        }
        
        .data-table tbody tr:last-child {
            border-bottom: none;
        }
        
        .data-table td {
            padding: 15px 20px;
            color: var(--text-secondary);
            border-right: 1px solid rgba(255, 255, 255, 0.05);
        }
        
        .data-table td:first-child {
            color: var(--primary-color);
            font-weight: 600;
            font-family: 'Roboto Mono', monospace;
        }
        
        .data-table td:nth-child(2) {
            color: var(--text-primary);
        }
        
        .data-table td:last-child {
            border-right: none;
        }
        
        /* Status Badge */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 0.75rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-family: 'Roboto Mono', monospace;
        }
        
        .status-active {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
            border: 1px solid rgba(16, 185, 129, 0.3);
        }
        
        /* Action Buttons in Table */
        .action-cell {
            width: 180px;
            text-align: center;
        }
        
        .action-buttons-small {
            display: flex;
            gap: 8px;
            justify-content: center;
        }
        
        .btn-small {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 32px;
            height: 32px;
            border-radius: 4px;
            font-size: 0.9rem;
            text-decoration: none;
            transition: all 0.3s ease;
            border: 1px solid;
            cursor: pointer;
            background: transparent;
            position: relative;
            overflow: hidden;
        }
        
        .btn-small::before {
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
            transition: left 0.3s ease;
        }
        
        .btn-small:hover::before {
            left: 100%;
        }
        
        .btn-detail {
            color: var(--primary-color);
            border-color: rgba(0, 243, 255, 0.3);
            background: rgba(0, 243, 255, 0.05);
        }
        
        .btn-detail:hover {
            background: rgba(0, 243, 255, 0.1);
            border-color: var(--primary-color);
        }
        
        .btn-edit {
            color: var(--warning-color);
            border-color: rgba(245, 158, 11, 0.3);
            background: rgba(245, 158, 11, 0.05);
        }
        
        .btn-edit:hover {
            background: rgba(245, 158, 11, 0.1);
            border-color: var(--warning-color);
        }
        
        .btn-delete {
            color: var(--danger-color);
            border-color: rgba(239, 68, 68, 0.3);
            background: rgba(239, 68, 68, 0.05);
        }
        
        .btn-delete:hover {
            background: rgba(239, 68, 68, 0.1);
            border-color: var(--danger-color);
        }
        
        /* Action Buttons */
        .action-buttons {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            margin-top: 20px;
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
        
        .btn-search {
            color: var(--search-color);
            border-color: rgba(157, 78, 221, 0.3);
            background: rgba(157, 78, 221, 0.05);
        }
        
        .btn-search:hover {
            background: rgba(157, 78, 221, 0.1);
            border-color: var(--search-color);
            box-shadow: 0 0 15px var(--search-glow);
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
        
        /* Search Timestamp */
        .search-timestamp {
            color: var(--text-muted);
            font-size: 0.85rem;
            font-family: 'Roboto Mono', monospace;
            display: flex;
            align-items: center;
            gap: 8px;
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
            
            .search-info {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            
            .search-stats {
                text-align: center;
            }
            
            .action-buttons {
                flex-direction: column;
                gap: 10px;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
            
            .data-table {
                display: block;
                overflow-x: auto;
            }
            
            .action-buttons-small {
                flex-direction: row;
                gap: 5px;
                justify-content: flex-start;
            }
            
            .btn-small {
                width: 30px;
                height: 30px;
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
                var(--primary-color), 
                transparent);
            animation: scan 8s linear infinite;
            opacity: 0.1;
            pointer-events: none;
            z-index: 9999;
        }
        
        /* Tooltip */
        .btn-small[title]:hover:after {
            content: attr(title);
            position: absolute;
            bottom: -30px;
            left: 50%;
            transform: translateX(-50%);
            background-color: var(--card-bg);
            color: var(--text-primary);
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 0.8rem;
            white-space: nowrap;
            border: 1px solid var(--cyber-border);
            z-index: 100;
            font-family: 'Roboto Mono', monospace;
            text-transform: uppercase;
        }
        
        .btn-small {
            position: relative;
        }
        
        /* Highlight search term in results */
        .highlight-search {
            color: var(--search-color);
            background-color: rgba(157, 78, 221, 0.1);
            padding: 2px 4px;
            border-radius: 2px;
            font-weight: bold;
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
                <a href="persons?action=addForm" class="nav-link"><i class="fas fa-user-plus"></i> ADD</a>
                <a href="persons?action=searchForm" class="nav-link active"><i class="fas fa-search"></i> SEARCH</a>
            </nav>
        </header>
        
        <main>
            <h1 class="page-title"><i class="fas fa-search"></i> SEARCH_RESULTS</h1>
            
            <!-- En-tête des résultats de recherche -->
            <div class="search-header">
                <div class="search-info">
                    <div class="search-title">
                        <i class="fas fa-search"></i>
                        <span>RECHERCHE_EXÉCUTÉE</span>
                    </div>
                    <div class="search-stats">
                        <div class="search-count">${resultCount}</div>
                        <div class="search-label">RÉSULTAT(S)</div>
                    </div>
                </div>
                
                <div class="search-term-container">
                    <div class="search-term-label">TERME_RECHERCHÉ :</div>
                    <div class="search-term-value">"${searchTerm}"</div>
                </div>
            </div>
            
            <!-- Message si aucun résultat -->
            <c:if test="${empty persons or resultCount == 0}">
                <div class="no-results">
                    <div class="no-results-icon">
                        <i class="fas fa-search-minus"></i>
                    </div>
                    <h3 class="no-results-title">AUCUN_RÉSULTAT_TROUVÉ</h3>
                    <p class="no-results-message">
                        Aucune personne ne correspond à votre recherche : <span style="color: var(--search-color); font-weight: bold;">"${searchTerm}"</span>
                    </p>
                    
                    <div class="suggestions">
                        <div class="suggestions-title">
                            <i class="fas fa-lightbulb"></i>
                            <span>SUGGESTIONS :</span>
                        </div>
                        <ul class="suggestions-list">
                            <li>Vérifiez l'orthographe du terme</li>
                            <li>Utilisez des termes plus généraux</li>
                            <li>Essayez avec une partie du nom seulement</li>
                            <li>La recherche est insensible à la casse</li>
                        </ul>
                    </div>
                    
                    <div class="action-buttons" style="justify-content: center; margin-top: 30px;">
                        <a href="persons?action=searchForm" class="btn btn-search">
                            <i class="fas fa-search"></i> NOUVELLE_RECHERCHE
                        </a>
                        <a href="persons" class="btn btn-secondary">
                            <i class="fas fa-list-ul"></i> LISTE_COMPLÈTE
                        </a>
                    </div>
                </div>
            </c:if>
            
            <!-- Tableau des résultats -->
            <c:if test="${not empty persons and resultCount > 0}">
                <div class="table-container">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th><i class="fas fa-id-card"></i> ID</th>
                                <th><i class="fas fa-user"></i> NOM</th>
                                <th><i class="fas fa-calendar-alt"></i> ÂGE</th>
                                <th><i class="fas fa-tag"></i> STATUT</th>
                                <th><i class="fas fa-cogs"></i> ACTIONS</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="person" items="${persons}">
                                <tr>
                                    <td>${person.id}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty searchTerm and searchTerm != ''}">
                                                <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
                                                <c:set var="name" value="${person.name}" />
                                                <c:set var="lowerName" value="${fn:toLowerCase(name)}" />
                                                <c:set var="lowerSearch" value="${fn:toLowerCase(searchTerm)}" />
                                                <c:set var="startIndex" value="${fn:indexOf(lowerName, lowerSearch)}" />
                                                
                                                <c:choose>
                                                    <c:when test="${startIndex >= 0}">
                                                        <c:set var="before" value="${fn:substring(name, 0, startIndex)}" />
                                                        <c:set var="match" value="${fn:substring(name, startIndex, startIndex + fn:length(searchTerm))}" />
                                                        <c:set var="after" value="${fn:substring(name, startIndex + fn:length(searchTerm), fn:length(name))}" />
                                                        ${before}<span class="highlight-search">${match}</span>${after}
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${name}
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                ${person.name}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${person.age} ANS</td>
                                    <td>
                                        <span class="status-badge status-active">
                                            <i class="fas fa-circle" style="font-size: 0.6rem;"></i>
                                            ACTIF
                                        </span>
                                    </td>
                                    <td class="action-cell">
                                        <div class="action-buttons-small">
                                            <!-- Bouton Détails -->
                                            <a href="persons?action=detail&id=${person.id}" 
                                               class="btn-small btn-detail" 
                                               title="DÉTAILS">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            
                                            <!-- Bouton Modifier -->
                                            <a href="persons?action=editForm&id=${person.id}" 
                                               class="btn-small btn-edit" 
                                               title="MODIFIER">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            
                                            <!-- Bouton Supprimer -->
                                            <a href="persons?action=deleteForm&id=${person.id}" 
                                               class="btn-small btn-delete" 
                                               title="SUPPRIMER">
                                                <i class="fas fa-trash-alt"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <!-- Informations complémentaires -->
                <div class="search-timestamp">
                    <i class="fas fa-clock"></i>
                    <span>RECHERCHE_EXÉCUTÉE_LE : ${currentDate}</span>
                </div>
                
                <div class="action-buttons">
                    <div>
                        <a href="persons?action=searchForm" class="btn btn-search">
                            <i class="fas fa-search"></i> NOUVELLE_RECHERCHE
                        </a>
                    </div>
                    <div>
                        <a href="persons" class="btn btn-secondary">
                            <i class="fas fa-list-ul"></i> LISTE_COMPLÈTE
                        </a>
                    </div>
                </div>
            </c:if>
        </main>
        
        <footer>
            <p class="footer-text">CYBER_PERSONNEL v2.1 > SEARCH_RESULTS > [${currentDate}]</p>
        </footer>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const deleteButtons = document.querySelectorAll('.btn-delete');
            
            deleteButtons.forEach(button => {
                button.addEventListener('click', function(e) {
                    const personName = this.closest('tr').querySelector('td:nth-child(2)').textContent;
                    const personId = this.closest('tr').querySelector('td:first-child').textContent;
                    
                    if (!confirm(`[CONFIRMATION] SUPPRIMER "${personName}" (ID: ${personId}) ?`)) {
                        e.preventDefault();
                    }
                });
            });
            
            const tableRows = document.querySelectorAll('.data-table tbody tr');
            tableRows.forEach(row => {
                row.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateX(5px)';
                    this.style.transition = 'transform 0.3s ease';
                });
                
                row.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateX(0)';
                });
            });
            
            const highlightElements = document.querySelectorAll('.highlight-search');
            highlightElements.forEach(element => {
                element.addEventListener('mouseenter', function() {
                    this.style.backgroundColor = 'rgba(157, 78, 221, 0.2)';
                    this.style.boxShadow = '0 0 10px rgba(157, 78, 221, 0.3)';
                });
                
                element.addEventListener('mouseleave', function() {
                    this.style.backgroundColor = 'rgba(157, 78, 221, 0.1)';
                    this.style.boxShadow = 'none';
                });
            });
        });
    </script>
</body>
</html>