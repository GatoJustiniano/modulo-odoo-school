FROM python:3.11.0-slim

# Establece el directorio de trabajo
WORKDIR /opt/odoo

# Copia solo los archivos necesarios (como requirements.txt y el código fuente)
COPY ./ /opt/odoo/

# Instala dependencias del sistema necesarias para Odoo y PostgreSQL
RUN apt-get update && apt-get install -y \
    build-essential \
    libxml2-dev \
    libxslt1-dev \
    libsasl2-dev \
    libldap2-dev \
    libssl-dev \
    libjpeg62-turbo-dev \  
    liblcms2-dev \
    libblas-dev \
    libatlas-base-dev \
    libjpeg-dev \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Instala las dependencias de Python de manera global
RUN pip install --upgrade pip
RUN pip install -r /opt/odoo/requirements.txt

# Expon el puerto de Odoo (8069 por defecto)
EXPOSE 8069

# Comando para ejecutar Odoo
CMD ["python", "odoo-bin", "-c", "odoo.conf"]
