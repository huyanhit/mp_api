--
-- PostgreSQL database dump
--

-- Dumped from database version 11.21
-- Dumped by pg_dump version 15.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: activity_log; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.activity_log (
    id bigint NOT NULL,
    log_name character varying(255),
    event character varying(255),
    description text NOT NULL,
    subject_type character varying(255),
    subject_id bigint,
    causer_type character varying(255),
    causer_id bigint,
    properties json,
    batch_uuid uuid,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.activity_log OWNER TO tg_retrieval;

--
-- Name: activity_log_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.activity_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activity_log_id_seq OWNER TO tg_retrieval;

--
-- Name: activity_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.activity_log_id_seq OWNED BY public.activity_log.id;


--
-- Name: cache; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO tg_retrieval;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO tg_retrieval;

--
-- Name: chat_contacts; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.chat_contacts (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    contact_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.chat_contacts OWNER TO tg_retrieval;

--
-- Name: chat_contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.chat_contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_contacts_id_seq OWNER TO tg_retrieval;

--
-- Name: chat_contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.chat_contacts_id_seq OWNED BY public.chat_contacts.id;


--
-- Name: chat_files; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.chat_files (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    ext character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    path character varying(255) NOT NULL,
    store character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.chat_files OWNER TO tg_retrieval;

--
-- Name: chat_files_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.chat_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_files_id_seq OWNER TO tg_retrieval;

--
-- Name: chat_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.chat_files_id_seq OWNED BY public.chat_files.id;


--
-- Name: chat_message_file; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.chat_message_file (
    id bigint NOT NULL,
    message_id integer NOT NULL,
    file_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.chat_message_file OWNER TO tg_retrieval;

--
-- Name: chat_message_file_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.chat_message_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_message_file_id_seq OWNER TO tg_retrieval;

--
-- Name: chat_message_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.chat_message_file_id_seq OWNED BY public.chat_message_file.id;


--
-- Name: chat_messages; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.chat_messages (
    ids integer NOT NULL,
    id integer DEFAULT 0 NOT NULL,
    content text,
    room_id integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    auth integer DEFAULT 0 NOT NULL,
    thread integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.chat_messages OWNER TO tg_retrieval;

--
-- Name: chat_messages_ids_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.chat_messages_ids_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_messages_ids_seq OWNER TO tg_retrieval;

--
-- Name: chat_messages_ids_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.chat_messages_ids_seq OWNED BY public.chat_messages.ids;


--
-- Name: chat_module_room; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.chat_module_room (
    id bigint NOT NULL,
    module character varying(255) NOT NULL,
    object_id integer NOT NULL,
    room_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.chat_module_room OWNER TO tg_retrieval;

--
-- Name: chat_module_room_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.chat_module_room_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_module_room_id_seq OWNER TO tg_retrieval;

--
-- Name: chat_module_room_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.chat_module_room_id_seq OWNED BY public.chat_module_room.id;


--
-- Name: chat_room_file; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.chat_room_file (
    id bigint NOT NULL,
    room_id integer NOT NULL,
    file_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.chat_room_file OWNER TO tg_retrieval;

--
-- Name: chat_room_file_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.chat_room_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_room_file_id_seq OWNER TO tg_retrieval;

--
-- Name: chat_room_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.chat_room_file_id_seq OWNED BY public.chat_room_file.id;


--
-- Name: chat_rooms; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.chat_rooms (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    icon character varying(255),
    type integer DEFAULT 1 NOT NULL,
    pin integer DEFAULT 0 NOT NULL,
    total integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.chat_rooms OWNER TO tg_retrieval;

--
-- Name: chat_rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.chat_rooms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_rooms_id_seq OWNER TO tg_retrieval;

--
-- Name: chat_rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.chat_rooms_id_seq OWNED BY public.chat_rooms.id;


--
-- Name: chat_user_file; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.chat_user_file (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    file_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.chat_user_file OWNER TO tg_retrieval;

--
-- Name: chat_user_file_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.chat_user_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_user_file_id_seq OWNER TO tg_retrieval;

--
-- Name: chat_user_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.chat_user_file_id_seq OWNED BY public.chat_user_file.id;


--
-- Name: chat_user_room; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.chat_user_room (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    room_id integer NOT NULL,
    type integer DEFAULT 1 NOT NULL,
    "position" integer DEFAULT 0 NOT NULL,
    mention integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.chat_user_room OWNER TO tg_retrieval;

--
-- Name: chat_user_room_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.chat_user_room_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_user_room_id_seq OWNER TO tg_retrieval;

--
-- Name: chat_user_room_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.chat_user_room_id_seq OWNED BY public.chat_user_room.id;


--
-- Name: department_business; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.department_business (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.department_business OWNER TO tg_retrieval;

--
-- Name: department_business_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.department_business_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.department_business_id_seq OWNER TO tg_retrieval;

--
-- Name: department_business_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.department_business_id_seq OWNED BY public.department_business.id;


--
-- Name: department_types; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.department_types (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.department_types OWNER TO tg_retrieval;

--
-- Name: department_types_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.department_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.department_types_id_seq OWNER TO tg_retrieval;

--
-- Name: department_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.department_types_id_seq OWNED BY public.department_types.id;


--
-- Name: departments; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.departments (
    id bigint NOT NULL,
    role character varying(255) NOT NULL,
    code character varying(255),
    name character varying(255) NOT NULL,
    tax character varying(255),
    parent_id integer DEFAULT 0 NOT NULL,
    date_of_incorporation date,
    address character varying(255),
    place_of_address character varying(255),
    office_address character varying(255),
    office_place_of_address character varying(255),
    business_department_id integer DEFAULT 0 NOT NULL,
    type_department_id integer DEFAULT 0 NOT NULL,
    description text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    CONSTRAINT departments_role_check CHECK (((role)::text = ANY ((ARRAY['company'::character varying, 'branch'::character varying, 'department'::character varying])::text[])))
);


ALTER TABLE public.departments OWNER TO tg_retrieval;

--
-- Name: departments_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.departments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.departments_id_seq OWNER TO tg_retrieval;

--
-- Name: departments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.departments_id_seq OWNED BY public.departments.id;


--
-- Name: documents; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.documents (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    hash_name character varying(255) NOT NULL,
    user_id bigint,
    original_version_id bigint,
    type character varying(255) NOT NULL,
    mime_type character varying(255),
    left_value integer NOT NULL,
    right_value integer NOT NULL,
    path character varying(255),
    extension character varying(255),
    capacity double precision,
    version smallint DEFAULT '0'::smallint NOT NULL,
    token_share character varying(255),
    token_share_expired timestamp(0) without time zone,
    thumbnail_url character varying(255),
    description character varying(255),
    owner_id bigint,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.documents OWNER TO tg_retrieval;

--
-- Name: COLUMN documents.type; Type: COMMENT; Schema: public; Owner: tg_retrieval
--

COMMENT ON COLUMN public.documents.type IS 'folder, file';


--
-- Name: documents_attachs; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.documents_attachs (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    hash_name character varying(255),
    document_module_id bigint NOT NULL,
    type character varying(255) NOT NULL,
    mime_type character varying(255),
    left_value integer NOT NULL,
    right_value integer NOT NULL,
    extension character varying(255),
    capacity double precision,
    document_attachable_id bigint NOT NULL,
    document_attachable_type character varying(255) NOT NULL,
    thumbnail_url character varying(255),
    path text,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.documents_attachs OWNER TO tg_retrieval;

--
-- Name: COLUMN documents_attachs.type; Type: COMMENT; Schema: public; Owner: tg_retrieval
--

COMMENT ON COLUMN public.documents_attachs.type IS 'folder, file';


--
-- Name: documents_attachs_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.documents_attachs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documents_attachs_id_seq OWNER TO tg_retrieval;

--
-- Name: documents_attachs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.documents_attachs_id_seq OWNED BY public.documents_attachs.id;


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documents_id_seq OWNER TO tg_retrieval;

--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.documents_id_seq OWNED BY public.documents.id;


--
-- Name: documents_modules_attachs; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.documents_modules_attachs (
    id bigint NOT NULL,
    module character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.documents_modules_attachs OWNER TO tg_retrieval;

--
-- Name: documents_modules_attachs_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.documents_modules_attachs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documents_modules_attachs_id_seq OWNER TO tg_retrieval;

--
-- Name: documents_modules_attachs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.documents_modules_attachs_id_seq OWNED BY public.documents_modules_attachs.id;


--
-- Name: documents_recents; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.documents_recents (
    id bigint NOT NULL,
    document_id bigint NOT NULL,
    user_id bigint NOT NULL,
    view_at timestamp(0) without time zone NOT NULL,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.documents_recents OWNER TO tg_retrieval;

--
-- Name: documents_recents_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.documents_recents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documents_recents_id_seq OWNER TO tg_retrieval;

--
-- Name: documents_recents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.documents_recents_id_seq OWNED BY public.documents_recents.id;


--
-- Name: documents_shares; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.documents_shares (
    id bigint NOT NULL,
    document_id bigint NOT NULL,
    user_id bigint NOT NULL,
    permission character varying(255) NOT NULL,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.documents_shares OWNER TO tg_retrieval;

--
-- Name: documents_shares_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.documents_shares_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documents_shares_id_seq OWNER TO tg_retrieval;

--
-- Name: documents_shares_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.documents_shares_id_seq OWNED BY public.documents_shares.id;


--
-- Name: employee_history_setting; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.employee_history_setting (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    object_history character varying(255) NOT NULL,
    icon character varying(255) NOT NULL,
    is_active boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.employee_history_setting OWNER TO tg_retrieval;

--
-- Name: employee_history_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.employee_history_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_history_setting_id_seq OWNER TO tg_retrieval;

--
-- Name: employee_history_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.employee_history_setting_id_seq OWNED BY public.employee_history_setting.id;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO tg_retrieval;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.failed_jobs_id_seq OWNER TO tg_retrieval;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: hrm_allowance_settings; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_allowance_settings (
    id bigint NOT NULL,
    allowance_name character varying(255) NOT NULL,
    allowance_amount double precision NOT NULL,
    is_tax boolean,
    unit character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT hrm_allowance_settings_unit_check CHECK (((unit)::text = ANY ((ARRAY['date'::character varying, 'month'::character varying, 'year'::character varying])::text[])))
);


ALTER TABLE public.hrm_allowance_settings OWNER TO tg_retrieval;

--
-- Name: hrm_allowance_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_allowance_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_allowance_settings_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_allowance_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_allowance_settings_id_seq OWNED BY public.hrm_allowance_settings.id;


--
-- Name: hrm_allowance_type_contracts; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_allowance_type_contracts (
    id bigint NOT NULL,
    type_contract_id integer NOT NULL,
    allowance_id integer NOT NULL,
    allowance_amount double precision NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.hrm_allowance_type_contracts OWNER TO tg_retrieval;

--
-- Name: hrm_allowance_type_contracts_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_allowance_type_contracts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_allowance_type_contracts_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_allowance_type_contracts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_allowance_type_contracts_id_seq OWNED BY public.hrm_allowance_type_contracts.id;


--
-- Name: hrm_allowance_types; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_allowance_types (
    id bigint NOT NULL,
    allowance_name character varying(255) NOT NULL,
    allowance_amount double precision NOT NULL,
    is_tax boolean,
    unit character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.hrm_allowance_types OWNER TO tg_retrieval;

--
-- Name: hrm_allowance_types_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_allowance_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_allowance_types_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_allowance_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_allowance_types_id_seq OWNED BY public.hrm_allowance_types.id;


--
-- Name: hrm_allowances; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_allowances (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    amount double precision NOT NULL,
    is_tax boolean,
    unit character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_allowances OWNER TO tg_retrieval;

--
-- Name: hrm_allowances_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_allowances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_allowances_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_allowances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_allowances_id_seq OWNED BY public.hrm_allowances.id;


--
-- Name: hrm_banks; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_banks (
    id bigint NOT NULL,
    bank_name character varying(255) NOT NULL,
    bank_code character varying(255) NOT NULL,
    bank_address character varying(255),
    bank_branch character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_banks OWNER TO tg_retrieval;

--
-- Name: hrm_banks_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_banks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_banks_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_banks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_banks_id_seq OWNED BY public.hrm_banks.id;


--
-- Name: hrm_decision_answers; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_decision_answers (
    id bigint NOT NULL,
    type_id integer NOT NULL,
    question_id integer NOT NULL,
    decision_number character varying(255) NOT NULL,
    decision_date character varying(255) NOT NULL,
    department_id integer NOT NULL,
    censor_ids integer NOT NULL,
    status integer NOT NULL,
    answers json,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_decision_answers OWNER TO tg_retrieval;

--
-- Name: hrm_decision_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_decision_answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_decision_answers_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_decision_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_decision_answers_id_seq OWNED BY public.hrm_decision_answers.id;


--
-- Name: hrm_decision_questions; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_decision_questions (
    id bigint NOT NULL,
    type_id integer NOT NULL,
    decision_number character varying(255) NOT NULL,
    decision_date character varying(255) NOT NULL,
    department_id integer NOT NULL,
    questions json NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_decision_questions OWNER TO tg_retrieval;

--
-- Name: hrm_decision_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_decision_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_decision_questions_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_decision_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_decision_questions_id_seq OWNED BY public.hrm_decision_questions.id;


--
-- Name: hrm_employee_allowances; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_employee_allowances (
    id bigint NOT NULL,
    contract_id integer NOT NULL,
    from_date date,
    notes character varying(255),
    salary_method_id integer DEFAULT 0 NOT NULL,
    salary_money integer DEFAULT 0 NOT NULL,
    salary_amount integer DEFAULT 0 NOT NULL,
    allow_id integer DEFAULT 0 NOT NULL,
    allow_money integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_employee_allowances OWNER TO tg_retrieval;

--
-- Name: hrm_employee_allowances_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_employee_allowances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_employee_allowances_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_employee_allowances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_employee_allowances_id_seq OWNED BY public.hrm_employee_allowances.id;


--
-- Name: hrm_employee_banks; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_employee_banks (
    id bigint NOT NULL,
    employee_id smallint NOT NULL,
    account_number character varying(255),
    account_name character varying(255) NOT NULL,
    bank_id integer NOT NULL,
    bank_branch character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_employee_banks OWNER TO tg_retrieval;

--
-- Name: hrm_employee_banks_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_employee_banks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_employee_banks_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_employee_banks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_employee_banks_id_seq OWNED BY public.hrm_employee_banks.id;


--
-- Name: hrm_employee_certificates; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_employee_certificates (
    id bigint NOT NULL,
    employee_id integer NOT NULL,
    type_certificate_id integer NOT NULL,
    document_level_id integer NOT NULL,
    version character varying(255),
    count_released integer,
    date_apply date NOT NULL,
    date_end date,
    attachments character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_employee_certificates OWNER TO tg_retrieval;

--
-- Name: hrm_employee_certificates_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_employee_certificates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_employee_certificates_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_employee_certificates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_employee_certificates_id_seq OWNED BY public.hrm_employee_certificates.id;


--
-- Name: hrm_employee_concurrents; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_employee_concurrents (
    id bigint NOT NULL,
    employee_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date,
    department_id integer NOT NULL,
    position_id integer NOT NULL,
    position_title_id integer NOT NULL,
    role_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_employee_concurrents OWNER TO tg_retrieval;

--
-- Name: hrm_employee_concurrents_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_employee_concurrents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_employee_concurrents_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_employee_concurrents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_employee_concurrents_id_seq OWNED BY public.hrm_employee_concurrents.id;


--
-- Name: hrm_employee_contacts; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_employee_contacts (
    id bigint NOT NULL,
    employee_id integer NOT NULL,
    personal_phone character varying(255) NOT NULL,
    office_phone character varying(255),
    home_phone character varying(255),
    orther_phone character varying(255),
    personal_email character varying(255) NOT NULL,
    office_email character varying(255),
    orther_email character varying(255),
    skype_link character varying(255),
    facebook_link character varying(255),
    twitter_link character varying(255),
    permanent_nation character varying(255),
    permanent_province character varying(255),
    permanent_district character varying(255),
    permanent_ward character varying(255),
    permanent_address character varying(255),
    household_number character varying(255),
    household_code character varying(255),
    is_householder character varying(255),
    temporary_nation character varying(255),
    temporary_province character varying(255),
    temporary_district character varying(255),
    temporary_ward character varying(255),
    temporary_address character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_employee_contacts OWNER TO tg_retrieval;

--
-- Name: hrm_employee_contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_employee_contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_employee_contacts_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_employee_contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_employee_contacts_id_seq OWNED BY public.hrm_employee_contacts.id;


--
-- Name: hrm_employee_contract_allowances; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_employee_contract_allowances (
    id bigint NOT NULL,
    contract_id integer NOT NULL,
    from_date date,
    notes character varying(255),
    salary_method_id integer DEFAULT 0 NOT NULL,
    salary_money integer DEFAULT 0 NOT NULL,
    salary_amount integer DEFAULT 0 NOT NULL,
    allow_id integer DEFAULT 0 NOT NULL,
    allow_money integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_employee_contract_allowances OWNER TO tg_retrieval;

--
-- Name: hrm_employee_contract_allowances_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_employee_contract_allowances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_employee_contract_allowances_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_employee_contract_allowances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_employee_contract_allowances_id_seq OWNED BY public.hrm_employee_contract_allowances.id;


--
-- Name: hrm_employee_contracts; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_employee_contracts (
    id bigint NOT NULL,
    employee_id integer DEFAULT 0 NOT NULL,
    company_id integer DEFAULT 0 NOT NULL,
    contract_number character varying(255) NOT NULL,
    contract_name character varying(255) NOT NULL,
    contract_duration date NOT NULL,
    effective_date date NOT NULL,
    salary integer DEFAULT 0 NOT NULL,
    salary_percent integer DEFAULT 0 NOT NULL,
    position_id integer NOT NULL,
    status smallint DEFAULT '0'::smallint NOT NULL,
    type_contract_id integer NOT NULL,
    sign_date character varying(255) NOT NULL,
    form_work date NOT NULL,
    expiry_date date NOT NULL,
    insurance_salary integer NOT NULL,
    signed_by character varying(255) NOT NULL,
    file_link character varying(255) NOT NULL,
    notes text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_employee_contracts OWNER TO tg_retrieval;

--
-- Name: hrm_employee_contracts_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_employee_contracts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_employee_contracts_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_employee_contracts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_employee_contracts_id_seq OWNED BY public.hrm_employee_contracts.id;


--
-- Name: hrm_employee_dependents; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_employee_dependents (
    id bigint NOT NULL,
    employee_id integer NOT NULL,
    relative_id integer DEFAULT 0 NOT NULL,
    fullname character varying(255) NOT NULL,
    birthday date NOT NULL,
    telephone character varying(255) NOT NULL,
    id_number integer NOT NULL,
    id_issue_date date NOT NULL,
    id_issue_place character varying(255) NOT NULL,
    is_dependent smallint DEFAULT '0'::smallint NOT NULL,
    date_from date,
    date_to date,
    tax_code character varying(255),
    note text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_employee_dependents OWNER TO tg_retrieval;

--
-- Name: hrm_employee_dependents_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_employee_dependents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_employee_dependents_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_employee_dependents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_employee_dependents_id_seq OWNED BY public.hrm_employee_dependents.id;


--
-- Name: hrm_employee_history_setting; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_employee_history_setting (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    object_history character varying(255) NOT NULL,
    icon character varying(255) NOT NULL,
    is_active boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_employee_history_setting OWNER TO tg_retrieval;

--
-- Name: hrm_employee_history_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_employee_history_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_employee_history_setting_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_employee_history_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_employee_history_setting_id_seq OWNED BY public.hrm_employee_history_setting.id;


--
-- Name: hrm_employee_informations; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_employee_informations (
    id bigint NOT NULL,
    user_id integer,
    employee_code character varying(255) NOT NULL,
    attendance_code character varying(255),
    profile_code character varying(255),
    fullname character varying(255) NOT NULL,
    birthday date NOT NULL,
    gender character varying(255) DEFAULT 'undefined'::character varying NOT NULL,
    military_service integer DEFAULT 0 NOT NULL,
    birthplace integer NOT NULL,
    hometown integer,
    id_number character varying(255) NOT NULL,
    id_issue_date date NOT NULL,
    id_issue_place integer NOT NULL,
    id_front_image character varying(255),
    id_back_image character varying(255),
    avatar character varying(255),
    nation integer,
    marital_status smallint,
    ethnic integer NOT NULL,
    religion integer,
    tax_code character varying(255),
    tax_issue_date date,
    tax_issue_place character varying(255),
    sync_code character varying(255),
    start_date date,
    date_to date,
    job_reldate_join date,
    level_school integer DEFAULT 0 NOT NULL,
    specialization integer DEFAULT 0 NOT NULL,
    level_academic integer DEFAULT 0 NOT NULL,
    insurance_number character varying(255),
    passport_number character varying(255),
    passport_issue_date date,
    passport_issue_place character varying(255),
    passport_expiry_date date,
    company_id integer DEFAULT 0 NOT NULL,
    department_id integer DEFAULT 0 NOT NULL,
    direct_management_id integer DEFAULT 0 NOT NULL,
    status character varying(255) DEFAULT 'working'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    CONSTRAINT hrm_employee_informations_gender_check CHECK (((gender)::text = ANY ((ARRAY['male'::character varying, 'female'::character varying, 'other'::character varying, 'undefined'::character varying])::text[]))),
    CONSTRAINT hrm_employee_informations_status_check CHECK (((status)::text = ANY ((ARRAY['waitting'::character varying, 'working'::character varying, '0'::character varying, 'leaving'::character varying, 'leave_unpaid'::character varying, 'leave_army'::character varying, 'leave_study'::character varying, 'stop_working'::character varying])::text[])))
);


ALTER TABLE public.hrm_employee_informations OWNER TO tg_retrieval;

--
-- Name: hrm_employee_informations_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_employee_informations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_employee_informations_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_employee_informations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_employee_informations_id_seq OWNED BY public.hrm_employee_informations.id;


--
-- Name: hrm_employee_insurance_payment_histories; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_employee_insurance_payment_histories (
    id bigint NOT NULL,
    insurance_id integer NOT NULL,
    month date NOT NULL,
    payment_method character varying(255) DEFAULT 'undefined'::character varying NOT NULL,
    reason character varying(255),
    company_id integer NOT NULL,
    "insurance premium_base" integer NOT NULL,
    "insurance premium_compnay" integer NOT NULL,
    "insurance premium_employee" integer NOT NULL,
    notes text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    CONSTRAINT hrm_employee_insurance_payment_histories_payment_method_check CHECK (((payment_method)::text = ANY ((ARRAY['increase'::character varying, 'decrease'::character varying])::text[])))
);


ALTER TABLE public.hrm_employee_insurance_payment_histories OWNER TO tg_retrieval;

--
-- Name: hrm_employee_insurance_payment_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_employee_insurance_payment_histories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_employee_insurance_payment_histories_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_employee_insurance_payment_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_employee_insurance_payment_histories_id_seq OWNED BY public.hrm_employee_insurance_payment_histories.id;


--
-- Name: hrm_employee_insurance_payments; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_employee_insurance_payments (
    id bigint NOT NULL,
    employee_id integer NOT NULL,
    insurance_id integer NOT NULL,
    month date NOT NULL,
    payment_method character varying(255) DEFAULT 'undefined'::character varying NOT NULL,
    reason character varying(255),
    company_id integer NOT NULL,
    "insurance premium_base" integer NOT NULL,
    "insurance premium_compnay" integer NOT NULL,
    "insurance premium_employee" integer NOT NULL,
    notes text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    CONSTRAINT hrm_employee_insurance_payments_payment_method_check CHECK (((payment_method)::text = ANY ((ARRAY['increase'::character varying, 'decrease'::character varying])::text[])))
);


ALTER TABLE public.hrm_employee_insurance_payments OWNER TO tg_retrieval;

--
-- Name: hrm_employee_insurance_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_employee_insurance_payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_employee_insurance_payments_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_employee_insurance_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_employee_insurance_payments_id_seq OWNED BY public.hrm_employee_insurance_payments.id;


--
-- Name: hrm_employee_insurance_resolves; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_employee_insurance_resolves (
    id bigint NOT NULL,
    employee_id integer NOT NULL,
    insurance_id integer NOT NULL,
    date_of_receipt date NOT NULL,
    date_complete_procedure date NOT NULL,
    date_get_money date NOT NULL,
    date_payment date NOT NULL,
    money_received integer NOT NULL,
    notes text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_employee_insurance_resolves OWNER TO tg_retrieval;

--
-- Name: hrm_employee_insurance_resolves_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_employee_insurance_resolves_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_employee_insurance_resolves_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_employee_insurance_resolves_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_employee_insurance_resolves_id_seq OWNED BY public.hrm_employee_insurance_resolves.id;


--
-- Name: hrm_employee_insurances; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_employee_insurances (
    id bigint NOT NULL,
    employee_id integer DEFAULT 0 NOT NULL,
    insurance_provider character varying(255) NOT NULL,
    policy_number character varying(255) NOT NULL,
    coverage_type character varying(255) NOT NULL,
    amout integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    province_code character varying(255) NOT NULL,
    hospital_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_employee_insurances OWNER TO tg_retrieval;

--
-- Name: hrm_employee_insurances_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_employee_insurances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_employee_insurances_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_employee_insurances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_employee_insurances_id_seq OWNED BY public.hrm_employee_insurances.id;


--
-- Name: hrm_employee_job_history; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_employee_job_history (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    object_history character varying(255) NOT NULL,
    icon character varying(255) NOT NULL,
    is_active boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_employee_job_history OWNER TO tg_retrieval;

--
-- Name: hrm_employee_job_history_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_employee_job_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_employee_job_history_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_employee_job_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_employee_job_history_id_seq OWNED BY public.hrm_employee_job_history.id;


--
-- Name: hrm_employee_layoff; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_employee_layoff (
    id bigint NOT NULL,
    employee_id integer NOT NULL,
    reason_id integer,
    handover_status integer,
    handover_data json,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_employee_layoff OWNER TO tg_retrieval;

--
-- Name: hrm_employee_layoff_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_employee_layoff_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_employee_layoff_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_employee_layoff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_employee_layoff_id_seq OWNED BY public.hrm_employee_layoff.id;


--
-- Name: hrm_employee_receive; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_employee_receive (
    id bigint NOT NULL,
    employee_id integer NOT NULL,
    date_receive date NOT NULL,
    receive_id integer NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_employee_receive OWNER TO tg_retrieval;

--
-- Name: hrm_employee_receive_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_employee_receive_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_employee_receive_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_employee_receive_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_employee_receive_id_seq OWNED BY public.hrm_employee_receive.id;


--
-- Name: hrm_employee_salaries; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_employee_salaries (
    id bigint NOT NULL,
    contract_id integer NOT NULL,
    from_date date,
    notes character varying(255),
    salary_method_id integer DEFAULT 0 NOT NULL,
    salary_money integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_employee_salaries OWNER TO tg_retrieval;

--
-- Name: hrm_employee_salaries_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_employee_salaries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_employee_salaries_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_employee_salaries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_employee_salaries_id_seq OWNED BY public.hrm_employee_salaries.id;


--
-- Name: hrm_insurance_rate; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_insurance_rate (
    id bigint NOT NULL,
    department_id integer DEFAULT 0 NOT NULL,
    month date NOT NULL,
    payment_rates real,
    social_insurance real,
    social_insurance_company real,
    social_insurance_employee real,
    labor_insurance real,
    labor_insurance_company real,
    labor_insurance_employee real,
    health_insurance real,
    health_insurance_company real,
    health_insurance_employee real,
    unemployment_insurance real,
    unemployment_insurance_company real,
    unemployment_insurance_employee real,
    notes text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_insurance_rate OWNER TO tg_retrieval;

--
-- Name: hrm_insurance_rate_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_insurance_rate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_insurance_rate_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_insurance_rate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_insurance_rate_id_seq OWNED BY public.hrm_insurance_rate.id;


--
-- Name: hrm_insurance_setting; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_insurance_setting (
    id bigint NOT NULL,
    insurance_id integer NOT NULL,
    month date NOT NULL,
    payment_rates real,
    social_insurance real,
    social_insurance_company real,
    social_insurance_employee real,
    labor_insurance real,
    labor_insurance_company real,
    labor_insurance_employee real,
    health_insurance real,
    health_insurance_company real,
    health_insurance_employee real,
    unemployment_insurance real,
    unemployment_insurance_company real,
    unemployment_insurance_employee real,
    total_insurance real,
    total_insurance_company real,
    total_insurance_employee real,
    notes text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_insurance_setting OWNER TO tg_retrieval;

--
-- Name: hrm_insurance_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_insurance_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_insurance_setting_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_insurance_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_insurance_setting_id_seq OWNED BY public.hrm_insurance_setting.id;


--
-- Name: hrm_job_position_level; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_job_position_level (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_job_position_level OWNER TO tg_retrieval;

--
-- Name: hrm_job_position_level_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_job_position_level_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_job_position_level_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_job_position_level_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_job_position_level_id_seq OWNED BY public.hrm_job_position_level.id;


--
-- Name: hrm_job_position_title; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_job_position_title (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    position_level_id character varying(255),
    description character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_job_position_title OWNER TO tg_retrieval;

--
-- Name: hrm_job_position_title_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_job_position_title_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_job_position_title_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_job_position_title_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_job_position_title_id_seq OWNED BY public.hrm_job_position_title.id;


--
-- Name: hrm_job_positions; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_job_positions (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    parent_id integer DEFAULT 0 NOT NULL,
    position_title_id integer,
    role_id integer,
    salary_from real,
    salary_to real,
    description character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_job_positions OWNER TO tg_retrieval;

--
-- Name: hrm_job_positions_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_job_positions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_job_positions_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_job_positions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_job_positions_id_seq OWNED BY public.hrm_job_positions.id;


--
-- Name: hrm_penances; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_penances (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    money integer NOT NULL,
    description character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_penances OWNER TO tg_retrieval;

--
-- Name: hrm_penances_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_penances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_penances_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_penances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_penances_id_seq OWNED BY public.hrm_penances.id;


--
-- Name: hrm_personnel_profile; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_personnel_profile (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    type_category character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    CONSTRAINT hrm_personnel_profile_type_category_check CHECK (((type_category)::text = ANY ((ARRAY['certificate'::character varying, 'labor'::character varying, 'receives'::character varying, 'jobouts'::character varying])::text[])))
);


ALTER TABLE public.hrm_personnel_profile OWNER TO tg_retrieval;

--
-- Name: hrm_personnel_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_personnel_profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_personnel_profile_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_personnel_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_personnel_profile_id_seq OWNED BY public.hrm_personnel_profile.id;


--
-- Name: hrm_type_contract; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_type_contract (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    type_contract character varying(255) NOT NULL,
    pay_insurance boolean DEFAULT false NOT NULL,
    period character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_type_contract OWNER TO tg_retrieval;

--
-- Name: hrm_type_contract_allowances; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_type_contract_allowances (
    id bigint NOT NULL,
    type_contract_id integer NOT NULL,
    allowance_id integer NOT NULL,
    allowance_amount double precision NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.hrm_type_contract_allowances OWNER TO tg_retrieval;

--
-- Name: hrm_type_contract_allowances_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_type_contract_allowances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_type_contract_allowances_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_type_contract_allowances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_type_contract_allowances_id_seq OWNED BY public.hrm_type_contract_allowances.id;


--
-- Name: hrm_type_contract_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_type_contract_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_type_contract_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_type_contract_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_type_contract_id_seq OWNED BY public.hrm_type_contract.id;


--
-- Name: hrm_welfares; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_welfares (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    money numeric(8,2) NOT NULL,
    description character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_welfares OWNER TO tg_retrieval;

--
-- Name: hrm_welfares_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_welfares_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_welfares_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_welfares_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_welfares_id_seq OWNED BY public.hrm_welfares.id;


--
-- Name: hrm_workplaces; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.hrm_workplaces (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    address character varying(255),
    address_id integer,
    department_id integer,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.hrm_workplaces OWNER TO tg_retrieval;

--
-- Name: hrm_workplaces_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.hrm_workplaces_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hrm_workplaces_id_seq OWNER TO tg_retrieval;

--
-- Name: hrm_workplaces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.hrm_workplaces_id_seq OWNED BY public.hrm_workplaces.id;


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO tg_retrieval;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO tg_retrieval;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jobs_id_seq OWNER TO tg_retrieval;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.locations (
    id bigint NOT NULL,
    address character varying(255) NOT NULL,
    parent_id integer,
    location_code text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.locations OWNER TO tg_retrieval;

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.locations_id_seq OWNER TO tg_retrieval;

--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO tg_retrieval;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO tg_retrieval;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: model_has_permissions; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.model_has_permissions (
    permission_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);


ALTER TABLE public.model_has_permissions OWNER TO tg_retrieval;

--
-- Name: model_has_roles; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.model_has_roles (
    role_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);


ALTER TABLE public.model_has_roles OWNER TO tg_retrieval;

--
-- Name: notify_notification_types; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.notify_notification_types (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.notify_notification_types OWNER TO tg_retrieval;

--
-- Name: notify_notification_types_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.notify_notification_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notify_notification_types_id_seq OWNER TO tg_retrieval;

--
-- Name: notify_notification_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.notify_notification_types_id_seq OWNED BY public.notify_notification_types.id;


--
-- Name: notify_notifications; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.notify_notifications (
    id bigint NOT NULL,
    title character varying(255),
    content text NOT NULL,
    extra text NOT NULL,
    url character varying(255),
    auth_id integer NOT NULL,
    type_id integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.notify_notifications OWNER TO tg_retrieval;

--
-- Name: notify_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.notify_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notify_notifications_id_seq OWNER TO tg_retrieval;

--
-- Name: notify_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.notify_notifications_id_seq OWNED BY public.notify_notifications.id;


--
-- Name: notify_user_notification; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.notify_user_notification (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    notify_id integer NOT NULL,
    read integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.notify_user_notification OWNER TO tg_retrieval;

--
-- Name: notify_user_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.notify_user_notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notify_user_notification_id_seq OWNER TO tg_retrieval;

--
-- Name: notify_user_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.notify_user_notification_id_seq OWNED BY public.notify_user_notification.id;


--
-- Name: notify_user_setting_notification; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.notify_user_setting_notification (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    module character varying(255),
    feature character varying(255),
    action character varying(255),
    command character varying(255),
    "position" character varying(255) DEFAULT 'bottom right'::character varying NOT NULL,
    sound character varying(255) DEFAULT 'default'::character varying NOT NULL,
    auto_close boolean DEFAULT false NOT NULL,
    is_notify boolean DEFAULT true NOT NULL,
    is_mute boolean DEFAULT false NOT NULL,
    is_send boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.notify_user_setting_notification OWNER TO tg_retrieval;

--
-- Name: notify_user_setting_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.notify_user_setting_notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notify_user_setting_notification_id_seq OWNER TO tg_retrieval;

--
-- Name: notify_user_setting_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.notify_user_setting_notification_id_seq OWNED BY public.notify_user_setting_notification.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO tg_retrieval;

--
-- Name: permissions; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    name_string character varying(255) NOT NULL,
    description character varying(255),
    guard_name character varying(255) NOT NULL,
    module_key character varying(255) NOT NULL,
    module_name character varying(255) NOT NULL,
    sort integer NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.permissions OWNER TO tg_retrieval;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permissions_id_seq OWNER TO tg_retrieval;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO tg_retrieval;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personal_access_tokens_id_seq OWNER TO tg_retrieval;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: portal_informations; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.portal_informations (
    id bigint NOT NULL,
    portal_id integer NOT NULL,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.portal_informations OWNER TO tg_retrieval;

--
-- Name: portal_informations_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.portal_informations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.portal_informations_id_seq OWNER TO tg_retrieval;

--
-- Name: portal_informations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.portal_informations_id_seq OWNED BY public.portal_informations.id;


--
-- Name: portals; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.portals (
    id bigint NOT NULL,
    subdomain character varying(255) NOT NULL,
    database character varying(255) NOT NULL,
    language character varying(255) NOT NULL,
    username character varying(255),
    description text,
    name_deputy text,
    phone_contact text,
    email_contact text,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    CONSTRAINT portals_language_check CHECK (((language)::text = ANY ((ARRAY['vi'::character varying, 'en'::character varying, 'jp'::character varying])::text[])))
);


ALTER TABLE public.portals OWNER TO tg_retrieval;

--
-- Name: portals_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.portals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.portals_id_seq OWNER TO tg_retrieval;

--
-- Name: portals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.portals_id_seq OWNED BY public.portals.id;


--
-- Name: role_has_permissions; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.role_has_permissions (
    permission_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.role_has_permissions OWNER TO tg_retrieval;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.roles OWNER TO tg_retrieval;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO tg_retrieval;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO tg_retrieval;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.tags (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255),
    color character varying(255) DEFAULT '#fff'::character varying NOT NULL,
    module character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.tags OWNER TO tg_retrieval;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO tg_retrieval;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: tags_modules; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.tags_modules (
    id bigint NOT NULL,
    object_id bigint NOT NULL,
    tag_id smallint NOT NULL,
    module character varying(255) NOT NULL,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.tags_modules OWNER TO tg_retrieval;

--
-- Name: tags_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.tags_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_modules_id_seq OWNER TO tg_retrieval;

--
-- Name: tags_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.tags_modules_id_seq OWNED BY public.tags_modules.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying(255) NOT NULL,
    supper_admin boolean DEFAULT false NOT NULL,
    password character varying(255) NOT NULL,
    role_id integer DEFAULT 0 NOT NULL,
    avatar character varying(255),
    language character varying(255) DEFAULT 'vi'::character varying NOT NULL,
    dark_mode boolean DEFAULT false NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    CONSTRAINT users_language_check CHECK (((language)::text = ANY ((ARRAY['vi'::character varying, 'en'::character varying, 'ja'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO tg_retrieval;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO tg_retrieval;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: work_project_groups; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.work_project_groups (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    status boolean DEFAULT true NOT NULL,
    material_manage boolean DEFAULT false NOT NULL,
    financial_manage boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.work_project_groups OWNER TO tg_retrieval;

--
-- Name: work_project_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.work_project_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_project_groups_id_seq OWNER TO tg_retrieval;

--
-- Name: work_project_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.work_project_groups_id_seq OWNED BY public.work_project_groups.id;


--
-- Name: work_project_objects; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.work_project_objects (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    object_id integer NOT NULL,
    object_type character varying(255) NOT NULL,
    role character varying(255) NOT NULL,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.work_project_objects OWNER TO tg_retrieval;

--
-- Name: work_project_objects_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.work_project_objects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_project_objects_id_seq OWNER TO tg_retrieval;

--
-- Name: work_project_objects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.work_project_objects_id_seq OWNED BY public.work_project_objects.id;


--
-- Name: work_project_permissions; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.work_project_permissions (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    permission_key character varying(255) NOT NULL,
    permission_description character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.work_project_permissions OWNER TO tg_retrieval;

--
-- Name: work_project_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.work_project_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_project_permissions_id_seq OWNER TO tg_retrieval;

--
-- Name: work_project_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.work_project_permissions_id_seq OWNED BY public.work_project_permissions.id;


--
-- Name: work_project_phases; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.work_project_phases (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    calculate_process_type character varying(255) NOT NULL,
    description text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.work_project_phases OWNER TO tg_retrieval;

--
-- Name: work_project_phases_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.work_project_phases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_project_phases_id_seq OWNER TO tg_retrieval;

--
-- Name: work_project_phases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.work_project_phases_id_seq OWNED BY public.work_project_phases.id;


--
-- Name: work_project_task_categories; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.work_project_task_categories (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    calculate_process_type character varying(255) NOT NULL,
    description text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.work_project_task_categories OWNER TO tg_retrieval;

--
-- Name: work_project_task_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.work_project_task_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_project_task_categories_id_seq OWNER TO tg_retrieval;

--
-- Name: work_project_task_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.work_project_task_categories_id_seq OWNED BY public.work_project_task_categories.id;


--
-- Name: work_projects; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.work_projects (
    id bigint NOT NULL,
    project_group_id bigint,
    code character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    calculate_process_type character varying(255) NOT NULL,
    actual_start_date timestamp(0) without time zone,
    actual_end_date timestamp(0) without time zone,
    budget numeric(16,2),
    description text,
    start_date timestamp(0) without time zone,
    end_date timestamp(0) without time zone,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.work_projects OWNER TO tg_retrieval;

--
-- Name: work_projects_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.work_projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_projects_id_seq OWNER TO tg_retrieval;

--
-- Name: work_projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.work_projects_id_seq OWNED BY public.work_projects.id;


--
-- Name: work_relation_objects; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.work_relation_objects (
    id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL,
    object_id integer NOT NULL,
    object_type character varying(255) NOT NULL,
    role character varying(255) NOT NULL,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.work_relation_objects OWNER TO tg_retrieval;

--
-- Name: work_relation_objects_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.work_relation_objects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_relation_objects_id_seq OWNER TO tg_retrieval;

--
-- Name: work_relation_objects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.work_relation_objects_id_seq OWNED BY public.work_relation_objects.id;


--
-- Name: work_task_check_list; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.work_task_check_list (
    id bigint NOT NULL,
    task_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    is_done boolean DEFAULT false NOT NULL,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.work_task_check_list OWNER TO tg_retrieval;

--
-- Name: work_task_check_list_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.work_task_check_list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_task_check_list_id_seq OWNER TO tg_retrieval;

--
-- Name: work_task_check_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.work_task_check_list_id_seq OWNED BY public.work_task_check_list.id;


--
-- Name: work_task_progress_reports; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.work_task_progress_reports (
    id bigint NOT NULL,
    task_id bigint NOT NULL,
    date date NOT NULL,
    progress integer NOT NULL,
    content text,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.work_task_progress_reports OWNER TO tg_retrieval;

--
-- Name: work_task_progress_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.work_task_progress_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_task_progress_reports_id_seq OWNER TO tg_retrieval;

--
-- Name: work_task_progress_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.work_task_progress_reports_id_seq OWNED BY public.work_task_progress_reports.id;


--
-- Name: work_task_review_reports; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.work_task_review_reports (
    id bigint NOT NULL,
    task_id bigint NOT NULL,
    date date NOT NULL,
    progress integer NOT NULL,
    quality smallint NOT NULL,
    status character varying(255),
    actual_end_date timestamp(0) without time zone,
    content text,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.work_task_review_reports OWNER TO tg_retrieval;

--
-- Name: work_task_review_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.work_task_review_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_task_review_reports_id_seq OWNER TO tg_retrieval;

--
-- Name: work_task_review_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.work_task_review_reports_id_seq OWNED BY public.work_task_review_reports.id;


--
-- Name: work_task_types; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.work_task_types (
    id bigint NOT NULL,
    parent_id bigint,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.work_task_types OWNER TO tg_retrieval;

--
-- Name: work_task_types_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.work_task_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_task_types_id_seq OWNER TO tg_retrieval;

--
-- Name: work_task_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.work_task_types_id_seq OWNED BY public.work_task_types.id;


--
-- Name: work_task_units; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.work_task_units (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.work_task_units OWNER TO tg_retrieval;

--
-- Name: work_task_units_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.work_task_units_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_task_units_id_seq OWNER TO tg_retrieval;

--
-- Name: work_task_units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.work_task_units_id_seq OWNED BY public.work_task_units.id;


--
-- Name: work_tasks; Type: TABLE; Schema: public; Owner: tg_retrieval
--

CREATE TABLE public.work_tasks (
    id bigint NOT NULL,
    code character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    project_id bigint,
    project_task_category_id bigint,
    project_phase_id bigint,
    task_type_id bigint,
    parent_id bigint,
    is_hourly_task boolean DEFAULT false NOT NULL,
    start_date timestamp(0) without time zone,
    end_date timestamp(0) without time zone,
    actual_start_date timestamp(0) without time zone,
    actual_end_date timestamp(0) without time zone,
    priority character varying(255),
    calculate_process_type character varying(255) NOT NULL,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    progress integer DEFAULT 0 NOT NULL,
    description text,
    task_classification character varying(255) DEFAULT 'normal'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    created_by integer,
    updated_by integer,
    deleted_by integer,
    sort integer DEFAULT 99 NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.work_tasks OWNER TO tg_retrieval;

--
-- Name: work_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: tg_retrieval
--

CREATE SEQUENCE public.work_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_tasks_id_seq OWNER TO tg_retrieval;

--
-- Name: work_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tg_retrieval
--

ALTER SEQUENCE public.work_tasks_id_seq OWNED BY public.work_tasks.id;


--
-- Name: activity_log id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.activity_log ALTER COLUMN id SET DEFAULT nextval('public.activity_log_id_seq'::regclass);


--
-- Name: chat_contacts id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.chat_contacts ALTER COLUMN id SET DEFAULT nextval('public.chat_contacts_id_seq'::regclass);


--
-- Name: chat_files id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.chat_files ALTER COLUMN id SET DEFAULT nextval('public.chat_files_id_seq'::regclass);


--
-- Name: chat_message_file id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.chat_message_file ALTER COLUMN id SET DEFAULT nextval('public.chat_message_file_id_seq'::regclass);


--
-- Name: chat_messages ids; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.chat_messages ALTER COLUMN ids SET DEFAULT nextval('public.chat_messages_ids_seq'::regclass);


--
-- Name: chat_module_room id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.chat_module_room ALTER COLUMN id SET DEFAULT nextval('public.chat_module_room_id_seq'::regclass);


--
-- Name: chat_room_file id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.chat_room_file ALTER COLUMN id SET DEFAULT nextval('public.chat_room_file_id_seq'::regclass);


--
-- Name: chat_rooms id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.chat_rooms ALTER COLUMN id SET DEFAULT nextval('public.chat_rooms_id_seq'::regclass);


--
-- Name: chat_user_file id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.chat_user_file ALTER COLUMN id SET DEFAULT nextval('public.chat_user_file_id_seq'::regclass);


--
-- Name: chat_user_room id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.chat_user_room ALTER COLUMN id SET DEFAULT nextval('public.chat_user_room_id_seq'::regclass);


--
-- Name: department_business id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.department_business ALTER COLUMN id SET DEFAULT nextval('public.department_business_id_seq'::regclass);


--
-- Name: department_types id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.department_types ALTER COLUMN id SET DEFAULT nextval('public.department_types_id_seq'::regclass);


--
-- Name: departments id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.departments ALTER COLUMN id SET DEFAULT nextval('public.departments_id_seq'::regclass);


--
-- Name: documents id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.documents ALTER COLUMN id SET DEFAULT nextval('public.documents_id_seq'::regclass);


--
-- Name: documents_attachs id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.documents_attachs ALTER COLUMN id SET DEFAULT nextval('public.documents_attachs_id_seq'::regclass);


--
-- Name: documents_modules_attachs id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.documents_modules_attachs ALTER COLUMN id SET DEFAULT nextval('public.documents_modules_attachs_id_seq'::regclass);


--
-- Name: documents_recents id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.documents_recents ALTER COLUMN id SET DEFAULT nextval('public.documents_recents_id_seq'::regclass);


--
-- Name: documents_shares id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.documents_shares ALTER COLUMN id SET DEFAULT nextval('public.documents_shares_id_seq'::regclass);


--
-- Name: employee_history_setting id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.employee_history_setting ALTER COLUMN id SET DEFAULT nextval('public.employee_history_setting_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: hrm_allowance_settings id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_allowance_settings ALTER COLUMN id SET DEFAULT nextval('public.hrm_allowance_settings_id_seq'::regclass);


--
-- Name: hrm_allowance_type_contracts id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_allowance_type_contracts ALTER COLUMN id SET DEFAULT nextval('public.hrm_allowance_type_contracts_id_seq'::regclass);


--
-- Name: hrm_allowance_types id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_allowance_types ALTER COLUMN id SET DEFAULT nextval('public.hrm_allowance_types_id_seq'::regclass);


--
-- Name: hrm_allowances id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_allowances ALTER COLUMN id SET DEFAULT nextval('public.hrm_allowances_id_seq'::regclass);


--
-- Name: hrm_banks id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_banks ALTER COLUMN id SET DEFAULT nextval('public.hrm_banks_id_seq'::regclass);


--
-- Name: hrm_decision_answers id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_decision_answers ALTER COLUMN id SET DEFAULT nextval('public.hrm_decision_answers_id_seq'::regclass);


--
-- Name: hrm_decision_questions id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_decision_questions ALTER COLUMN id SET DEFAULT nextval('public.hrm_decision_questions_id_seq'::regclass);


--
-- Name: hrm_employee_allowances id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_allowances ALTER COLUMN id SET DEFAULT nextval('public.hrm_employee_allowances_id_seq'::regclass);


--
-- Name: hrm_employee_banks id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_banks ALTER COLUMN id SET DEFAULT nextval('public.hrm_employee_banks_id_seq'::regclass);


--
-- Name: hrm_employee_certificates id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_certificates ALTER COLUMN id SET DEFAULT nextval('public.hrm_employee_certificates_id_seq'::regclass);


--
-- Name: hrm_employee_concurrents id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_concurrents ALTER COLUMN id SET DEFAULT nextval('public.hrm_employee_concurrents_id_seq'::regclass);


--
-- Name: hrm_employee_contacts id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_contacts ALTER COLUMN id SET DEFAULT nextval('public.hrm_employee_contacts_id_seq'::regclass);


--
-- Name: hrm_employee_contract_allowances id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_contract_allowances ALTER COLUMN id SET DEFAULT nextval('public.hrm_employee_contract_allowances_id_seq'::regclass);


--
-- Name: hrm_employee_contracts id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_contracts ALTER COLUMN id SET DEFAULT nextval('public.hrm_employee_contracts_id_seq'::regclass);


--
-- Name: hrm_employee_dependents id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_dependents ALTER COLUMN id SET DEFAULT nextval('public.hrm_employee_dependents_id_seq'::regclass);


--
-- Name: hrm_employee_history_setting id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_history_setting ALTER COLUMN id SET DEFAULT nextval('public.hrm_employee_history_setting_id_seq'::regclass);


--
-- Name: hrm_employee_informations id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_informations ALTER COLUMN id SET DEFAULT nextval('public.hrm_employee_informations_id_seq'::regclass);


--
-- Name: hrm_employee_insurance_payment_histories id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_insurance_payment_histories ALTER COLUMN id SET DEFAULT nextval('public.hrm_employee_insurance_payment_histories_id_seq'::regclass);


--
-- Name: hrm_employee_insurance_payments id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_insurance_payments ALTER COLUMN id SET DEFAULT nextval('public.hrm_employee_insurance_payments_id_seq'::regclass);


--
-- Name: hrm_employee_insurance_resolves id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_insurance_resolves ALTER COLUMN id SET DEFAULT nextval('public.hrm_employee_insurance_resolves_id_seq'::regclass);


--
-- Name: hrm_employee_insurances id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_insurances ALTER COLUMN id SET DEFAULT nextval('public.hrm_employee_insurances_id_seq'::regclass);


--
-- Name: hrm_employee_job_history id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_job_history ALTER COLUMN id SET DEFAULT nextval('public.hrm_employee_job_history_id_seq'::regclass);


--
-- Name: hrm_employee_layoff id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_layoff ALTER COLUMN id SET DEFAULT nextval('public.hrm_employee_layoff_id_seq'::regclass);


--
-- Name: hrm_employee_receive id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_receive ALTER COLUMN id SET DEFAULT nextval('public.hrm_employee_receive_id_seq'::regclass);


--
-- Name: hrm_employee_salaries id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_salaries ALTER COLUMN id SET DEFAULT nextval('public.hrm_employee_salaries_id_seq'::regclass);


--
-- Name: hrm_insurance_rate id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_insurance_rate ALTER COLUMN id SET DEFAULT nextval('public.hrm_insurance_rate_id_seq'::regclass);


--
-- Name: hrm_insurance_setting id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_insurance_setting ALTER COLUMN id SET DEFAULT nextval('public.hrm_insurance_setting_id_seq'::regclass);


--
-- Name: hrm_job_position_level id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_job_position_level ALTER COLUMN id SET DEFAULT nextval('public.hrm_job_position_level_id_seq'::regclass);


--
-- Name: hrm_job_position_title id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_job_position_title ALTER COLUMN id SET DEFAULT nextval('public.hrm_job_position_title_id_seq'::regclass);


--
-- Name: hrm_job_positions id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_job_positions ALTER COLUMN id SET DEFAULT nextval('public.hrm_job_positions_id_seq'::regclass);


--
-- Name: hrm_penances id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_penances ALTER COLUMN id SET DEFAULT nextval('public.hrm_penances_id_seq'::regclass);


--
-- Name: hrm_personnel_profile id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_personnel_profile ALTER COLUMN id SET DEFAULT nextval('public.hrm_personnel_profile_id_seq'::regclass);


--
-- Name: hrm_type_contract id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_type_contract ALTER COLUMN id SET DEFAULT nextval('public.hrm_type_contract_id_seq'::regclass);


--
-- Name: hrm_type_contract_allowances id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_type_contract_allowances ALTER COLUMN id SET DEFAULT nextval('public.hrm_type_contract_allowances_id_seq'::regclass);


--
-- Name: hrm_welfares id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_welfares ALTER COLUMN id SET DEFAULT nextval('public.hrm_welfares_id_seq'::regclass);


--
-- Name: hrm_workplaces id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_workplaces ALTER COLUMN id SET DEFAULT nextval('public.hrm_workplaces_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: notify_notification_types id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.notify_notification_types ALTER COLUMN id SET DEFAULT nextval('public.notify_notification_types_id_seq'::regclass);


--
-- Name: notify_notifications id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.notify_notifications ALTER COLUMN id SET DEFAULT nextval('public.notify_notifications_id_seq'::regclass);


--
-- Name: notify_user_notification id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.notify_user_notification ALTER COLUMN id SET DEFAULT nextval('public.notify_user_notification_id_seq'::regclass);


--
-- Name: notify_user_setting_notification id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.notify_user_setting_notification ALTER COLUMN id SET DEFAULT nextval('public.notify_user_setting_notification_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: portal_informations id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.portal_informations ALTER COLUMN id SET DEFAULT nextval('public.portal_informations_id_seq'::regclass);


--
-- Name: portals id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.portals ALTER COLUMN id SET DEFAULT nextval('public.portals_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: tags_modules id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.tags_modules ALTER COLUMN id SET DEFAULT nextval('public.tags_modules_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: work_project_groups id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_project_groups ALTER COLUMN id SET DEFAULT nextval('public.work_project_groups_id_seq'::regclass);


--
-- Name: work_project_objects id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_project_objects ALTER COLUMN id SET DEFAULT nextval('public.work_project_objects_id_seq'::regclass);


--
-- Name: work_project_permissions id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_project_permissions ALTER COLUMN id SET DEFAULT nextval('public.work_project_permissions_id_seq'::regclass);


--
-- Name: work_project_phases id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_project_phases ALTER COLUMN id SET DEFAULT nextval('public.work_project_phases_id_seq'::regclass);


--
-- Name: work_project_task_categories id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_project_task_categories ALTER COLUMN id SET DEFAULT nextval('public.work_project_task_categories_id_seq'::regclass);


--
-- Name: work_projects id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_projects ALTER COLUMN id SET DEFAULT nextval('public.work_projects_id_seq'::regclass);


--
-- Name: work_relation_objects id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_relation_objects ALTER COLUMN id SET DEFAULT nextval('public.work_relation_objects_id_seq'::regclass);


--
-- Name: work_task_check_list id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_task_check_list ALTER COLUMN id SET DEFAULT nextval('public.work_task_check_list_id_seq'::regclass);


--
-- Name: work_task_progress_reports id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_task_progress_reports ALTER COLUMN id SET DEFAULT nextval('public.work_task_progress_reports_id_seq'::regclass);


--
-- Name: work_task_review_reports id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_task_review_reports ALTER COLUMN id SET DEFAULT nextval('public.work_task_review_reports_id_seq'::regclass);


--
-- Name: work_task_types id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_task_types ALTER COLUMN id SET DEFAULT nextval('public.work_task_types_id_seq'::regclass);


--
-- Name: work_task_units id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_task_units ALTER COLUMN id SET DEFAULT nextval('public.work_task_units_id_seq'::regclass);


--
-- Name: work_tasks id; Type: DEFAULT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_tasks ALTER COLUMN id SET DEFAULT nextval('public.work_tasks_id_seq'::regclass);


--
-- Data for Name: activity_log; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.activity_log (id, log_name, event, description, subject_type, subject_id, causer_type, causer_id, properties, batch_uuid, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.cache (key, value, expiration) FROM stdin;
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- Data for Name: chat_contacts; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.chat_contacts (id, user_id, contact_id, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: chat_files; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.chat_files (id, name, ext, type, path, store, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: chat_message_file; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.chat_message_file (id, message_id, file_id, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: chat_messages; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.chat_messages (ids, id, content, room_id, status, auth, thread, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: chat_module_room; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.chat_module_room (id, module, object_id, room_id, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: chat_room_file; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.chat_room_file (id, room_id, file_id, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: chat_rooms; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.chat_rooms (id, name, description, icon, type, pin, total, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: chat_user_file; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.chat_user_file (id, user_id, file_id, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: chat_user_room; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.chat_user_room (id, user_id, room_id, type, "position", mention, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: department_business; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.department_business (id, name, status, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: department_types; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.department_types (id, name, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.departments (id, role, code, name, tax, parent_id, date_of_incorporation, address, place_of_address, office_address, office_place_of_address, business_department_id, type_department_id, description, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.documents (id, name, hash_name, user_id, original_version_id, type, mime_type, left_value, right_value, path, extension, capacity, version, token_share, token_share_expired, thumbnail_url, description, owner_id, created_by, updated_by, deleted_by, sort, active, deleted_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: documents_attachs; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.documents_attachs (id, name, hash_name, document_module_id, type, mime_type, left_value, right_value, extension, capacity, document_attachable_id, document_attachable_type, thumbnail_url, path, created_by, updated_by, deleted_by, sort, active, deleted_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: documents_modules_attachs; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.documents_modules_attachs (id, module, name, type, created_by, updated_by, deleted_by, sort, active, deleted_at, created_at, updated_at) FROM stdin;
9	Papers	Papers	papers_papers	\N	\N	\N	99	t	\N	2024-06-13 04:28:02	2024-06-13 04:31:41
10	Work	Work	work_work	\N	\N	\N	99	t	\N	2024-06-13 04:28:02	2024-06-13 04:31:41
11	Work	Work Normal	work_work_normal	\N	\N	\N	99	t	\N	2024-06-13 04:28:02	2024-06-13 04:31:41
12	Work	Project	work_project	\N	\N	\N	99	t	\N	2024-06-13 04:28:02	2024-06-13 04:31:41
13	Document	Document Incoming Text	document_incoming_text	\N	\N	\N	99	t	\N	2024-06-13 04:28:02	2024-06-13 04:31:41
14	Document	Document Out Text	document_out_text	\N	\N	\N	99	t	\N	2024-06-13 04:28:02	2024-06-13 04:31:41
15	Document	Document Internal Text	document_internal_text	\N	\N	\N	99	t	\N	2024-06-13 04:28:02	2024-06-13 04:31:41
16	Document	Work	document_work	\N	\N	\N	99	t	\N	2024-06-13 04:28:02	2024-06-13 04:31:41
\.


--
-- Data for Name: documents_recents; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.documents_recents (id, document_id, user_id, view_at, created_by, updated_by, deleted_by, sort, active, deleted_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: documents_shares; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.documents_shares (id, document_id, user_id, permission, created_by, updated_by, deleted_by, sort, active, deleted_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: employee_history_setting; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.employee_history_setting (id, title, object_history, icon, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: hrm_allowance_settings; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_allowance_settings (id, allowance_name, allowance_amount, is_tax, unit, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: hrm_allowance_type_contracts; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_allowance_type_contracts (id, type_contract_id, allowance_id, allowance_amount, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: hrm_allowance_types; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_allowance_types (id, allowance_name, allowance_amount, is_tax, unit, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: hrm_allowances; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_allowances (id, name, amount, is_tax, unit, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_banks; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_banks (id, bank_name, bank_code, bank_address, bank_branch, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_decision_answers; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_decision_answers (id, type_id, question_id, decision_number, decision_date, department_id, censor_ids, status, answers, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_decision_questions; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_decision_questions (id, type_id, decision_number, decision_date, department_id, questions, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_employee_allowances; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_employee_allowances (id, contract_id, from_date, notes, salary_method_id, salary_money, salary_amount, allow_id, allow_money, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_employee_banks; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_employee_banks (id, employee_id, account_number, account_name, bank_id, bank_branch, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_employee_certificates; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_employee_certificates (id, employee_id, type_certificate_id, document_level_id, version, count_released, date_apply, date_end, attachments, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_employee_concurrents; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_employee_concurrents (id, employee_id, start_date, end_date, department_id, position_id, position_title_id, role_id, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_employee_contacts; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_employee_contacts (id, employee_id, personal_phone, office_phone, home_phone, orther_phone, personal_email, office_email, orther_email, skype_link, facebook_link, twitter_link, permanent_nation, permanent_province, permanent_district, permanent_ward, permanent_address, household_number, household_code, is_householder, temporary_nation, temporary_province, temporary_district, temporary_ward, temporary_address, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_employee_contract_allowances; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_employee_contract_allowances (id, contract_id, from_date, notes, salary_method_id, salary_money, salary_amount, allow_id, allow_money, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_employee_contracts; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_employee_contracts (id, employee_id, company_id, contract_number, contract_name, contract_duration, effective_date, salary, salary_percent, position_id, status, type_contract_id, sign_date, form_work, expiry_date, insurance_salary, signed_by, file_link, notes, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_employee_dependents; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_employee_dependents (id, employee_id, relative_id, fullname, birthday, telephone, id_number, id_issue_date, id_issue_place, is_dependent, date_from, date_to, tax_code, note, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_employee_history_setting; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_employee_history_setting (id, title, object_history, icon, is_active, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_employee_informations; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_employee_informations (id, user_id, employee_code, attendance_code, profile_code, fullname, birthday, gender, military_service, birthplace, hometown, id_number, id_issue_date, id_issue_place, id_front_image, id_back_image, avatar, nation, marital_status, ethnic, religion, tax_code, tax_issue_date, tax_issue_place, sync_code, start_date, date_to, job_reldate_join, level_school, specialization, level_academic, insurance_number, passport_number, passport_issue_date, passport_issue_place, passport_expiry_date, company_id, department_id, direct_management_id, status, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_employee_insurance_payment_histories; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_employee_insurance_payment_histories (id, insurance_id, month, payment_method, reason, company_id, "insurance premium_base", "insurance premium_compnay", "insurance premium_employee", notes, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_employee_insurance_payments; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_employee_insurance_payments (id, employee_id, insurance_id, month, payment_method, reason, company_id, "insurance premium_base", "insurance premium_compnay", "insurance premium_employee", notes, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_employee_insurance_resolves; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_employee_insurance_resolves (id, employee_id, insurance_id, date_of_receipt, date_complete_procedure, date_get_money, date_payment, money_received, notes, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_employee_insurances; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_employee_insurances (id, employee_id, insurance_provider, policy_number, coverage_type, amout, start_date, end_date, province_code, hospital_id, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_employee_job_history; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_employee_job_history (id, title, object_history, icon, is_active, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_employee_layoff; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_employee_layoff (id, employee_id, reason_id, handover_status, handover_data, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_employee_receive; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_employee_receive (id, employee_id, date_receive, receive_id, status, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_employee_salaries; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_employee_salaries (id, contract_id, from_date, notes, salary_method_id, salary_money, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_insurance_rate; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_insurance_rate (id, department_id, month, payment_rates, social_insurance, social_insurance_company, social_insurance_employee, labor_insurance, labor_insurance_company, labor_insurance_employee, health_insurance, health_insurance_company, health_insurance_employee, unemployment_insurance, unemployment_insurance_company, unemployment_insurance_employee, notes, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_insurance_setting; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_insurance_setting (id, insurance_id, month, payment_rates, social_insurance, social_insurance_company, social_insurance_employee, labor_insurance, labor_insurance_company, labor_insurance_employee, health_insurance, health_insurance_company, health_insurance_employee, unemployment_insurance, unemployment_insurance_company, unemployment_insurance_employee, total_insurance, total_insurance_company, total_insurance_employee, notes, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_job_position_level; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_job_position_level (id, name, description, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_job_position_title; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_job_position_title (id, name, position_level_id, description, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_job_positions; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_job_positions (id, name, parent_id, position_title_id, role_id, salary_from, salary_to, description, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_penances; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_penances (id, title, money, description, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_personnel_profile; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_personnel_profile (id, name, description, type_category, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_type_contract; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_type_contract (id, name, type_contract, pay_insurance, period, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_type_contract_allowances; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_type_contract_allowances (id, type_contract_id, allowance_id, allowance_amount, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: hrm_welfares; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_welfares (id, title, money, description, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: hrm_workplaces; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.hrm_workplaces (id, name, address, address_id, department_id, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.locations (id, address, parent_id, location_code, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000000_create_users_table	1
2	0001_01_01_000001_create_cache_table	1
3	0001_01_01_000002_create_jobs_table	1
4	2024_04_19_082124_create_personal_access_tokens_table	1
5	2024_04_22_023320_create_permission_tables	1
6	2024_05_31_072200_create_activity_logs_table	2
7	2024_05_09_014251_create_chat_rooms_table	3
8	2024_05_09_014258_create_chat_messages_table	3
9	2024_05_09_014309_create_chat_contacts_table	3
10	2024_05_09_014321_create_chat_user_rooms_table	3
11	2024_05_09_030853_create_chat_files_table	3
12	2024_05_09_030933_create_chat_room_files_table	3
13	2024_05_09_032716_create_chat_message_files_table	3
14	2024_05_09_043435_create_chat_user_files_table	3
15	2024_05_20_034807_create_chat_module_room_table	3
16	2024_04_22_174506_create_departments_table	4
17	2024_05_07_085335_create_department_business	4
18	2024_05_07_090005_create_department_types	4
19	2024_04_19_035342_create_documents_table	5
20	2024_04_22_080257_create_documents_shares_table	5
21	2024_04_22_082653_create_document_recents_table	5
22	2024_04_23_075555_create_documents_attachs	5
23	2024_04_24_023011_create_documents_modules_attachs_table	5
24	2024_04_22_170603_create_hrm_employee_informations_table	6
25	2024_04_22_170941_create_hrm_employee_contracts_table	6
26	2024_04_22_171002_create_hrm_employee_contacts_table	6
27	2024_04_22_171038_create_hrm_employee_dependents_table	6
28	2024_04_22_171104_create_hrm_employee_banks_table	6
29	2024_04_22_184902_create_hrm_banks_table	6
30	2024_04_26_041857_create_hrm_employee_insurances_table	6
31	2024_04_26_044504_create_hrm_employee_insurance_resolves_table	6
32	2024_04_26_063525_create_hrm_insurance_setting_table	6
33	2024_05_02_021210_create_hrm_employee_insurance_payments_table	6
34	2024_05_03_071953_create_hrm_decision_answers_table	6
35	2024_05_03_073928_create_hrm_decision_questions_table	6
36	2024_05_17_043631_create_hrm_job_positions_table	6
37	2024_05_17_064109_create_hrm_job_position_title_table	6
38	2024_05_17_064531_create_hrm_job_position_level_table	6
39	2024_05_28_025550_create_hrm_employee_layoff_table	6
40	2024_05_30_091627_create_hrm_personnel_profile_table	6
41	2024_05_30_091627_create_hrm_type_contract_table	6
42	2024_06_10_031307_create_hrm_workplaces	6
43	2024_06_10_072605_create_hrm_employee_concurrent_table	6
44	2024_06_11_062649_create_hrm_employee_receive_table	6
45	2024_05_16_042618_create_locations_table	7
46	2024_05_23_024948_create_notify_notification_table	8
47	2024_05_23_025042_create_notify_user_setting_notification_table	8
48	2024_05_23_043105_create_notify_user_notification_table	8
49	2024_05_24_034305_create_notify_notification_type_table	8
50	2024_05_10_065418_create_portals_table	9
51	2024_05_10_065845_create_portal_informations_table	9
52	2024_04_22_023211_create_work_project_groups_table	10
53	2024_04_22_043554_create_work_projects_table	10
55	2024_05_07_031458_create_work_project_permissions_table	10
56	2024_05_10_070736_create_work_project_task_caregories_table	10
57	2024_05_14_023250_create_work_project_phases_table	10
58	2024_05_09_025649_create_tags_table	11
59	2024_05_28_030202_create_tags_modules_table	11
60	2024_06_11_093111_create_hrm_employee_certificates_table	12
61	2024_06_12_024354_create_work_project_objects_table	13
62	2024_06_13_035424_create_activity_log_table	14
63	2024_04_22_170941_create_hrm_employee_contract_allowances	15
64	2024_05_02_021210_create_hrm_employee_insurance_payment_histories_table	16
65	2024_04_26_063525_create_hrm_insurance_rate_table	17
66	2024_06_19_024039_create_hrm_allowance_type_contract	18
67	2024_06_19_025240_create_hrm_allowance_setting	18
68	2024_06_19_024039_create_hrm_type_contract_allowances	19
69	2024_06_19_025240_create_hrm_allowance_types	19
70	2024_04_22_170941_create_hrm_employee_allowances	20
71	2024_06_19_083148_create_hrm_employee_salaries	20
72	2024_06_19_025240_create_hrm_allowances	21
73	2024_06_18_030928_create_work_task_types_table	22
74	2024_06_18_031045_create_work_tasks_table	22
75	2024_06_20_023021_work_relation_objects_table	22
76	2024_06_21_090003_create_work_task_progress_reports_table	22
77	2024_06_24_022946_create_work_task_review_reports_table	22
78	2024_06_24_041648_create_work_task_check_list_table	22
79	2024_06_26_085623_create_hrm_penances_table	23
80	2024_06_27_012105_create_hrm_welfares_table	24
81	2024_06_26_024414_create_work_task_units_table	25
82	2024_07_02_014745_create_employee_history_setting_table	26
83	2024_07_02_014745_create_hrm_employee_history_setting_table	27
84	2024_07_02_014745_create_hrm_employee_job_history_table	28
\.


--
-- Data for Name: model_has_permissions; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.model_has_permissions (permission_id, model_type, model_id) FROM stdin;
\.


--
-- Data for Name: model_has_roles; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.model_has_roles (role_id, model_type, model_id) FROM stdin;
\.


--
-- Data for Name: notify_notification_types; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.notify_notification_types (id, name, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: notify_notifications; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.notify_notifications (id, title, content, extra, url, auth_id, type_id, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: notify_user_notification; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.notify_user_notification (id, user_id, notify_id, read, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: notify_user_setting_notification; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.notify_user_setting_notification (id, user_id, module, feature, action, command, "position", sound, auto_close, is_notify, is_mute, is_send, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.permissions (id, name, name_string, description, guard_name, module_key, module_name, sort, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: portal_informations; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.portal_informations (id, portal_id, sort, active, created_by, updated_by, deleted_by, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: portals; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.portals (id, subdomain, database, language, username, description, name_deputy, phone_contact, email_contact, sort, active, created_by, updated_by, deleted_by, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: role_has_permissions; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.role_has_permissions (permission_id, role_id) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.roles (id, name, description, guard_name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.tags (id, name, slug, color, module, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: tags_modules; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.tags_modules (id, object_id, tag_id, module, created_by, updated_by, deleted_by, sort, active, deleted_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.users (id, username, supper_admin, password, role_id, avatar, language, dark_mode, remember_token, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: work_project_groups; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.work_project_groups (id, name, status, material_manage, financial_manage, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: work_project_objects; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.work_project_objects (id, project_id, object_id, object_type, role, created_by, updated_by, deleted_by, sort, active, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: work_project_permissions; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.work_project_permissions (id, project_id, permission_key, permission_description, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: work_project_phases; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.work_project_phases (id, project_id, name, slug, start_date, end_date, calculate_process_type, description, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: work_project_task_categories; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.work_project_task_categories (id, project_id, name, slug, calculate_process_type, description, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: work_projects; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.work_projects (id, project_group_id, code, title, calculate_process_type, actual_start_date, actual_end_date, budget, description, start_date, end_date, status, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: work_relation_objects; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.work_relation_objects (id, model_type, model_id, object_id, object_type, role, created_by, updated_by, deleted_by, sort, active, deleted_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: work_task_check_list; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.work_task_check_list (id, task_id, name, slug, is_done, created_by, updated_by, deleted_by, sort, active, deleted_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: work_task_progress_reports; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.work_task_progress_reports (id, task_id, date, progress, content, created_by, updated_by, deleted_by, sort, active, deleted_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: work_task_review_reports; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.work_task_review_reports (id, task_id, date, progress, quality, status, actual_end_date, content, created_by, updated_by, deleted_by, sort, active, deleted_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: work_task_types; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.work_task_types (id, parent_id, name, slug, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: work_task_units; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.work_task_units (id, name, slug, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Data for Name: work_tasks; Type: TABLE DATA; Schema: public; Owner: tg_retrieval
--

COPY public.work_tasks (id, code, name, project_id, project_task_category_id, project_phase_id, task_type_id, parent_id, is_hourly_task, start_date, end_date, actual_start_date, actual_end_date, priority, calculate_process_type, status, progress, description, task_classification, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, sort, active) FROM stdin;
\.


--
-- Name: activity_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.activity_log_id_seq', 1, false);


--
-- Name: chat_contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.chat_contacts_id_seq', 1, false);


--
-- Name: chat_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.chat_files_id_seq', 1, false);


--
-- Name: chat_message_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.chat_message_file_id_seq', 1, false);


--
-- Name: chat_messages_ids_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.chat_messages_ids_seq', 1, false);


--
-- Name: chat_module_room_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.chat_module_room_id_seq', 1, false);


--
-- Name: chat_room_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.chat_room_file_id_seq', 1, false);


--
-- Name: chat_rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.chat_rooms_id_seq', 1, false);


--
-- Name: chat_user_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.chat_user_file_id_seq', 1, false);


--
-- Name: chat_user_room_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.chat_user_room_id_seq', 1, false);


--
-- Name: department_business_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.department_business_id_seq', 1, false);


--
-- Name: department_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.department_types_id_seq', 1, false);


--
-- Name: departments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.departments_id_seq', 1, false);


--
-- Name: documents_attachs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.documents_attachs_id_seq', 1, false);


--
-- Name: documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.documents_id_seq', 1, false);


--
-- Name: documents_modules_attachs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.documents_modules_attachs_id_seq', 24, true);


--
-- Name: documents_recents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.documents_recents_id_seq', 1, false);


--
-- Name: documents_shares_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.documents_shares_id_seq', 1, false);


--
-- Name: employee_history_setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.employee_history_setting_id_seq', 1, false);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: hrm_allowance_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_allowance_settings_id_seq', 1, false);


--
-- Name: hrm_allowance_type_contracts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_allowance_type_contracts_id_seq', 1, false);


--
-- Name: hrm_allowance_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_allowance_types_id_seq', 1, false);


--
-- Name: hrm_allowances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_allowances_id_seq', 1, false);


--
-- Name: hrm_banks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_banks_id_seq', 1, false);


--
-- Name: hrm_decision_answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_decision_answers_id_seq', 1, false);


--
-- Name: hrm_decision_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_decision_questions_id_seq', 1, false);


--
-- Name: hrm_employee_allowances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_employee_allowances_id_seq', 1, false);


--
-- Name: hrm_employee_banks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_employee_banks_id_seq', 1, false);


--
-- Name: hrm_employee_certificates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_employee_certificates_id_seq', 1, false);


--
-- Name: hrm_employee_concurrents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_employee_concurrents_id_seq', 1, false);


--
-- Name: hrm_employee_contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_employee_contacts_id_seq', 1, false);


--
-- Name: hrm_employee_contract_allowances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_employee_contract_allowances_id_seq', 1, false);


--
-- Name: hrm_employee_contracts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_employee_contracts_id_seq', 1, false);


--
-- Name: hrm_employee_dependents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_employee_dependents_id_seq', 1, false);


--
-- Name: hrm_employee_history_setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_employee_history_setting_id_seq', 1, false);


--
-- Name: hrm_employee_informations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_employee_informations_id_seq', 1, false);


--
-- Name: hrm_employee_insurance_payment_histories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_employee_insurance_payment_histories_id_seq', 1, false);


--
-- Name: hrm_employee_insurance_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_employee_insurance_payments_id_seq', 1, false);


--
-- Name: hrm_employee_insurance_resolves_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_employee_insurance_resolves_id_seq', 1, false);


--
-- Name: hrm_employee_insurances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_employee_insurances_id_seq', 1, false);


--
-- Name: hrm_employee_job_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_employee_job_history_id_seq', 1, false);


--
-- Name: hrm_employee_layoff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_employee_layoff_id_seq', 1, false);


--
-- Name: hrm_employee_receive_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_employee_receive_id_seq', 1, false);


--
-- Name: hrm_employee_salaries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_employee_salaries_id_seq', 1, false);


--
-- Name: hrm_insurance_rate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_insurance_rate_id_seq', 1, false);


--
-- Name: hrm_insurance_setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_insurance_setting_id_seq', 1, false);


--
-- Name: hrm_job_position_level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_job_position_level_id_seq', 1, false);


--
-- Name: hrm_job_position_title_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_job_position_title_id_seq', 1, false);


--
-- Name: hrm_job_positions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_job_positions_id_seq', 1, false);


--
-- Name: hrm_penances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_penances_id_seq', 1, false);


--
-- Name: hrm_personnel_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_personnel_profile_id_seq', 1, false);


--
-- Name: hrm_type_contract_allowances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_type_contract_allowances_id_seq', 1, false);


--
-- Name: hrm_type_contract_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_type_contract_id_seq', 1, false);


--
-- Name: hrm_welfares_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_welfares_id_seq', 1, false);


--
-- Name: hrm_workplaces_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.hrm_workplaces_id_seq', 1, false);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.locations_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.migrations_id_seq', 84, true);


--
-- Name: notify_notification_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.notify_notification_types_id_seq', 1, false);


--
-- Name: notify_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.notify_notifications_id_seq', 1, false);


--
-- Name: notify_user_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.notify_user_notification_id_seq', 1, false);


--
-- Name: notify_user_setting_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.notify_user_setting_notification_id_seq', 1, false);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.permissions_id_seq', 1, false);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 1, false);


--
-- Name: portal_informations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.portal_informations_id_seq', 1, false);


--
-- Name: portals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.portals_id_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.tags_id_seq', 1, false);


--
-- Name: tags_modules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.tags_modules_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: work_project_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.work_project_groups_id_seq', 1, false);


--
-- Name: work_project_objects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.work_project_objects_id_seq', 1, false);


--
-- Name: work_project_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.work_project_permissions_id_seq', 1, false);


--
-- Name: work_project_phases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.work_project_phases_id_seq', 1, false);


--
-- Name: work_project_task_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.work_project_task_categories_id_seq', 1, false);


--
-- Name: work_projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.work_projects_id_seq', 1, false);


--
-- Name: work_relation_objects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.work_relation_objects_id_seq', 1, false);


--
-- Name: work_task_check_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.work_task_check_list_id_seq', 1, false);


--
-- Name: work_task_progress_reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.work_task_progress_reports_id_seq', 1, false);


--
-- Name: work_task_review_reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.work_task_review_reports_id_seq', 1, false);


--
-- Name: work_task_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.work_task_types_id_seq', 1, false);


--
-- Name: work_task_units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.work_task_units_id_seq', 1, false);


--
-- Name: work_tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tg_retrieval
--

SELECT pg_catalog.setval('public.work_tasks_id_seq', 1, false);


--
-- Name: activity_log activity_log_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.activity_log
    ADD CONSTRAINT activity_log_pkey PRIMARY KEY (id);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: chat_contacts chat_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.chat_contacts
    ADD CONSTRAINT chat_contacts_pkey PRIMARY KEY (id);


--
-- Name: chat_files chat_files_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.chat_files
    ADD CONSTRAINT chat_files_pkey PRIMARY KEY (id);


--
-- Name: chat_message_file chat_message_file_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.chat_message_file
    ADD CONSTRAINT chat_message_file_pkey PRIMARY KEY (id);


--
-- Name: chat_messages chat_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.chat_messages
    ADD CONSTRAINT chat_messages_pkey PRIMARY KEY (ids);


--
-- Name: chat_module_room chat_module_room_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.chat_module_room
    ADD CONSTRAINT chat_module_room_pkey PRIMARY KEY (id);


--
-- Name: chat_room_file chat_room_file_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.chat_room_file
    ADD CONSTRAINT chat_room_file_pkey PRIMARY KEY (id);


--
-- Name: chat_rooms chat_rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.chat_rooms
    ADD CONSTRAINT chat_rooms_pkey PRIMARY KEY (id);


--
-- Name: chat_user_file chat_user_file_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.chat_user_file
    ADD CONSTRAINT chat_user_file_pkey PRIMARY KEY (id);


--
-- Name: chat_user_room chat_user_room_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.chat_user_room
    ADD CONSTRAINT chat_user_room_pkey PRIMARY KEY (id);


--
-- Name: department_business department_business_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.department_business
    ADD CONSTRAINT department_business_pkey PRIMARY KEY (id);


--
-- Name: department_types department_types_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.department_types
    ADD CONSTRAINT department_types_pkey PRIMARY KEY (id);


--
-- Name: departments departments_code_unique; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_code_unique UNIQUE (code);


--
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- Name: documents_attachs documents_attachs_document_module_id_left_value_right_value_doc; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.documents_attachs
    ADD CONSTRAINT documents_attachs_document_module_id_left_value_right_value_doc UNIQUE (document_module_id, left_value, right_value, document_attachable_type);


--
-- Name: documents_attachs documents_attachs_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.documents_attachs
    ADD CONSTRAINT documents_attachs_pkey PRIMARY KEY (id);


--
-- Name: documents_modules_attachs documents_modules_attachs_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.documents_modules_attachs
    ADD CONSTRAINT documents_modules_attachs_pkey PRIMARY KEY (id);


--
-- Name: documents_modules_attachs documents_modules_attachs_type_unique; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.documents_modules_attachs
    ADD CONSTRAINT documents_modules_attachs_type_unique UNIQUE (type);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: documents_recents documents_recents_document_id_user_id_unique; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.documents_recents
    ADD CONSTRAINT documents_recents_document_id_user_id_unique UNIQUE (document_id, user_id);


--
-- Name: documents_recents documents_recents_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.documents_recents
    ADD CONSTRAINT documents_recents_pkey PRIMARY KEY (id);


--
-- Name: documents_shares documents_shares_document_id_user_id_unique; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.documents_shares
    ADD CONSTRAINT documents_shares_document_id_user_id_unique UNIQUE (document_id, user_id);


--
-- Name: documents_shares documents_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.documents_shares
    ADD CONSTRAINT documents_shares_pkey PRIMARY KEY (id);


--
-- Name: documents documents_user_id_left_value_right_value_unique; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_user_id_left_value_right_value_unique UNIQUE (user_id, left_value, right_value);


--
-- Name: employee_history_setting employee_history_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.employee_history_setting
    ADD CONSTRAINT employee_history_setting_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: hrm_allowance_settings hrm_allowance_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_allowance_settings
    ADD CONSTRAINT hrm_allowance_settings_pkey PRIMARY KEY (id);


--
-- Name: hrm_allowance_type_contracts hrm_allowance_type_contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_allowance_type_contracts
    ADD CONSTRAINT hrm_allowance_type_contracts_pkey PRIMARY KEY (id);


--
-- Name: hrm_allowance_types hrm_allowance_types_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_allowance_types
    ADD CONSTRAINT hrm_allowance_types_pkey PRIMARY KEY (id);


--
-- Name: hrm_allowances hrm_allowances_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_allowances
    ADD CONSTRAINT hrm_allowances_pkey PRIMARY KEY (id);


--
-- Name: hrm_banks hrm_banks_bank_code_unique; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_banks
    ADD CONSTRAINT hrm_banks_bank_code_unique UNIQUE (bank_code);


--
-- Name: hrm_banks hrm_banks_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_banks
    ADD CONSTRAINT hrm_banks_pkey PRIMARY KEY (id);


--
-- Name: hrm_decision_answers hrm_decision_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_decision_answers
    ADD CONSTRAINT hrm_decision_answers_pkey PRIMARY KEY (id);


--
-- Name: hrm_decision_questions hrm_decision_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_decision_questions
    ADD CONSTRAINT hrm_decision_questions_pkey PRIMARY KEY (id);


--
-- Name: hrm_employee_allowances hrm_employee_allowances_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_allowances
    ADD CONSTRAINT hrm_employee_allowances_pkey PRIMARY KEY (id);


--
-- Name: hrm_employee_banks hrm_employee_banks_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_banks
    ADD CONSTRAINT hrm_employee_banks_pkey PRIMARY KEY (id);


--
-- Name: hrm_employee_certificates hrm_employee_certificates_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_certificates
    ADD CONSTRAINT hrm_employee_certificates_pkey PRIMARY KEY (id);


--
-- Name: hrm_employee_concurrents hrm_employee_concurrents_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_concurrents
    ADD CONSTRAINT hrm_employee_concurrents_pkey PRIMARY KEY (id);


--
-- Name: hrm_employee_contacts hrm_employee_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_contacts
    ADD CONSTRAINT hrm_employee_contacts_pkey PRIMARY KEY (id);


--
-- Name: hrm_employee_contract_allowances hrm_employee_contract_allowances_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_contract_allowances
    ADD CONSTRAINT hrm_employee_contract_allowances_pkey PRIMARY KEY (id);


--
-- Name: hrm_employee_contracts hrm_employee_contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_contracts
    ADD CONSTRAINT hrm_employee_contracts_pkey PRIMARY KEY (id);


--
-- Name: hrm_employee_dependents hrm_employee_dependents_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_dependents
    ADD CONSTRAINT hrm_employee_dependents_pkey PRIMARY KEY (id);


--
-- Name: hrm_employee_history_setting hrm_employee_history_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_history_setting
    ADD CONSTRAINT hrm_employee_history_setting_pkey PRIMARY KEY (id);


--
-- Name: hrm_employee_informations hrm_employee_informations_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_informations
    ADD CONSTRAINT hrm_employee_informations_pkey PRIMARY KEY (id);


--
-- Name: hrm_employee_insurance_payment_histories hrm_employee_insurance_payment_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_insurance_payment_histories
    ADD CONSTRAINT hrm_employee_insurance_payment_histories_pkey PRIMARY KEY (id);


--
-- Name: hrm_employee_insurance_payments hrm_employee_insurance_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_insurance_payments
    ADD CONSTRAINT hrm_employee_insurance_payments_pkey PRIMARY KEY (id);


--
-- Name: hrm_employee_insurance_resolves hrm_employee_insurance_resolves_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_insurance_resolves
    ADD CONSTRAINT hrm_employee_insurance_resolves_pkey PRIMARY KEY (id);


--
-- Name: hrm_employee_insurances hrm_employee_insurances_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_insurances
    ADD CONSTRAINT hrm_employee_insurances_pkey PRIMARY KEY (id);


--
-- Name: hrm_employee_job_history hrm_employee_job_history_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_job_history
    ADD CONSTRAINT hrm_employee_job_history_pkey PRIMARY KEY (id);


--
-- Name: hrm_employee_layoff hrm_employee_layoff_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_layoff
    ADD CONSTRAINT hrm_employee_layoff_pkey PRIMARY KEY (id);


--
-- Name: hrm_employee_receive hrm_employee_receive_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_receive
    ADD CONSTRAINT hrm_employee_receive_pkey PRIMARY KEY (id);


--
-- Name: hrm_employee_salaries hrm_employee_salaries_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_employee_salaries
    ADD CONSTRAINT hrm_employee_salaries_pkey PRIMARY KEY (id);


--
-- Name: hrm_insurance_rate hrm_insurance_rate_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_insurance_rate
    ADD CONSTRAINT hrm_insurance_rate_pkey PRIMARY KEY (id);


--
-- Name: hrm_insurance_setting hrm_insurance_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_insurance_setting
    ADD CONSTRAINT hrm_insurance_setting_pkey PRIMARY KEY (id);


--
-- Name: hrm_job_position_level hrm_job_position_level_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_job_position_level
    ADD CONSTRAINT hrm_job_position_level_pkey PRIMARY KEY (id);


--
-- Name: hrm_job_position_title hrm_job_position_title_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_job_position_title
    ADD CONSTRAINT hrm_job_position_title_pkey PRIMARY KEY (id);


--
-- Name: hrm_job_positions hrm_job_positions_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_job_positions
    ADD CONSTRAINT hrm_job_positions_pkey PRIMARY KEY (id);


--
-- Name: hrm_penances hrm_penances_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_penances
    ADD CONSTRAINT hrm_penances_pkey PRIMARY KEY (id);


--
-- Name: hrm_personnel_profile hrm_personnel_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_personnel_profile
    ADD CONSTRAINT hrm_personnel_profile_pkey PRIMARY KEY (id);


--
-- Name: hrm_type_contract_allowances hrm_type_contract_allowances_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_type_contract_allowances
    ADD CONSTRAINT hrm_type_contract_allowances_pkey PRIMARY KEY (id);


--
-- Name: hrm_type_contract hrm_type_contract_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_type_contract
    ADD CONSTRAINT hrm_type_contract_pkey PRIMARY KEY (id);


--
-- Name: hrm_welfares hrm_welfares_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_welfares
    ADD CONSTRAINT hrm_welfares_pkey PRIMARY KEY (id);


--
-- Name: hrm_workplaces hrm_workplaces_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.hrm_workplaces
    ADD CONSTRAINT hrm_workplaces_pkey PRIMARY KEY (id);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: model_has_permissions model_has_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_pkey PRIMARY KEY (permission_id, model_id, model_type);


--
-- Name: model_has_roles model_has_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_pkey PRIMARY KEY (role_id, model_id, model_type);


--
-- Name: notify_notification_types notify_notification_types_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.notify_notification_types
    ADD CONSTRAINT notify_notification_types_pkey PRIMARY KEY (id);


--
-- Name: notify_notifications notify_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.notify_notifications
    ADD CONSTRAINT notify_notifications_pkey PRIMARY KEY (id);


--
-- Name: notify_user_notification notify_user_notification_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.notify_user_notification
    ADD CONSTRAINT notify_user_notification_pkey PRIMARY KEY (id);


--
-- Name: notify_user_setting_notification notify_user_setting_notification_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.notify_user_setting_notification
    ADD CONSTRAINT notify_user_setting_notification_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: permissions permissions_name_guard_name_unique; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_name_guard_name_unique UNIQUE (name, guard_name);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: portal_informations portal_informations_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.portal_informations
    ADD CONSTRAINT portal_informations_pkey PRIMARY KEY (id);


--
-- Name: portals portals_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.portals
    ADD CONSTRAINT portals_pkey PRIMARY KEY (id);


--
-- Name: role_has_permissions role_has_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_pkey PRIMARY KEY (permission_id, role_id);


--
-- Name: roles roles_name_guard_name_unique; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_guard_name_unique UNIQUE (name, guard_name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: tags_modules tags_modules_object_id_tag_id_module_unique; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.tags_modules
    ADD CONSTRAINT tags_modules_object_id_tag_id_module_unique UNIQUE (object_id, tag_id, module);


--
-- Name: tags_modules tags_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.tags_modules
    ADD CONSTRAINT tags_modules_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_unique; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_unique UNIQUE (username);


--
-- Name: work_project_groups work_project_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_project_groups
    ADD CONSTRAINT work_project_groups_pkey PRIMARY KEY (id);


--
-- Name: work_project_objects work_project_objects_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_project_objects
    ADD CONSTRAINT work_project_objects_pkey PRIMARY KEY (id);


--
-- Name: work_project_permissions work_project_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_project_permissions
    ADD CONSTRAINT work_project_permissions_pkey PRIMARY KEY (id);


--
-- Name: work_project_phases work_project_phases_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_project_phases
    ADD CONSTRAINT work_project_phases_pkey PRIMARY KEY (id);


--
-- Name: work_project_task_categories work_project_task_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_project_task_categories
    ADD CONSTRAINT work_project_task_categories_pkey PRIMARY KEY (id);


--
-- Name: work_projects work_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_projects
    ADD CONSTRAINT work_projects_pkey PRIMARY KEY (id);


--
-- Name: work_relation_objects work_relation_objects_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_relation_objects
    ADD CONSTRAINT work_relation_objects_pkey PRIMARY KEY (id);


--
-- Name: work_task_check_list work_task_check_list_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_task_check_list
    ADD CONSTRAINT work_task_check_list_pkey PRIMARY KEY (id);


--
-- Name: work_task_progress_reports work_task_progress_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_task_progress_reports
    ADD CONSTRAINT work_task_progress_reports_pkey PRIMARY KEY (id);


--
-- Name: work_task_review_reports work_task_review_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_task_review_reports
    ADD CONSTRAINT work_task_review_reports_pkey PRIMARY KEY (id);


--
-- Name: work_task_types work_task_types_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_task_types
    ADD CONSTRAINT work_task_types_pkey PRIMARY KEY (id);


--
-- Name: work_task_units work_task_units_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_task_units
    ADD CONSTRAINT work_task_units_pkey PRIMARY KEY (id);


--
-- Name: work_tasks work_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.work_tasks
    ADD CONSTRAINT work_tasks_pkey PRIMARY KEY (id);


--
-- Name: activity_log_log_name_index; Type: INDEX; Schema: public; Owner: tg_retrieval
--

CREATE INDEX activity_log_log_name_index ON public.activity_log USING btree (log_name);


--
-- Name: causer; Type: INDEX; Schema: public; Owner: tg_retrieval
--

CREATE INDEX causer ON public.activity_log USING btree (causer_type, causer_id);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: tg_retrieval
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: model_has_permissions_model_id_model_type_index; Type: INDEX; Schema: public; Owner: tg_retrieval
--

CREATE INDEX model_has_permissions_model_id_model_type_index ON public.model_has_permissions USING btree (model_id, model_type);


--
-- Name: model_has_roles_model_id_model_type_index; Type: INDEX; Schema: public; Owner: tg_retrieval
--

CREATE INDEX model_has_roles_model_id_model_type_index ON public.model_has_roles USING btree (model_id, model_type);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: tg_retrieval
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: tg_retrieval
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: tg_retrieval
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: subject; Type: INDEX; Schema: public; Owner: tg_retrieval
--

CREATE INDEX subject ON public.activity_log USING btree (subject_type, subject_id);


--
-- Name: work_relation_objects_model_type_model_id_index; Type: INDEX; Schema: public; Owner: tg_retrieval
--

CREATE INDEX work_relation_objects_model_type_model_id_index ON public.work_relation_objects USING btree (model_type, model_id);


--
-- Name: model_has_permissions model_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- Name: model_has_roles model_has_roles_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: role_has_permissions role_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- Name: role_has_permissions role_has_permissions_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tg_retrieval
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

