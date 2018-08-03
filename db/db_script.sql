--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4 (Ubuntu 10.4-2.pgdg16.04+1)
-- Dumped by pg_dump version 10.3

-- Started on 2018-07-22 18:22:49

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2943 (class 1262 OID 16384)
-- Name: automan_development; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE automan_development WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'es_EC.UTF-8' LC_CTYPE = 'es_EC.UTF-8';


\connect automan_development

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 13007)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2945 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_with_oids = false;

--
-- TOC entry 197 (class 1259 OID 16394)
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- TOC entry 203 (class 1259 OID 32781)
-- Name: cars; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cars (
    id bigint NOT NULL,
    plate character varying,
    brand character varying,
    model character varying,
    current_km numeric,
    car_type character varying,
    week_km numeric,
    owner_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    year integer
);


--
-- TOC entry 202 (class 1259 OID 32779)
-- Name: cars_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2946 (class 0 OID 0)
-- Dependencies: 202
-- Name: cars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cars_id_seq OWNED BY public.cars.id;


--
-- TOC entry 207 (class 1259 OID 32815)
-- Name: cost_details; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cost_details (
    id bigint NOT NULL,
    cost_type character varying,
    cost numeric,
    provider text,
    maintenance_history_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- TOC entry 206 (class 1259 OID 32813)
-- Name: cost_details_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cost_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2947 (class 0 OID 0)
-- Dependencies: 206
-- Name: cost_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cost_details_id_seq OWNED BY public.cost_details.id;


--
-- TOC entry 205 (class 1259 OID 32798)
-- Name: maintenance_histories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.maintenance_histories (
    id bigint NOT NULL,
    status character varying,
    estimated_km numeric,
    scheduled_date timestamp without time zone,
    review_km numeric,
    review_date timestamp without time zone,
    provider text,
    cost numeric,
    notified boolean,
    car_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- TOC entry 204 (class 1259 OID 32796)
-- Name: maintenance_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.maintenance_histories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2948 (class 0 OID 0)
-- Dependencies: 204
-- Name: maintenance_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.maintenance_histories_id_seq OWNED BY public.maintenance_histories.id;


--
-- TOC entry 201 (class 1259 OID 32770)
-- Name: owners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.owners (
    id bigint NOT NULL,
    name character varying,
    last_name character varying,
    cel_phone character varying,
    agreement_terms boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- TOC entry 200 (class 1259 OID 32768)
-- Name: owners_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.owners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2949 (class 0 OID 0)
-- Dependencies: 200
-- Name: owners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.owners_id_seq OWNED BY public.owners.id;


--
-- TOC entry 196 (class 1259 OID 16386)
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- TOC entry 199 (class 1259 OID 16404)
-- Name: settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.settings (
    id bigint NOT NULL,
    car_age integer,
    km_max integer,
    km_min integer,
    month_max integer,
    month_min integer,
    car_type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- TOC entry 198 (class 1259 OID 16402)
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2950 (class 0 OID 0)
-- Dependencies: 198
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.settings_id_seq OWNED BY public.settings.id;


--
-- TOC entry 2794 (class 2604 OID 32784)
-- Name: cars id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cars ALTER COLUMN id SET DEFAULT nextval('public.cars_id_seq'::regclass);


--
-- TOC entry 2796 (class 2604 OID 32818)
-- Name: cost_details id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cost_details ALTER COLUMN id SET DEFAULT nextval('public.cost_details_id_seq'::regclass);


--
-- TOC entry 2795 (class 2604 OID 32801)
-- Name: maintenance_histories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.maintenance_histories ALTER COLUMN id SET DEFAULT nextval('public.maintenance_histories_id_seq'::regclass);


--
-- TOC entry 2793 (class 2604 OID 32773)
-- Name: owners id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.owners ALTER COLUMN id SET DEFAULT nextval('public.owners_id_seq'::regclass);


--
-- TOC entry 2792 (class 2604 OID 16407)
-- Name: settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings ALTER COLUMN id SET DEFAULT nextval('public.settings_id_seq'::regclass);


--
-- TOC entry 2800 (class 2606 OID 16401)
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- TOC entry 2806 (class 2606 OID 32789)
-- Name: cars cars_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_pkey PRIMARY KEY (id);


--
-- TOC entry 2812 (class 2606 OID 32823)
-- Name: cost_details cost_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cost_details
    ADD CONSTRAINT cost_details_pkey PRIMARY KEY (id);


--
-- TOC entry 2810 (class 2606 OID 32806)
-- Name: maintenance_histories maintenance_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.maintenance_histories
    ADD CONSTRAINT maintenance_histories_pkey PRIMARY KEY (id);


--
-- TOC entry 2804 (class 2606 OID 32778)
-- Name: owners owners_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.owners
    ADD CONSTRAINT owners_pkey PRIMARY KEY (id);


--
-- TOC entry 2798 (class 2606 OID 16393)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 2802 (class 2606 OID 16412)
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- TOC entry 2807 (class 1259 OID 32795)
-- Name: index_cars_on_owner_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cars_on_owner_id ON public.cars USING btree (owner_id);


--
-- TOC entry 2813 (class 1259 OID 32829)
-- Name: index_cost_details_on_maintenance_history_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cost_details_on_maintenance_history_id ON public.cost_details USING btree (maintenance_history_id);


--
-- TOC entry 2808 (class 1259 OID 32812)
-- Name: index_maintenance_histories_on_car_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_maintenance_histories_on_car_id ON public.maintenance_histories USING btree (car_id);


--
-- TOC entry 2815 (class 2606 OID 32807)
-- Name: maintenance_histories fk_rails_1899dd3d39; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.maintenance_histories
    ADD CONSTRAINT fk_rails_1899dd3d39 FOREIGN KEY (car_id) REFERENCES public.cars(id);


--
-- TOC entry 2814 (class 2606 OID 32790)
-- Name: cars fk_rails_41e03c1fe5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT fk_rails_41e03c1fe5 FOREIGN KEY (owner_id) REFERENCES public.owners(id);


--
-- TOC entry 2816 (class 2606 OID 32824)
-- Name: cost_details fk_rails_83dbb1388d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cost_details
    ADD CONSTRAINT fk_rails_83dbb1388d FOREIGN KEY (maintenance_history_id) REFERENCES public.maintenance_histories(id);


-- Completed on 2018-07-22 18:22:51

--
-- PostgreSQL database dump complete
--












CREATE OR REPLACE FUNCTION public.tg_kilometraje_semanal()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  DECLARE delta_horas numeric;
  DECLARE delta_km numeric;
  DECLARE km_semanal numeric;
  DECLARE nuevo_update Timestamp Without Time Zone;
  DECLARE antiguo_update Timestamp Without Time Zone;
  DECLARE nuevo_km_actual numeric;
  DECLARE antiguo_km_actual numeric;
BEGIN
  nuevo_update = NEW.updated_at;
  antiguo_update = OLD.updated_at;
  nuevo_km_actual = NEW.current_km;
  antiguo_km_actual = OLD.current_km;
  SELECT EXTRACT(EPOCH FROM nuevo_update-antiguo_update)/3600 INTO delta_horas;
  delta_km = nuevo_km_actual - antiguo_km_actual;
  if (delta_horas > 0) && (NEW.current_km != OLD.current_km) then
    km_semanal = (delta_km/delta_horas)*168;
    update cars set week_km = km_semanal where id = OLD.id;
  end if;
  return NEW;
END
$function$





CREATE TRIGGER "procesarCambiosKmActual" AFTER UPDATE ON public.cars FOR EACH ROW EXECUTE PROCEDURE tg_kilometraje_semanal()