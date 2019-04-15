# docker/build/mysql/Dockerfile

FROM mysql:5.7

ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-root}

# Copy all migrations
RUN mkdir /my_migrations
COPY migrations/*.sql /my_migrations/

# Concatenate all CREATE migrations into one init file
RUN cat /my_migrations/create_database.sql >> /my_migrations/init.sql
RUN cat /my_migrations/create_tables.sql >> /my_migrations/init.sql
RUN cat /my_migrations/create_keys_and_constraints.sql >> /my_migrations/init.sql
RUN cat /my_migrations/create_procedures.sql >> /my_migrations/init.sql
RUN cat /my_migrations/create_functions.sql >> /my_migrations/init.sql
RUN cat /my_migrations/create_triggers.sql >> /my_migrations/init.sql

# Concatenate all FIXTURES migrations
RUN cat /my_migrations/fixtures_warehouse.sql >> /my_migrations/init.sql
RUN cat /my_migrations/fixtures_product.sql >> /my_migrations/init.sql
RUN cat /my_migrations/fixtures_warehouse_product.sql >> /my_migrations/init.sql
RUN cat /my_migrations/fixtures_shipments.sql >> /my_migrations/init.sql
RUN cat /my_migrations/fixtures_order_header.sql >> /my_migrations/init.sql
RUN cat /my_migrations/fixtures_order_line.sql >> /my_migrations/init.sql

RUN cp /my_migrations/init.sql /docker-entrypoint-initdb.d/my_init.sql
