CREATE DATABASE videoprokat_3nf
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Russian_Russia.1251'
    LC_CTYPE = 'Russian_Russia.1251'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

\c videoprokat_3nf


CREATE TABLE IF NOT EXISTS public."Actor"
(
    id integer NOT NULL DEFAULT nextval('"Actor_id_seq"'::regclass),
    actor_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    actor_birthday date NOT NULL,
    CONSTRAINT "Actor_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Actor"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."ActorFilm"
(
    id integer NOT NULL DEFAULT nextval('"ActorFilm_id_seq"'::regclass),
    actor_id integer NOT NULL,
    film_id integer NOT NULL,
    CONSTRAINT "ActorFilm_pkey" PRIMARY KEY (id),
    CONSTRAINT "ActorFilm_actor_id_fkey" FOREIGN KEY (actor_id)
        REFERENCES public."Actor" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "ActorFilm_film_id_fkey" FOREIGN KEY (film_id)
        REFERENCES public."Film" (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."ActorFilm"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."Client"
(
    id integer NOT NULL DEFAULT nextval('"Client_id_seq"'::regclass),
    client_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    client_address character varying(100) COLLATE pg_catalog."default" NOT NULL,
    client_phone_number character varying(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Client_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Client"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."Deal"
(
    id integer NOT NULL DEFAULT nextval('"Deal_id_seq"'::regclass),
    client_id integer NOT NULL,
    cassette_id integer NOT NULL,
    deal_price integer NOT NULL,
    deal_date date NOT NULL,
    deal_return date NOT NULL,
    CONSTRAINT "Deal_pkey" PRIMARY KEY (id),
    CONSTRAINT "Deal_cassette_id_fkey" FOREIGN KEY (cassette_id)
        REFERENCES public."Сassette" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Deal_client_id_fkey" FOREIGN KEY (client_id)
        REFERENCES public."Client" (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Deal"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."Film"
(
    id integer NOT NULL DEFAULT nextval('"Film_id_seq"'::regclass),
    genre_id integer NOT NULL,
    film_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    film_rental_start date NOT NULL,
    film_duration integer NOT NULL,
    film_description character varying(200) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Film_pkey" PRIMARY KEY (id),
    CONSTRAINT "Film_genre_id_fkey" FOREIGN KEY (genre_id)
        REFERENCES public."Genre" (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Film"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."Genre"
(
    id integer NOT NULL DEFAULT nextval('"Genre_id_seq"'::regclass),
    genre_name character varying(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Genre_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Genre"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."Сassette"
(
    id integer NOT NULL DEFAULT nextval('"Сassette_id_seq"'::regclass),
    film_id integer NOT NULL,
    cassette_production_date date NOT NULL,
    cassette_company character varying(50) COLLATE pg_catalog."default" NOT NULL,
    "Hi-Fi" boolean NOT NULL,
    CONSTRAINT "Сassette_pkey" PRIMARY KEY (id),
    CONSTRAINT "Сassette_film_id_fkey" FOREIGN KEY (film_id)
        REFERENCES public."Film" (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Сassette"
    OWNER to postgres;
