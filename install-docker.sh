# Étape 1 : Préparer le dépôt APT de Docker
echo "Mise à jour et installation des dépendances de Docker..."
apt-get update -y
apt-get install -y ca-certificates curl

# Configuration des permissions et téléchargement de la clé GPG Docker
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Étape 2 : Ajouter le dépôt Docker
echo "Ajout du dépôt Docker..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y

# Étape 3 : Installer Docker et les plugins nécessaires
echo "Installation de Docker et des plugins..."
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Vérifier que Docker est installé
echo "Vérification de l'installation de Docker..."
docker --versionc

# Étape 4 : Exécuter un test avec Docker
echo "Exécution du test Docker hello-world..."
docker run hello-world

# Étape 5 : (Optionnel) Lancer des conteneurs nginx et Apache pour vérification
echo "Lancement des conteneurs Nginx et Apache..."
docker run -p 8080:80 -d nginx
docker run -p 8081:80 -d httpd

echo "Installation terminée ! Accédez à Nginx sur http://votre_ip:8080 et à Apache sur http://votre_ip:8081"

mkdir -p ~/docker-services
nano docker-compose.yml

