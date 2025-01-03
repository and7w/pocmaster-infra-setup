# pocmaster-infra-setup

Le projet **pocmaster-infra-setup** est une solution basée sur **Terraform et Ansible** qui facilite le déploiement automatisé d'outils de gestion d'infrastructure. Ce projet s'appuie sur la puissance des technologies **IaaS** pour automatiser la création et la configuration des outils suivants :

- **Vault**
- **Nexus**
- **ArgoCD**
- **SonarQube**
- **Consul**
- ...

## Objectif
L'objectif est d'automatiser l'infrastructure avec :
- **Terraform** pour la création et la gestion des environnements.
- **Ansible** pour l'installation et la configuration des outils.

---

## Structure du projet

Le projet est organisé en deux principaux répertoires :

- **`terraform/`** : Gestion des infrastructures (AWS, Vault, etc.).
- **`ansible/`** : Déploiement et configuration des outils.

---

## **Terraform**

Terraform est utilisé pour construire les environnements qui hébergeront les outils listés ci-dessus. Actuellement, les modules disponibles permettent de gérer :

1. **AWS** (`terraform/aws`):  
   Création d'une instance EC2 avec les ports et groupes de sécurité nécessaires.

2. **Vault** (`terraform/vault`):  
   Gestion des secrets, avec des configurations avancées pour l'intégration des déploiements.

### Utilisation de Terraform

#### **1. Configuration AWS**

- Assurez-vous d'avoir correctement configuré vos credentials AWS :
  ```plaintext
  aws_access_key_id
  aws_secret_access_key
  ```
  Configurez-les soit via la commande `aws configure`, soit dans un fichier `terraform.tfvars`.

- Commandes Terraform :
  ```bash
  terraform init
  terraform plan
  terraform apply -var-file="terraform.tfvars"
  ```

#### **2. Vault**

Pour Vault, vous pouvez vous connecter avec un token ou des credentials (`roleId` et `roleSecret`) définis dans `terraform.tfvars`. Consultez le fichier `00.providers.tf` pour plus de détails.

---

## **Ansible**

Ansible est utilisé pour installer et configurer les outils une fois l'infrastructure créée avec Terraform.

### **Inventories**
Les inventaires Ansible définissent les serveurs cibles. Consultez le fichier `ansible/inventories/00.inventory.yml`. Les adresses IP publiques et privées des serveurs sont issues des outputs Terraform, telles que :

- **`ec2_pocmaster_public_ip`**
- **`ec2_pocmaster_private_ip`**

### **Playbooks**
Les playbooks Ansible décrivent les actions à exécuter. Voici quelques exemples d'actions disponibles :

- Installation de **Java**.
- Installation de **Nexus**.
- Installation et configuration de **Vault**.

Chaque playbook peut inclure des **roles**. Les roles standardisent les tâches complexes et sont définis dans `ansible/roles`.

### **Utilisation**

#### **1. Initialisation d'un role**
```bash
ansible-galaxy init <nom_du_role>
```

#### **2. Installation de Nexus**
Pour installer Nexus via Ansible :
```bash
ansible-playbook -i inventories/00_inventory.yml playbooks/setup-nexus.yml
```

#### **3. Installation de Vault**
Pour installer Vault et configurer les tokens :
```bash
ansible-playbook -i inventories/00_inventory.yml playbooks/setup-vault.yml
ansible-playbook -i inventories/00_inventory.yml playbooks/vault.token.config.yml
```

# Quelques commandes Vault

### Activer et configurer les rôles Vault

```bash
# Activer l'utilisation des AppRoles
vault auth enable approle

# Créer une police nommée 'terraform' dans le fichier /opt/vault/vault.policy-terraform.hcl
vault policy write terraform /opt/vault/vault.policy-terraform.hcl

# Appliquer la police 'terraform' à un rôle nommé 'terraform'
vault write auth/approle/role/terraform \
    secret_id_ttl=200m \
    token_num_uses=100 \
    token_ttl=200m \
    token_max_ttl=200m \
    secret_id_num_uses=40 \
    token_policies=terraform

# Modifier la durée de vie des Secret IDs pour un rôle existant
vault write auth/approle/role/terraform secret_id_ttl=5h
```

### Obtenir les informations sur les AppRoles

```bash
# Obtenir la valeur du Role ID
vault read auth/approle/role/terraform/role-id

# Générer un Secret ID (celui-ci a une durée de vie limitée)
vault write -f auth/approle/role/terraform/secret-id

# Générer un token à partir d'un Role ID et d'un Secret ID
vault write auth/approle/login role_id="<role_id>" secret_id="<secret_id>"
```

### Gestion des secrets

```bash
# Créer un secret
vault kv put kv/tf-test-secret key="value"

# Lire un secret
vault kv get kv/tf-test-secret
```

### Vérification des permissions d'une police ou d'un rôle

les polices du role terraform sont defini dans le fichier ansible/roles/vault/template/vault.policy-terraform.hcl.j2

```bash
# Connaître les capacités d'un rôle ou d'un token pour un chemin donné
vault token capabilities <path>

# Exemple : vérifier les capacités d'un token sur un secret
vault token capabilities kv/tf-test-secret

# Connaître les capacités assignées à un AppRole (comme terraform)
vault list auth/approle/role/terraform
vault read auth/approle/role/terraform
```

