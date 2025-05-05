# DevOpsEngineer-Project1-Ansible
Repo para gestionar la parte de ansible.

*ansible.cfg: Este archivo es el archivo de configuración global de Ansible para tu proyecto.
              Aquí puedes especificar la ubicación del inventario, la configuración de SSH y otras opciones de Ansible que desees establecer.

*inventories/development/hosts: Este archivo de inventario contiene la lista de hosts que Ansible administrará en tu entorno de desarrollo.
                                Puedes especificar las direcciones IP o los nombres de host de los servidores
                                que has desplegado con Terraform en esta sección.

*playbooks/: Parece que tienes un directorio llamado playbooks, pero no has especificado ningún playbook en tu estructura actual.
             Aquí es donde colocarías tus playbooks de Ansible, que son archivos YAML que contienen las tareas que deseas ejecutar
             en tus servidores. Por ejemplo, puedes tener un playbook llamado deploy.yml para configurar tus servidores desplegados con Terraform.

# Requisitos:
- Tener acceso a la vm-bastion y esta, conexión a la vm final(Resumen, la vm-bastion tiene que ser una vm de salto o jump).
- Es necesario, añadir la Clave Pública de tú local o desde lo lances, a la vm-bastion y a la vm final.
- En la vm local o desde dónde lo lanzas, tienes que crear el fichero config en la ruta: (/home/USUARIO-LOCAL/.ssh/config)

    touch ~/.ssh/config

- Tambien necesitas añadir este bloque:

    ##Config###
    #Vm-Bastion#
    Host NOMBRE-BASTION
    HostName IP-EXTERNA-BASTION
    User USUARIO-SSH-BASTION
    
    #Vm-Final#
    Host NOMBRE-VM-FINAL
    HostName IP-INTERNA-VM-FINAL
    User USUARIO-SSH-VM-FINAL
    ProxyJump HOST-BASTION

*Host: es el que quieras, es para identificar la vm.
*HostName: IP de la VM, a la que conectas.
*User: Usuario con el que conectas a esa VM.
*ProxyJump: Tienes que poner el Host que le has puesto en NOMBRE-BASTION

# Modo uso:

-Ejemplo:
ansible-playbook -i ./inventories/development/hosts ./playbooks/install_php8.2.yml