 #!/bin/bash


# ====== VARIABLES ======

ORIGEN="/opt/confidencial" # Carpeta a respaldar

DESTINO_LOCAL="/home/wasted_exe/respaldos/local" # Carpeta donde se guardará el respaldo completo local

DESTINO_REMOTO="/home/astro/respaldo" # Carpeta en el cliente remoto

REMOTE_USER="astro" # Usuario remoto

REMOTE_IP="100.105.62.44" # IP del cliente usado como respaldo remoto

REMOTE_PASS="astro" # Contraseña SSH del remoto


# ====== LOG ======

logger -t backup-script "Iniciando respaldo COMPLETO."


# ====== RESPALDO LOCAL ======

rsync -av --delete "$ORIGEN" "$DESTINO_LOCAL"

if [ $? -eq 0 ]; then

logger -t backup-script "Respaldo completo local finalizado correctamente."

else

logger -t backup-script "ERROR: El respaldo completo local falló."

fi


# ====== RESPALDO REMOTO ======

sshpass -p "$REMOTE_PASS" rsync -av --delete "$ORIGEN" "$REMOTE_USER@$REMOTE_IP:$DESTINO_REMOTO"

if [ $? -eq 0 ]; then

logger -t backup-script "Respaldo completo remoto finalizado correctamente."

else

logger -t backup-script "ERROR: El respaldo completo remoto falló."

fi


logger -t backup-script "Respaldo COMPLETO finalizado." 
