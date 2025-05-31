# app-html-devops

Repositorio de ejemplo para prácticas DevOps: despliegue de aplicaciones HTML/PHP con NGINX usando Docker, Kubernetes, Ansible y CI/CD.

---

## Estructura del repositorio

```
.
├── app/                        # Código fuente de la aplicación (HTML, PHP)
├── config/                     # Configuración de NGINX
├── kubernetes/                 # Manifiestos de Kubernetes (deployments, services, ingress, etc.)
├── ansible/                    # Playbooks y configuración de Ansible
│   ├── ansible.cfg
│   ├── inventories/
│   │   └── development/hosts
│   └── playbooks/
├── dockerfile_nginx            # Dockerfile para NGINX
├── dockerfile_php              # Dockerfile para PHP-FPM
├── docker-compose.yaml         # Orquestación local con Docker Compose
├── .github/workflows/          # Workflows de GitHub Actions para CI/CD
└── README.md                   # Este archivo
```

---

## Despliegue local con Docker Compose

```sh
docker-compose up --build
```
Accede a la app en [http://localhost](http://localhost)

---

## Despliegue en Kubernetes

1. Aplica los manifiestos en el orden adecuado:
   ```sh
   kubectl apply -f kubernetes/app-project-devops-namespace.yaml
   kubectl apply -f kubernetes/app-project-devops-configmap-nginx.yaml
   kubectl apply -f kubernetes/app-project-devops-deployment-php.yaml
   kubectl apply -f kubernetes/app-project-devops-service-php.yaml
   kubectl apply -f kubernetes/app-project-devops-deployment-html.yaml
   kubectl apply -f kubernetes/app-project-devops-service-html.yaml
   kubectl apply -f kubernetes/app-project-devops-ingress.yaml
   ```
2. Accede a la app mediante el dominio configurado en el Ingress.

---

## CI/CD

- El flujo de CI/CD está definido en `.github/workflows/`.
- Al hacer push de un tag (`v*`), se construyen y publican las imágenes Docker y se actualizan los deployments en Kubernetes.

---

## Ansible

Repositorio para gestionar la parte de Ansible.

### Estructura relevante

- `ansible.cfg`: Configuración global de Ansible.
- `inventories/development/hosts`: Inventario de hosts para el entorno de desarrollo.
- `playbooks/`: Playbooks de Ansible para automatizar tareas en los servidores.

### Requisitos para usar Ansible

- Acceso a la vm-bastion (máquina de salto) y desde ahí a la vm final.
- Añadir tu clave pública SSH tanto en la vm-bastion como en la vm final.
- Configurar el archivo `~/.ssh/config` en tu máquina local:

    ```sh
    touch ~/.ssh/config
    ```

    Ejemplo de configuración:
    ```
    # Vm-Bastion
    Host NOMBRE-BASTION
      HostName IP-EXTERNA-BASTION
      User USUARIO-SSH-BASTION

    # Vm-Final
    Host NOMBRE-VM-FINAL
      HostName IP-INTERNA-VM-FINAL
      User USUARIO-SSH-VM-FINAL
      ProxyJump NOMBRE-BASTION
    ```

### Ejemplo de uso

```sh
ansible-playbook -i ./ansible/inventories/development/hosts ./ansible/playbooks/install_php8.2.yml
```

---

## Autor

- DevOps Engineer Project Example

---

## Licencia

MIT