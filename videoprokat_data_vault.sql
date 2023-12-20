CREATE DATABASE videoprokat_data_vault
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Russian_Russia.1251'
    LC_CTYPE = 'Russian_Russia.1251'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

\c videoprokat_data_vault
	
CREATE TABLE IF NOT EXISTS public."HUB_Actor"
(
    id integer NOT NULL DEFAULT nextval('"HUB_Actor_id_seq"'::regclass),
    actor_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    "LOAD_DATE" date NOT NULL,
    "RECORD_SOURCE" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "HUB_Actor_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."HUB_Actor"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."HUB_Cassette"
(
    id integer NOT NULL DEFAULT nextval('"HUB_Cassette_id_seq"'::regclass),
    cassette_production_date date NOT NULL,
    "LOAD_DATE" date NOT NULL,
    "RECORD_SOURCE" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "HUB_Cassette_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."HUB_Cassette"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."HUB_Client"
(
    id integer NOT NULL DEFAULT nextval('"HUB_Client_id_seq"'::regclass),
    client_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    "LOAD_DATE" date NOT NULL,
    "RECORD_SOURCE" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "HUB_Client_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."HUB_Client"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."HUB_Film"
(
    id integer NOT NULL DEFAULT nextval('"HUB_Film_id_seq"'::regclass),
    film_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    "LOAD_DATE" date NOT NULL,
    "RECORD_SOURCE" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "HUB_Film_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."HUB_Film"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."LNK_Deal"
(
    "Cassette_id" integer NOT NULL DEFAULT nextval('"LNK_Deal_Cassette_id_seq"'::regclass),
    "Client_id" integer NOT NULL,
    "LOAD_DATE" date NOT NULL,
    "RECORD_SOURCE" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "LNK_Deal_pkey" PRIMARY KEY ("Cassette_id"),
    CONSTRAINT "LNK_Deal_Client_id_fkey" FOREIGN KEY ("Client_id")
        REFERENCES public."HUB_Client" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."LNK_Deal"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."LNK_Film"
(
    "Film_id" integer NOT NULL DEFAULT nextval('"LNK_Film_Film_id_seq"'::regclass),
    "Cassette_id" integer NOT NULL,
    "Actor_id" integer NOT NULL,
    "LOAD_DATE" date NOT NULL,
    "RECORD_SOURCE" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "LNK_Film_pkey" PRIMARY KEY ("Film_id"),
    CONSTRAINT "LNK_Film_Actor_id_fkey" FOREIGN KEY ("Actor_id")
        REFERENCES public."HUB_Actor" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "LNK_Film_Cassette_id_fkey" FOREIGN KEY ("Cassette_id")
        REFERENCES public."HUB_Cassette" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."LNK_Film"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."SAT_Actor"
(
    id integer NOT NULL DEFAULT nextval('"SAT_Actor_id_seq"'::regclass),
    "LOAD_DATE" date NOT NULL,
    actor_birthday date NOT NULL,
    "RECORD_SOURCE" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "SAT_Actor_pkey" PRIMARY KEY (id, "LOAD_DATE")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."SAT_Actor"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."SAT_Cassette"
(
    id integer NOT NULL DEFAULT nextval('"SAT_Cassette_id_seq"'::regclass),
    "LOAD_DATE" date NOT NULL,
    cassette_company character varying(50) COLLATE pg_catalog."default" NOT NULL,
    "Hi-Fi" boolean NOT NULL,
    "RECORD_SOURCE" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "SAT_Cassette_pkey" PRIMARY KEY (id, "LOAD_DATE")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."SAT_Cassette"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."SAT_Client"
(
    id integer NOT NULL DEFAULT nextval('"SAT_Client_id_seq"'::regclass),
    "LOAD_DATE" date NOT NULL,
    "Client_address" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    "Client_phone_number" character varying(20) COLLATE pg_catalog."default" NOT NULL,
    "RECORD_SOURCE" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "SAT_Client_pkey" PRIMARY KEY (id, "LOAD_DATE")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."SAT_Client"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."SAT_Film"
(
    id integer NOT NULL DEFAULT nextval('"SAT_Film_id_seq"'::regclass),
    "LOAD_DATE" date NOT NULL,
    film_rental_start date NOT NULL,
    film_duration integer NOT NULL,
    film_description character varying(200) COLLATE pg_catalog."default" NOT NULL,
    genre_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    "RECORD_SOURCE" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "SAT_Film_pkey" PRIMARY KEY (id, "LOAD_DATE")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."SAT_Film"
    OWNER to postgres;
