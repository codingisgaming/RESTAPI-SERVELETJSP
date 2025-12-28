<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CyberPersonnel Manager | Recherche</title>
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
            margin-bottom: 40px;
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
            margin-bottom: 30px;
            color: var(--search-color);
            text-shadow: 0 0 15px var(--search-glow);
            position: relative;
            display: inline-block;
            padding-left: 15px;
            text-align: center;
            width: 100%;
        }
        
        .page-title::before {
            content: '#';
            position: absolute;
            left: 0;
            color: var(--search-color);
            font-family: 'Roboto Mono', monospace;
        }
        
        .page-title i {
            margin-right: 12px;
            color: var(--search-color);
        }
        
        /* Search Container */
        .search-container {
            background-color: var(--card-bg);
            border-radius: 8px;
            border: 1px solid var(--card-border);
            padding: 30px;
            margin-bottom: 30px;
            position: relative;
        }
        
        .search-container::before {
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
        
        .search-title {
            color: var(--search-color);
            font-size: 1.4rem;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .search-title i {
            font-size: 1.5rem;
            filter: drop-shadow(0 0 5px var(--search-glow));
        }
        
        /* Form Styles */
        .search-form {
            margin-bottom: 30px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            color: var(--text-secondary);
            margin-bottom: 8px;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .form-label i {
            color: var(--search-color);
            font-size: 1.1rem;
        }
        
        .form-input {
            width: 100%;
            background-color: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--card-border);
            border-radius: 4px;
            padding: 12px 15px;
            color: var(--text-primary);
            font-family: 'Roboto Mono', monospace;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .form-input:focus {
            outline: none;
            border-color: var(--search-color);
            box-shadow: 0 0 15px var(--search-glow);
        }
        
        .form-input::placeholder {
            color: var(--text-muted);
            font-family: 'Roboto Mono', monospace;
        }
        
        .form-input:invalid {
            border-color: var(--danger-color);
        }
        
        .error-message {
            color: var(--danger-color);
            font-size: 0.85rem;
            margin-top: 5px;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        
        .form-actions {
            display: flex;
            justify-content: space-between;
            gap: 15px;
            margin-top: 25px;
        }
        
        /* Button Styles */
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
        
        /* Tips Container */
        .tips-container {
            background-color: var(--card-bg);
            border-radius: 8px;
            border: 1px solid var(--card-border);
            padding: 25px;
            position: relative;
        }
        
        .tips-container::before {
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
        
        .tips-title {
            color: var(--primary-color);
            font-size: 1.2rem;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .tips-title i {
            font-size: 1.3rem;
            filter: drop-shadow(0 0 5px var(--cyber-glow));
        }
        
        .tips-list {
            list-style-type: none;
            padding-left: 0;
        }
        
        .tips-list li {
            color: var(--text-secondary);
            margin-bottom: 10px;
            padding-left: 25px;
            position: relative;
            line-height: 1.5;
        }
        
        .tips-list li:before {
            content: '>';
            position: absolute;
            left: 0;
            color: var(--primary-color);
            font-family: 'Roboto Mono', monospace;
            font-weight: bold;
        }
        
        /* Error Alert */
        .alert {
            background-color: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.3);
            border-radius: 6px;
            padding: 15px 20px;
            margin-bottom: 20px;
            color: var(--danger-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .alert-content {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .alert-close {
            background: none;
            border: none;
            color: var(--danger-color);
            cursor: pointer;
            font-size: 1.2rem;
            padding: 0;
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            transition: background-color 0.3s ease;
        }
        
        .alert-close:hover {
            background-color: rgba(239, 68, 68, 0.2);
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
                text-align: center;
            }
            
            .search-container {
                padding: 20px;
            }
            
            .form-actions {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
        }
        
        /* Form Validation */
        .was-validated .form-input:invalid {
            border-color: var(--danger-color);
            background-color: rgba(239, 68, 68, 0.05);
        }
        
        .was-validated .form-input:valid {
            border-color: var(--success-color);
            background-color: rgba(16, 185, 129, 0.05);
        }
        
        /* Loading Animation */
        .search-loading {
            display: none;
            text-align: center;
            margin-top: 20px;
            color: var(--search-color);
            font-family: 'Roboto Mono', monospace;
        }
        
        .search-loading::after {
            content: '';
            animation: dots 1.5s infinite;
        }
        
        @keyframes dots {
            0%, 20% { content: ''; }
            40% { content: '.'; }
            60% { content: '..'; }
            80%, 100% { content: '...'; }
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
            <h1 class="page-title"><i class="fas fa-search"></i> SEARCH_INTERFACE</h1>
            
            <!-- Affichage des erreurs -->
            <c:if test="${not empty error}">
                <div class="alert">
                    <div class="alert-content">
                        <i class="fas fa-exclamation-triangle"></i>
                        <span>${error}</span>
                    </div>
                    <button class="alert-close" onclick="this.parentElement.style.display='none'">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
            </c:if>
            
            <!-- Formulaire de recherche -->
            <div class="search-container">
                <div class="search-title">
                    <i class="fas fa-search"></i>
                    <span>PARAMÈTRES_DE_RECHERCHE</span>
                </div>
                
                <form action="persons" method="get" class="search-form" id="searchForm" novalidate>
                    <input type="hidden" name="action" value="search">
                    
                    <div class="form-group">
                        <label for="search" class="form-label">
                            <i class="fas fa-user"></i>
                            <span>NOM_À_RECHERCHER :</span>
                        </label>
                        <input type="text" 
                               class="form-input" 
                               id="search" 
                               name="search" 
                               required
                               placeholder="ENTREZ_LE_NOM_OU_UNE_PARTIE_DU_NOM"
                               autocomplete="off"
                               autofocus>
                        <div class="error-message">
                            <i class="fas fa-exclamation-circle"></i>
                            <span>VEUILLEZ_SAISIR_UN_TERME_DE_RECHERCHE</span>
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <a href="persons" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> RETOUR
                        </a>
                        <button type="submit" class="btn btn-search">
                            <i class="fas fa-search"></i> EXÉCUTER_RECHERCHE
                        </button>
                    </div>
                </form>
                
                <!-- Indicateur de chargement -->
                <div class="search-loading" id="loadingIndicator">
                    RECHERCHE_EN_COURS
                </div>
            </div>
            
            <!-- Conseils de recherche -->
            <div class="tips-container">
                <div class="tips-title">
                    <i class="fas fa-info-circle"></i>
                    <span>CONSEILS_DE_RECHERCHE</span>
                </div>
                <ul class="tips-list">
                    <li>La recherche est insensible à la casse (majuscules/minuscules)</li>
                    <li>Vous pouvez rechercher par nom complet ou partiel</li>
                    <li>Les résultats afficheront toutes les correspondances</li>
                    <li>Utilisez des termes spécifiques pour des résultats précis</li>
                    <li>La recherche fonctionne sur tous les enregistrements actifs</li>
                </ul>
            </div>
        </main>
        
        <footer>
            <p class="footer-text">CYBER_PERSONNEL v2.1 > SEARCH_INTERFACE > [SYSTEM_READY]</p>
        </footer>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('searchForm');
            const loadingIndicator = document.getElementById('loadingIndicator');
            const errorMessage = document.querySelector('.error-message');
            
            errorMessage.style.display = 'none';
            
            form.addEventListener('submit', function(event) {
                event.preventDefault();
                event.stopPropagation();
                
                errorMessage.style.display = 'none';
                
                const searchInput = document.getElementById('search');
                const searchValue = searchInput.value.trim();
                
                if (!searchValue) {
                    errorMessage.style.display = 'flex';
                    searchInput.focus();
                    form.classList.add('was-validated');
                    return false;
                }
                
                loadingIndicator.style.display = 'block';
                
                setTimeout(function() {
                    form.submit();
                }, 500);
            });
            
            const searchInput = document.getElementById('search');
            searchInput.addEventListener('input', function() {
                if (this.value.trim()) {
                    errorMessage.style.display = 'none';
                }
            });
            
            searchInput.focus();
            
            searchInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    form.dispatchEvent(new Event('submit'));
                }
            });
            
            // Effet de typewriter pour le placeholder
            const placeholder = "ENTREZ_LE_NOM_OU_UNE_PARTIE_DU_NOM";
            let i = 0;
            const typewriter = setInterval(function() {
                if (i < placeholder.length) {
                    searchInput.setAttribute('placeholder', placeholder.substring(0, i + 1));
                    i++;
                } else {
                    clearInterval(typewriter);
                }
            }, 50);
            
            // Confirmation avant de quitter si le champ est rempli
            window.addEventListener('beforeunload', function(e) {
                const searchInput = document.getElementById('search');
                if (searchInput && searchInput.value.trim() !== '') {
                    e.preventDefault();
                    e.returnValue = '';
                }
            });
        });
    </script>
</body>
</html>