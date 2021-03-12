--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

--DROP DATABASE keycloak;




--
-- Drop roles
--

DROP ROLE keycloak;


--
-- Roles
--

CREATE ROLE keycloak;
ALTER ROLE keycloak WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md53665e4728566ea97857a44b3558b1426';






--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2 (Debian 13.2-1.pgdg100+1)
-- Dumped by pg_dump version 13.2 (Debian 13.2-1.pgdg100+1)
--
--SET statement_timeout = 0;
--SET lock_timeout = 0;
--SET idle_in_transaction_session_timeout = 0;
--SET client_encoding = 'UTF8';
--SET standard_conforming_strings = on;
--SELECT pg_catalog.set_config('search_path', '', false);
--SET check_function_bodies = false;
--SET xmloption = content;
--SET client_min_messages = warning;
--SET row_security = off;
--
--UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
--DROP DATABASE template1;
----
---- Name: template1; Type: DATABASE; Schema: -; Owner: keycloak
----
--
--CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';
--
--
--ALTER DATABASE template1 OWNER TO keycloak;
--
--\connect template1
--
--SET statement_timeout = 0;
--SET lock_timeout = 0;
--SET idle_in_transaction_session_timeout = 0;
--SET client_encoding = 'UTF8';
--SET standard_conforming_strings = on;
--SELECT pg_catalog.set_config('search_path', '', false);
--SET check_function_bodies = false;
--SET xmloption = content;
--SET client_min_messages = warning;
--SET row_security = off;
--
----
---- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: keycloak
----
--
--COMMENT ON DATABASE template1 IS 'default template for new databases';
--
--
----
---- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: keycloak
----
--
--ALTER DATABASE template1 IS_TEMPLATE = true;
--
--
--\connect template1
--
--SET statement_timeout = 0;
--SET lock_timeout = 0;
--SET idle_in_transaction_session_timeout = 0;
--SET client_encoding = 'UTF8';
--SET standard_conforming_strings = on;
--SELECT pg_catalog.set_config('search_path', '', false);
--SET check_function_bodies = false;
--SET xmloption = content;
--SET client_min_messages = warning;
--SET row_security = off;
--
----
---- Name: DATABASE template1; Type: ACL; Schema: -; Owner: keycloak
----
--
--REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
--GRANT CONNECT ON DATABASE template1 TO PUBLIC;
--
--
----
-- PostgreSQL database dump complete
--

--
-- Database "keycloak" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2 (Debian 13.2-1.pgdg100+1)
-- Dumped by pg_dump version 13.2 (Debian 13.2-1.pgdg100+1)

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
-- Name: keycloak; Type: DATABASE; Schema: -; Owner: keycloak
--

CREATE DATABASE keycloak WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE keycloak OWNER TO keycloak;

\connect keycloak

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_default_roles; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_default_roles (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_default_roles OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_default_roles; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_roles (
    realm_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_roles OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
37f47ecd-2fa5-4257-9d1a-ec1ffb08f5bb	\N	auth-cookie	master	fdad8163-b72d-4d95-98dc-8b34d8981926	2	10	f	\N	\N
b5b795f3-dc99-4a74-b08a-e5ff930b791a	\N	auth-spnego	master	fdad8163-b72d-4d95-98dc-8b34d8981926	3	20	f	\N	\N
861e2bed-b755-4058-a53e-3aeeda511e6d	\N	identity-provider-redirector	master	fdad8163-b72d-4d95-98dc-8b34d8981926	2	25	f	\N	\N
09133a2b-28fd-428e-911f-c642298601f3	\N	\N	master	fdad8163-b72d-4d95-98dc-8b34d8981926	2	30	t	8a559617-a563-4856-a938-d396483b9226	\N
7ff8b5d2-878d-44e8-bdf2-5cea95f74e06	\N	auth-username-password-form	master	8a559617-a563-4856-a938-d396483b9226	0	10	f	\N	\N
19c847c6-bd35-4673-a151-3c5ecf65b2f2	\N	\N	master	8a559617-a563-4856-a938-d396483b9226	1	20	t	e4aaae13-5b6a-44bf-81d2-f705388e38c2	\N
24adc9fd-5822-4daa-ab05-bfef8f77667a	\N	conditional-user-configured	master	e4aaae13-5b6a-44bf-81d2-f705388e38c2	0	10	f	\N	\N
bfefe560-cd95-47a5-acb2-6a83da9a751f	\N	auth-otp-form	master	e4aaae13-5b6a-44bf-81d2-f705388e38c2	0	20	f	\N	\N
ff4a8c8a-89c6-4d52-8831-0fdb01639337	\N	direct-grant-validate-username	master	5906f44e-1e13-463e-a1c4-f3d32235996e	0	10	f	\N	\N
b35f0882-d139-4d49-ba58-1c50c8bff57a	\N	direct-grant-validate-password	master	5906f44e-1e13-463e-a1c4-f3d32235996e	0	20	f	\N	\N
75c42cab-f6ba-4815-ac3a-09e6e6dc79e0	\N	\N	master	5906f44e-1e13-463e-a1c4-f3d32235996e	1	30	t	f739c7be-03a1-4cf0-97db-5134294c7824	\N
00288c8e-e06e-430b-9af7-b719bcc0aa0c	\N	conditional-user-configured	master	f739c7be-03a1-4cf0-97db-5134294c7824	0	10	f	\N	\N
606c4d76-c1ae-4039-ab3b-2cf50ccbdae9	\N	direct-grant-validate-otp	master	f739c7be-03a1-4cf0-97db-5134294c7824	0	20	f	\N	\N
0d21c3f1-fdfe-414e-aab3-2851608828cc	\N	registration-page-form	master	44812a01-cfe5-4377-bc50-d80f6a79d07e	0	10	t	548b0305-7713-422b-a8db-ba7cd98b3c2b	\N
01309b51-8c9d-426d-a84c-44835af0b9f5	\N	registration-user-creation	master	548b0305-7713-422b-a8db-ba7cd98b3c2b	0	20	f	\N	\N
de7da9c1-1cb5-4c4e-bef0-fe7c26d404c5	\N	registration-profile-action	master	548b0305-7713-422b-a8db-ba7cd98b3c2b	0	40	f	\N	\N
09e5580a-7503-47f6-a181-b1223501d965	\N	registration-password-action	master	548b0305-7713-422b-a8db-ba7cd98b3c2b	0	50	f	\N	\N
f8f3d21a-f981-4f0a-9ed5-288ad89f8c36	\N	registration-recaptcha-action	master	548b0305-7713-422b-a8db-ba7cd98b3c2b	3	60	f	\N	\N
1408b176-091d-4d9a-b0bd-a8cf06c614bf	\N	reset-credentials-choose-user	master	fa2de638-411a-4a68-8973-e0b521e7274c	0	10	f	\N	\N
d9216c95-8f5f-40a2-9739-c1142322fbe4	\N	reset-credential-email	master	fa2de638-411a-4a68-8973-e0b521e7274c	0	20	f	\N	\N
5da34847-e830-47ca-b2c2-5bc77da507c0	\N	reset-password	master	fa2de638-411a-4a68-8973-e0b521e7274c	0	30	f	\N	\N
6a409565-4222-407e-aaba-c34788e0d44f	\N	\N	master	fa2de638-411a-4a68-8973-e0b521e7274c	1	40	t	c797ad89-bfe2-4365-ade3-c79125862fc5	\N
478289a3-ec61-4ede-a840-119d4805a2b0	\N	conditional-user-configured	master	c797ad89-bfe2-4365-ade3-c79125862fc5	0	10	f	\N	\N
7be2a2be-5031-4e52-968d-e1dc36fca622	\N	reset-otp	master	c797ad89-bfe2-4365-ade3-c79125862fc5	0	20	f	\N	\N
31c3e53c-3062-4700-b287-ff0ba59a79cc	\N	client-secret	master	161cfb4d-5e6f-4036-9160-e01ec28f7825	2	10	f	\N	\N
a41e800a-0e7c-4a88-90e3-2ba6c8fe96bc	\N	client-jwt	master	161cfb4d-5e6f-4036-9160-e01ec28f7825	2	20	f	\N	\N
fb0da63a-c64c-4e6e-b26d-d9ff552a351c	\N	client-secret-jwt	master	161cfb4d-5e6f-4036-9160-e01ec28f7825	2	30	f	\N	\N
e3ae49c3-d5ac-4f8a-ac79-7fb5e84dc72d	\N	client-x509	master	161cfb4d-5e6f-4036-9160-e01ec28f7825	2	40	f	\N	\N
fb65227f-ad66-488e-8764-a3ba3f50b0d7	\N	idp-review-profile	master	59db841c-0251-4af5-9c19-12e5a2b2cafa	0	10	f	\N	3f529d3c-b7e1-4b48-aae0-51c3aa267794
94924001-4d5b-4ace-b5cd-422ced959516	\N	\N	master	59db841c-0251-4af5-9c19-12e5a2b2cafa	0	20	t	e8ace813-7c04-4c6b-96f2-8f4a30a1837f	\N
0b7a7adb-2eee-47c0-b2df-33535d3784e6	\N	idp-create-user-if-unique	master	e8ace813-7c04-4c6b-96f2-8f4a30a1837f	2	10	f	\N	079a97ee-cafc-4810-a0a6-fe3f9eab5959
8a8ece72-6419-4d34-9170-04babfb9c286	\N	\N	master	e8ace813-7c04-4c6b-96f2-8f4a30a1837f	2	20	t	1f093ade-8dda-43ea-a1ad-21ea8a3c6d5c	\N
f9a98adf-8d0a-48fb-bd00-6580e6ee0aa2	\N	idp-confirm-link	master	1f093ade-8dda-43ea-a1ad-21ea8a3c6d5c	0	10	f	\N	\N
7f93106d-89dd-4e42-aac9-d11ae890f3bd	\N	\N	master	1f093ade-8dda-43ea-a1ad-21ea8a3c6d5c	0	20	t	2e671260-b38d-4564-8116-b4d68fb15af0	\N
ed676fb6-b4d2-4d44-bb9f-ecc32ffad4f8	\N	idp-email-verification	master	2e671260-b38d-4564-8116-b4d68fb15af0	2	10	f	\N	\N
477f3e84-7b11-40b1-8d11-89f74f747aa1	\N	\N	master	2e671260-b38d-4564-8116-b4d68fb15af0	2	20	t	2c2ad407-567d-4384-9e72-35f3c5099419	\N
996649ba-5197-49a8-8af8-a66e6b6de23f	\N	idp-username-password-form	master	2c2ad407-567d-4384-9e72-35f3c5099419	0	10	f	\N	\N
21cd8c06-066c-4929-9297-e3a7f3dce874	\N	\N	master	2c2ad407-567d-4384-9e72-35f3c5099419	1	20	t	760692cb-9cbb-4955-ba00-0e487048968f	\N
b4efb8b0-1f57-4f78-93c0-55ff7e703ff2	\N	conditional-user-configured	master	760692cb-9cbb-4955-ba00-0e487048968f	0	10	f	\N	\N
13988098-0ce7-4b76-970f-0cc753f02f53	\N	auth-otp-form	master	760692cb-9cbb-4955-ba00-0e487048968f	0	20	f	\N	\N
120e2718-2050-4c68-8f1a-f9efa72ca177	\N	http-basic-authenticator	master	9ce7f451-ba4f-4444-9f1e-ff42184e495b	0	10	f	\N	\N
03f19b12-3564-4602-a467-b6a0fdfeac3f	\N	docker-http-basic-authenticator	master	89129de5-51ca-4651-8d52-18ec6a510398	0	10	f	\N	\N
b946e9f9-2b06-4ee0-aa36-d10c361aa565	\N	no-cookie-redirect	master	69cdd816-ca8c-48b9-9cd7-7ab3840631c9	0	10	f	\N	\N
366a0922-49bf-4d75-91f6-8ab063e20d07	\N	\N	master	69cdd816-ca8c-48b9-9cd7-7ab3840631c9	0	20	t	1abe1b16-b2fe-4afa-9e1f-3f31de4685bc	\N
41bcc1c2-5a35-447e-bf46-61771af66115	\N	basic-auth	master	1abe1b16-b2fe-4afa-9e1f-3f31de4685bc	0	10	f	\N	\N
7e19dda4-80a3-4ff5-b73d-2068960fc204	\N	basic-auth-otp	master	1abe1b16-b2fe-4afa-9e1f-3f31de4685bc	3	20	f	\N	\N
0a2ffbd9-3e84-4d81-a091-1f22d6e5f44c	\N	auth-spnego	master	1abe1b16-b2fe-4afa-9e1f-3f31de4685bc	3	30	f	\N	\N
aec6ab0f-82f6-4857-9235-8aea2e7083be	\N	auth-cookie	Questboard	5ccee21d-5830-4d81-b3bc-0813915154ce	2	10	f	\N	\N
7fdaf0ed-75ca-48e0-814e-493ad296ce0c	\N	auth-spnego	Questboard	5ccee21d-5830-4d81-b3bc-0813915154ce	3	20	f	\N	\N
cc3bc6a8-3c89-4839-ae8b-a3c19cee6bc3	\N	identity-provider-redirector	Questboard	5ccee21d-5830-4d81-b3bc-0813915154ce	2	25	f	\N	\N
2e2eed28-3a47-4368-822b-d7bc54c127ca	\N	\N	Questboard	5ccee21d-5830-4d81-b3bc-0813915154ce	2	30	t	52d0637b-b3ba-4bf8-91dc-e5f2ce5e7281	\N
93cb94de-a712-46b2-9479-85e280594382	\N	auth-username-password-form	Questboard	52d0637b-b3ba-4bf8-91dc-e5f2ce5e7281	0	10	f	\N	\N
69d753ce-60a6-4326-90ab-bf22b991a72d	\N	\N	Questboard	52d0637b-b3ba-4bf8-91dc-e5f2ce5e7281	1	20	t	10b8bfbb-eb2d-4969-a536-d2252ff21fed	\N
2080801e-c29a-4af3-a1ec-de594bcaf134	\N	conditional-user-configured	Questboard	10b8bfbb-eb2d-4969-a536-d2252ff21fed	0	10	f	\N	\N
21253f54-272a-4d00-83f1-22bdd7a0214f	\N	auth-otp-form	Questboard	10b8bfbb-eb2d-4969-a536-d2252ff21fed	0	20	f	\N	\N
0e2ea0ff-dcd0-43e0-a4c6-b4a31759b4eb	\N	direct-grant-validate-username	Questboard	27df431e-3093-4a42-94d9-2142eeb472b7	0	10	f	\N	\N
15b87f1d-563f-452d-b8ec-0fdd06183bf0	\N	direct-grant-validate-password	Questboard	27df431e-3093-4a42-94d9-2142eeb472b7	0	20	f	\N	\N
bc8821ee-c47f-4ee3-bd5a-98acc85b5365	\N	\N	Questboard	27df431e-3093-4a42-94d9-2142eeb472b7	1	30	t	6879c743-62c0-411f-93b2-22fac81d1395	\N
958e92c4-ddf0-4fbd-a365-b43d8d40272d	\N	conditional-user-configured	Questboard	6879c743-62c0-411f-93b2-22fac81d1395	0	10	f	\N	\N
460577e6-4e06-463d-b027-d0ca60247ba8	\N	direct-grant-validate-otp	Questboard	6879c743-62c0-411f-93b2-22fac81d1395	0	20	f	\N	\N
7a944ee6-221a-4efd-957f-02b57ac582ca	\N	registration-page-form	Questboard	3474f741-cae1-4457-a200-ec235b3c79e5	0	10	t	28cad4c7-feb4-4560-bda0-3d3d2a00c612	\N
41d8c6bc-6771-4f79-ab5f-cf0b3d650095	\N	registration-user-creation	Questboard	28cad4c7-feb4-4560-bda0-3d3d2a00c612	0	20	f	\N	\N
b53b65cb-36b5-4211-baec-a0906f408405	\N	registration-profile-action	Questboard	28cad4c7-feb4-4560-bda0-3d3d2a00c612	0	40	f	\N	\N
3d681d63-a0ee-4628-9f49-31b632c39cb3	\N	registration-password-action	Questboard	28cad4c7-feb4-4560-bda0-3d3d2a00c612	0	50	f	\N	\N
e85dbeca-bfa6-4bc3-bd1e-16af11d6fbdd	\N	registration-recaptcha-action	Questboard	28cad4c7-feb4-4560-bda0-3d3d2a00c612	3	60	f	\N	\N
2e29160a-f431-4488-b597-897b1eccb863	\N	reset-credentials-choose-user	Questboard	23c8b7cf-7406-4094-9ff0-03951ddc1fe8	0	10	f	\N	\N
21b2c2fe-625e-407e-9c21-fa91f9d70607	\N	reset-credential-email	Questboard	23c8b7cf-7406-4094-9ff0-03951ddc1fe8	0	20	f	\N	\N
ebcca2c3-855e-44d5-bb88-211f6f57b363	\N	reset-password	Questboard	23c8b7cf-7406-4094-9ff0-03951ddc1fe8	0	30	f	\N	\N
2fce764f-6a18-4f04-b874-5d40b661da28	\N	\N	Questboard	23c8b7cf-7406-4094-9ff0-03951ddc1fe8	1	40	t	297521f1-0327-48ce-893c-19f006e76e0d	\N
ebf037e3-befe-4676-b047-31b6b47bff37	\N	conditional-user-configured	Questboard	297521f1-0327-48ce-893c-19f006e76e0d	0	10	f	\N	\N
722a3820-1af8-40fa-942e-5fa1979f639e	\N	reset-otp	Questboard	297521f1-0327-48ce-893c-19f006e76e0d	0	20	f	\N	\N
2e0b8cec-3756-4cdb-9d7b-f189c0dcc379	\N	client-secret	Questboard	f4d06149-75af-41ff-821f-f3be8c2fc6c3	2	10	f	\N	\N
1e2a73f7-022b-4bd7-a016-11809ed6f9d9	\N	client-jwt	Questboard	f4d06149-75af-41ff-821f-f3be8c2fc6c3	2	20	f	\N	\N
458be1f6-aef8-41d1-83d5-544c9b1b7a7d	\N	client-secret-jwt	Questboard	f4d06149-75af-41ff-821f-f3be8c2fc6c3	2	30	f	\N	\N
5b2cb930-b5e3-422d-9332-3f3b963b1e91	\N	client-x509	Questboard	f4d06149-75af-41ff-821f-f3be8c2fc6c3	2	40	f	\N	\N
e00b3a70-d640-4c93-9156-0e6582afd36d	\N	idp-review-profile	Questboard	a685ee43-d4f0-463a-a91e-9bde1be08949	0	10	f	\N	8d46d7dc-a0f9-46c8-b323-d9857fc28c66
c78a8651-b77f-4926-abad-54a363f66b13	\N	\N	Questboard	a685ee43-d4f0-463a-a91e-9bde1be08949	0	20	t	935b4f00-65ab-4c83-9803-92006d0b3859	\N
82cce0c6-5289-42d4-b016-b8ff7ed4eba1	\N	idp-create-user-if-unique	Questboard	935b4f00-65ab-4c83-9803-92006d0b3859	2	10	f	\N	36912895-573e-45cb-a9b4-063db74a262b
fa55424b-d68d-460c-9329-0f21754743f0	\N	\N	Questboard	935b4f00-65ab-4c83-9803-92006d0b3859	2	20	t	17b89420-92ab-48ec-a6e3-a05e63202a59	\N
68c5bca8-4edc-47d0-88a2-75080e269ecb	\N	idp-confirm-link	Questboard	17b89420-92ab-48ec-a6e3-a05e63202a59	0	10	f	\N	\N
991a20cf-ec6d-47ef-aaf1-87033f4ddb85	\N	\N	Questboard	17b89420-92ab-48ec-a6e3-a05e63202a59	0	20	t	ca813230-ad71-4ca7-9e9b-e8d99b3d2b4a	\N
57d16044-e0f7-4116-a766-09f9666268b4	\N	idp-email-verification	Questboard	ca813230-ad71-4ca7-9e9b-e8d99b3d2b4a	2	10	f	\N	\N
06c00ec2-7488-4b5e-9ee6-c9d19115dcbb	\N	\N	Questboard	ca813230-ad71-4ca7-9e9b-e8d99b3d2b4a	2	20	t	0c3670a4-5216-464c-bd37-5d096710ee55	\N
a59c1ab0-a55c-4fc6-88e3-297191c7f9e1	\N	idp-username-password-form	Questboard	0c3670a4-5216-464c-bd37-5d096710ee55	0	10	f	\N	\N
5182f9e9-9f81-4419-8cff-31bdf1e8a8a2	\N	\N	Questboard	0c3670a4-5216-464c-bd37-5d096710ee55	1	20	t	54c45af5-9cd5-41b9-952e-45591438bc1d	\N
f5a4f66f-ba9c-467e-8982-2a0db371d728	\N	conditional-user-configured	Questboard	54c45af5-9cd5-41b9-952e-45591438bc1d	0	10	f	\N	\N
94610933-969c-4116-bcfb-69b4910dab2e	\N	auth-otp-form	Questboard	54c45af5-9cd5-41b9-952e-45591438bc1d	0	20	f	\N	\N
f1642821-48a4-4144-b084-0fbb7f56f7dd	\N	http-basic-authenticator	Questboard	43cc2472-bc43-4eb5-a984-95d147cf1183	0	10	f	\N	\N
840d2da5-95ee-4724-a80a-3549db942255	\N	docker-http-basic-authenticator	Questboard	1f8742dc-142e-4cc4-8629-0a7d323588de	0	10	f	\N	\N
3e1274a6-a494-4702-b95f-c7dd9e63dd56	\N	no-cookie-redirect	Questboard	e985616a-4a97-4259-a571-c94dc2393b0b	0	10	f	\N	\N
9b58ddef-aaeb-43d3-ab7e-2ce0a6b37af9	\N	\N	Questboard	e985616a-4a97-4259-a571-c94dc2393b0b	0	20	t	f73e7c1d-a36f-4831-aed6-8c3731038c56	\N
ce9a49ae-4efd-4278-b3f4-aa6c9d7e090f	\N	basic-auth	Questboard	f73e7c1d-a36f-4831-aed6-8c3731038c56	0	10	f	\N	\N
dcd1d67d-cf4c-4848-b3b7-66e79b100ccd	\N	basic-auth-otp	Questboard	f73e7c1d-a36f-4831-aed6-8c3731038c56	3	20	f	\N	\N
3fae3995-aa8f-4f60-9d13-667ec036678a	\N	auth-spnego	Questboard	f73e7c1d-a36f-4831-aed6-8c3731038c56	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
fdad8163-b72d-4d95-98dc-8b34d8981926	browser	browser based authentication	master	basic-flow	t	t
8a559617-a563-4856-a938-d396483b9226	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
e4aaae13-5b6a-44bf-81d2-f705388e38c2	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
5906f44e-1e13-463e-a1c4-f3d32235996e	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
f739c7be-03a1-4cf0-97db-5134294c7824	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
44812a01-cfe5-4377-bc50-d80f6a79d07e	registration	registration flow	master	basic-flow	t	t
548b0305-7713-422b-a8db-ba7cd98b3c2b	registration form	registration form	master	form-flow	f	t
fa2de638-411a-4a68-8973-e0b521e7274c	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
c797ad89-bfe2-4365-ade3-c79125862fc5	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
161cfb4d-5e6f-4036-9160-e01ec28f7825	clients	Base authentication for clients	master	client-flow	t	t
59db841c-0251-4af5-9c19-12e5a2b2cafa	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
e8ace813-7c04-4c6b-96f2-8f4a30a1837f	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
1f093ade-8dda-43ea-a1ad-21ea8a3c6d5c	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
2e671260-b38d-4564-8116-b4d68fb15af0	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
2c2ad407-567d-4384-9e72-35f3c5099419	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
760692cb-9cbb-4955-ba00-0e487048968f	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
9ce7f451-ba4f-4444-9f1e-ff42184e495b	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
89129de5-51ca-4651-8d52-18ec6a510398	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
69cdd816-ca8c-48b9-9cd7-7ab3840631c9	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
1abe1b16-b2fe-4afa-9e1f-3f31de4685bc	Authentication Options	Authentication options.	master	basic-flow	f	t
5ccee21d-5830-4d81-b3bc-0813915154ce	browser	browser based authentication	Questboard	basic-flow	t	t
52d0637b-b3ba-4bf8-91dc-e5f2ce5e7281	forms	Username, password, otp and other auth forms.	Questboard	basic-flow	f	t
10b8bfbb-eb2d-4969-a536-d2252ff21fed	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	Questboard	basic-flow	f	t
27df431e-3093-4a42-94d9-2142eeb472b7	direct grant	OpenID Connect Resource Owner Grant	Questboard	basic-flow	t	t
6879c743-62c0-411f-93b2-22fac81d1395	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	Questboard	basic-flow	f	t
3474f741-cae1-4457-a200-ec235b3c79e5	registration	registration flow	Questboard	basic-flow	t	t
28cad4c7-feb4-4560-bda0-3d3d2a00c612	registration form	registration form	Questboard	form-flow	f	t
23c8b7cf-7406-4094-9ff0-03951ddc1fe8	reset credentials	Reset credentials for a user if they forgot their password or something	Questboard	basic-flow	t	t
297521f1-0327-48ce-893c-19f006e76e0d	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	Questboard	basic-flow	f	t
f4d06149-75af-41ff-821f-f3be8c2fc6c3	clients	Base authentication for clients	Questboard	client-flow	t	t
a685ee43-d4f0-463a-a91e-9bde1be08949	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	Questboard	basic-flow	t	t
935b4f00-65ab-4c83-9803-92006d0b3859	User creation or linking	Flow for the existing/non-existing user alternatives	Questboard	basic-flow	f	t
17b89420-92ab-48ec-a6e3-a05e63202a59	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	Questboard	basic-flow	f	t
ca813230-ad71-4ca7-9e9b-e8d99b3d2b4a	Account verification options	Method with which to verity the existing account	Questboard	basic-flow	f	t
0c3670a4-5216-464c-bd37-5d096710ee55	Verify Existing Account by Re-authentication	Reauthentication of existing account	Questboard	basic-flow	f	t
54c45af5-9cd5-41b9-952e-45591438bc1d	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	Questboard	basic-flow	f	t
43cc2472-bc43-4eb5-a984-95d147cf1183	saml ecp	SAML ECP Profile Authentication Flow	Questboard	basic-flow	t	t
1f8742dc-142e-4cc4-8629-0a7d323588de	docker auth	Used by Docker clients to authenticate against the IDP	Questboard	basic-flow	t	t
e985616a-4a97-4259-a571-c94dc2393b0b	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	Questboard	basic-flow	t	t
f73e7c1d-a36f-4831-aed6-8c3731038c56	Authentication Options	Authentication options.	Questboard	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
3f529d3c-b7e1-4b48-aae0-51c3aa267794	review profile config	master
079a97ee-cafc-4810-a0a6-fe3f9eab5959	create unique user config	master
8d46d7dc-a0f9-46c8-b323-d9857fc28c66	review profile config	Questboard
36912895-573e-45cb-a9b4-063db74a262b	create unique user config	Questboard
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
3f529d3c-b7e1-4b48-aae0-51c3aa267794	missing	update.profile.on.first.login
079a97ee-cafc-4810-a0a6-fe3f9eab5959	false	require.password.update.after.registration
8d46d7dc-a0f9-46c8-b323-d9857fc28c66	missing	update.profile.on.first.login
36912895-573e-45cb-a9b4-063db74a262b	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	t	t	master-realm	0	f	fef25039-ed83-4216-ab70-f4b5fa708797	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
08c97ad9-d906-4644-93bd-ea0584cad180	t	f	account	0	f	e7ce68ae-787a-45c1-8495-373e59671c4d	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
abab6a4a-5863-456c-8348-10e029a86820	t	f	account-console	0	t	bd5a0b1b-ac19-4e95-ae5a-6dae82e53eef	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
902b311b-ba7d-46ce-acdb-6eb9e3136b2c	t	f	broker	0	f	7b8ea809-f66f-4350-b275-703cd0614283	\N	f	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
d1055f6d-d48d-4be5-a2de-f748e592a2a3	t	f	security-admin-console	0	t	c7d7345c-3e97-4fd8-8a1d-e27d34e19a72	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
0e7ebee3-9aca-42f0-bcd2-eff6bf8854e3	t	f	admin-cli	0	t	a3cb21fd-eb6f-40f1-9c19-5ce7c93404a4	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
ac07db7f-2cc1-4841-876b-40b8516f39f9	t	t	Questboard-realm	0	f	556e026f-16c6-4451-b33b-a0b5f5cc8825	\N	t	\N	f	master	\N	0	f	f	Questboard Realm	f	client-secret	\N	\N	\N	t	f	f	f
b8d50ca6-d208-439e-9f34-31f53efdb740	t	f	realm-management	0	f	4c172865-82ef-4024-a814-292347a5919f	\N	t	\N	f	Questboard	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
52bd5914-a6e4-4757-87dd-effc52813817	t	f	account	0	f	933822f0-59e4-47ee-b01d-30c4d3fd1a2e	/realms/Questboard/account/	f	\N	f	Questboard	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
79f4d5db-6766-48a6-a093-1a8d5b48c2ff	t	f	account-console	0	t	84f8c8d3-31bd-403d-bc17-607b6172b2eb	/realms/Questboard/account/	f	\N	f	Questboard	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
5b51b2e4-dcda-44db-ac85-8b24fc91dbf4	t	f	broker	0	f	d5e80cae-7b97-4aff-a593-41092881611f	\N	f	\N	f	Questboard	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
94f39d5d-d7f4-419b-a7dc-32c526849238	t	f	security-admin-console	0	t	331ddfa9-8076-49cd-8514-c46ba45b829b	/admin/Questboard/console/	f	\N	f	Questboard	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
209db2ca-dd49-4b6d-b06a-f8029c07322d	t	f	admin-cli	0	t	d1b69d2b-a7f4-4152-a993-8bc15b58cd40	\N	f	\N	f	Questboard	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
95468c3a-ced2-4a92-84cb-64fe8c289298	t	t	questboard-mobile-client	0	f	6b28fbc6-e4d2-4033-9525-7cd9fa38faa8	\N	f	\N	f	Questboard	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
abab6a4a-5863-456c-8348-10e029a86820	S256	pkce.code.challenge.method
d1055f6d-d48d-4be5-a2de-f748e592a2a3	S256	pkce.code.challenge.method
79f4d5db-6766-48a6-a093-1a8d5b48c2ff	S256	pkce.code.challenge.method
94f39d5d-d7f4-419b-a7dc-32c526849238	S256	pkce.code.challenge.method
95468c3a-ced2-4a92-84cb-64fe8c289298	true	backchannel.logout.session.required
95468c3a-ced2-4a92-84cb-64fe8c289298	false	backchannel.logout.revoke.offline.tokens
95468c3a-ced2-4a92-84cb-64fe8c289298	\N	request.uris
95468c3a-ced2-4a92-84cb-64fe8c289298	false	saml.server.signature
95468c3a-ced2-4a92-84cb-64fe8c289298	false	saml.server.signature.keyinfo.ext
95468c3a-ced2-4a92-84cb-64fe8c289298	false	saml.assertion.signature
95468c3a-ced2-4a92-84cb-64fe8c289298	false	saml.client.signature
95468c3a-ced2-4a92-84cb-64fe8c289298	false	saml.encrypt
95468c3a-ced2-4a92-84cb-64fe8c289298	false	saml.authnstatement
95468c3a-ced2-4a92-84cb-64fe8c289298	false	saml.onetimeuse.condition
95468c3a-ced2-4a92-84cb-64fe8c289298	false	saml_force_name_id_format
95468c3a-ced2-4a92-84cb-64fe8c289298	false	saml.multivalued.roles
95468c3a-ced2-4a92-84cb-64fe8c289298	false	saml.force.post.binding
95468c3a-ced2-4a92-84cb-64fe8c289298	false	exclude.session.state.from.auth.response
95468c3a-ced2-4a92-84cb-64fe8c289298	false	tls.client.certificate.bound.access.tokens
95468c3a-ced2-4a92-84cb-64fe8c289298	false	client_credentials.use_refresh_token
95468c3a-ced2-4a92-84cb-64fe8c289298	false	display.on.consent.screen
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_default_roles; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_default_roles (client_id, role_id) FROM stdin;
08c97ad9-d906-4644-93bd-ea0584cad180	5e09a80d-c6b5-42dd-8e13-48f529df7d9e
08c97ad9-d906-4644-93bd-ea0584cad180	f4b1ad07-5b38-4249-8e82-73052a099da7
52bd5914-a6e4-4757-87dd-effc52813817	c49ec061-2d19-4bd7-b738-3c79e7cb0f16
52bd5914-a6e4-4757-87dd-effc52813817	923a0957-09f1-47bf-b886-c2fa0814c72a
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
f2e0037f-d017-46e1-a034-177801c83b23	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
debc63ab-26ff-4018-ae1c-f462aac09707	role_list	master	SAML role list	saml
b1388f1c-be05-48bd-8894-5d95938b7029	profile	master	OpenID Connect built-in scope: profile	openid-connect
d7f05291-7b53-4e6f-a23b-daf00836d7b0	email	master	OpenID Connect built-in scope: email	openid-connect
6a58d7df-17f4-414a-86c8-6697407326c4	address	master	OpenID Connect built-in scope: address	openid-connect
a966db78-54e2-4b5c-9339-7818843e8506	phone	master	OpenID Connect built-in scope: phone	openid-connect
991d255e-b06f-41b2-83c7-7d7071146643	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
f971b5a7-ae3c-46b0-8af1-142fe807bee3	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
27c23296-0cc2-4ac2-8c19-2a73253fc3d0	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
b786462d-167d-4c4e-b790-3d580a2f19dc	offline_access	Questboard	OpenID Connect built-in scope: offline_access	openid-connect
8452362d-b836-468b-b0ab-76b4885f3632	role_list	Questboard	SAML role list	saml
c5661577-386a-4a48-a981-e0207e71de5c	profile	Questboard	OpenID Connect built-in scope: profile	openid-connect
8250b6ca-1b2a-4521-a2f5-06d48a852ec5	email	Questboard	OpenID Connect built-in scope: email	openid-connect
8e2861df-d0c1-4db3-9905-54159988842e	address	Questboard	OpenID Connect built-in scope: address	openid-connect
1975efcb-e81b-4ed5-bc0c-c06192d9abca	phone	Questboard	OpenID Connect built-in scope: phone	openid-connect
cd23a4c9-cf82-4fa7-b0b9-a9ed75b5c668	roles	Questboard	OpenID Connect scope for add user roles to the access token	openid-connect
0a1f7157-db6a-437a-9a01-7f078f22a08e	web-origins	Questboard	OpenID Connect scope for add allowed web origins to the access token	openid-connect
b3082110-1d80-4c36-8f92-0639e7fe8aea	microprofile-jwt	Questboard	Microprofile - JWT built-in scope	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
f2e0037f-d017-46e1-a034-177801c83b23	true	display.on.consent.screen
f2e0037f-d017-46e1-a034-177801c83b23	${offlineAccessScopeConsentText}	consent.screen.text
debc63ab-26ff-4018-ae1c-f462aac09707	true	display.on.consent.screen
debc63ab-26ff-4018-ae1c-f462aac09707	${samlRoleListScopeConsentText}	consent.screen.text
b1388f1c-be05-48bd-8894-5d95938b7029	true	display.on.consent.screen
b1388f1c-be05-48bd-8894-5d95938b7029	${profileScopeConsentText}	consent.screen.text
b1388f1c-be05-48bd-8894-5d95938b7029	true	include.in.token.scope
d7f05291-7b53-4e6f-a23b-daf00836d7b0	true	display.on.consent.screen
d7f05291-7b53-4e6f-a23b-daf00836d7b0	${emailScopeConsentText}	consent.screen.text
d7f05291-7b53-4e6f-a23b-daf00836d7b0	true	include.in.token.scope
6a58d7df-17f4-414a-86c8-6697407326c4	true	display.on.consent.screen
6a58d7df-17f4-414a-86c8-6697407326c4	${addressScopeConsentText}	consent.screen.text
6a58d7df-17f4-414a-86c8-6697407326c4	true	include.in.token.scope
a966db78-54e2-4b5c-9339-7818843e8506	true	display.on.consent.screen
a966db78-54e2-4b5c-9339-7818843e8506	${phoneScopeConsentText}	consent.screen.text
a966db78-54e2-4b5c-9339-7818843e8506	true	include.in.token.scope
991d255e-b06f-41b2-83c7-7d7071146643	true	display.on.consent.screen
991d255e-b06f-41b2-83c7-7d7071146643	${rolesScopeConsentText}	consent.screen.text
991d255e-b06f-41b2-83c7-7d7071146643	false	include.in.token.scope
f971b5a7-ae3c-46b0-8af1-142fe807bee3	false	display.on.consent.screen
f971b5a7-ae3c-46b0-8af1-142fe807bee3		consent.screen.text
f971b5a7-ae3c-46b0-8af1-142fe807bee3	false	include.in.token.scope
27c23296-0cc2-4ac2-8c19-2a73253fc3d0	false	display.on.consent.screen
27c23296-0cc2-4ac2-8c19-2a73253fc3d0	true	include.in.token.scope
b786462d-167d-4c4e-b790-3d580a2f19dc	true	display.on.consent.screen
b786462d-167d-4c4e-b790-3d580a2f19dc	${offlineAccessScopeConsentText}	consent.screen.text
8452362d-b836-468b-b0ab-76b4885f3632	true	display.on.consent.screen
8452362d-b836-468b-b0ab-76b4885f3632	${samlRoleListScopeConsentText}	consent.screen.text
c5661577-386a-4a48-a981-e0207e71de5c	true	display.on.consent.screen
c5661577-386a-4a48-a981-e0207e71de5c	${profileScopeConsentText}	consent.screen.text
c5661577-386a-4a48-a981-e0207e71de5c	true	include.in.token.scope
8250b6ca-1b2a-4521-a2f5-06d48a852ec5	true	display.on.consent.screen
8250b6ca-1b2a-4521-a2f5-06d48a852ec5	${emailScopeConsentText}	consent.screen.text
8250b6ca-1b2a-4521-a2f5-06d48a852ec5	true	include.in.token.scope
8e2861df-d0c1-4db3-9905-54159988842e	true	display.on.consent.screen
8e2861df-d0c1-4db3-9905-54159988842e	${addressScopeConsentText}	consent.screen.text
8e2861df-d0c1-4db3-9905-54159988842e	true	include.in.token.scope
1975efcb-e81b-4ed5-bc0c-c06192d9abca	true	display.on.consent.screen
1975efcb-e81b-4ed5-bc0c-c06192d9abca	${phoneScopeConsentText}	consent.screen.text
1975efcb-e81b-4ed5-bc0c-c06192d9abca	true	include.in.token.scope
cd23a4c9-cf82-4fa7-b0b9-a9ed75b5c668	true	display.on.consent.screen
cd23a4c9-cf82-4fa7-b0b9-a9ed75b5c668	${rolesScopeConsentText}	consent.screen.text
cd23a4c9-cf82-4fa7-b0b9-a9ed75b5c668	false	include.in.token.scope
0a1f7157-db6a-437a-9a01-7f078f22a08e	false	display.on.consent.screen
0a1f7157-db6a-437a-9a01-7f078f22a08e		consent.screen.text
0a1f7157-db6a-437a-9a01-7f078f22a08e	false	include.in.token.scope
b3082110-1d80-4c36-8f92-0639e7fe8aea	false	display.on.consent.screen
b3082110-1d80-4c36-8f92-0639e7fe8aea	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
08c97ad9-d906-4644-93bd-ea0584cad180	debc63ab-26ff-4018-ae1c-f462aac09707	t
abab6a4a-5863-456c-8348-10e029a86820	debc63ab-26ff-4018-ae1c-f462aac09707	t
0e7ebee3-9aca-42f0-bcd2-eff6bf8854e3	debc63ab-26ff-4018-ae1c-f462aac09707	t
902b311b-ba7d-46ce-acdb-6eb9e3136b2c	debc63ab-26ff-4018-ae1c-f462aac09707	t
aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	debc63ab-26ff-4018-ae1c-f462aac09707	t
d1055f6d-d48d-4be5-a2de-f748e592a2a3	debc63ab-26ff-4018-ae1c-f462aac09707	t
08c97ad9-d906-4644-93bd-ea0584cad180	f971b5a7-ae3c-46b0-8af1-142fe807bee3	t
08c97ad9-d906-4644-93bd-ea0584cad180	d7f05291-7b53-4e6f-a23b-daf00836d7b0	t
08c97ad9-d906-4644-93bd-ea0584cad180	991d255e-b06f-41b2-83c7-7d7071146643	t
08c97ad9-d906-4644-93bd-ea0584cad180	b1388f1c-be05-48bd-8894-5d95938b7029	t
08c97ad9-d906-4644-93bd-ea0584cad180	f2e0037f-d017-46e1-a034-177801c83b23	f
08c97ad9-d906-4644-93bd-ea0584cad180	a966db78-54e2-4b5c-9339-7818843e8506	f
08c97ad9-d906-4644-93bd-ea0584cad180	27c23296-0cc2-4ac2-8c19-2a73253fc3d0	f
08c97ad9-d906-4644-93bd-ea0584cad180	6a58d7df-17f4-414a-86c8-6697407326c4	f
abab6a4a-5863-456c-8348-10e029a86820	f971b5a7-ae3c-46b0-8af1-142fe807bee3	t
abab6a4a-5863-456c-8348-10e029a86820	d7f05291-7b53-4e6f-a23b-daf00836d7b0	t
abab6a4a-5863-456c-8348-10e029a86820	991d255e-b06f-41b2-83c7-7d7071146643	t
abab6a4a-5863-456c-8348-10e029a86820	b1388f1c-be05-48bd-8894-5d95938b7029	t
abab6a4a-5863-456c-8348-10e029a86820	f2e0037f-d017-46e1-a034-177801c83b23	f
abab6a4a-5863-456c-8348-10e029a86820	a966db78-54e2-4b5c-9339-7818843e8506	f
abab6a4a-5863-456c-8348-10e029a86820	27c23296-0cc2-4ac2-8c19-2a73253fc3d0	f
abab6a4a-5863-456c-8348-10e029a86820	6a58d7df-17f4-414a-86c8-6697407326c4	f
0e7ebee3-9aca-42f0-bcd2-eff6bf8854e3	f971b5a7-ae3c-46b0-8af1-142fe807bee3	t
0e7ebee3-9aca-42f0-bcd2-eff6bf8854e3	d7f05291-7b53-4e6f-a23b-daf00836d7b0	t
0e7ebee3-9aca-42f0-bcd2-eff6bf8854e3	991d255e-b06f-41b2-83c7-7d7071146643	t
0e7ebee3-9aca-42f0-bcd2-eff6bf8854e3	b1388f1c-be05-48bd-8894-5d95938b7029	t
0e7ebee3-9aca-42f0-bcd2-eff6bf8854e3	f2e0037f-d017-46e1-a034-177801c83b23	f
0e7ebee3-9aca-42f0-bcd2-eff6bf8854e3	a966db78-54e2-4b5c-9339-7818843e8506	f
0e7ebee3-9aca-42f0-bcd2-eff6bf8854e3	27c23296-0cc2-4ac2-8c19-2a73253fc3d0	f
0e7ebee3-9aca-42f0-bcd2-eff6bf8854e3	6a58d7df-17f4-414a-86c8-6697407326c4	f
902b311b-ba7d-46ce-acdb-6eb9e3136b2c	f971b5a7-ae3c-46b0-8af1-142fe807bee3	t
902b311b-ba7d-46ce-acdb-6eb9e3136b2c	d7f05291-7b53-4e6f-a23b-daf00836d7b0	t
902b311b-ba7d-46ce-acdb-6eb9e3136b2c	991d255e-b06f-41b2-83c7-7d7071146643	t
902b311b-ba7d-46ce-acdb-6eb9e3136b2c	b1388f1c-be05-48bd-8894-5d95938b7029	t
902b311b-ba7d-46ce-acdb-6eb9e3136b2c	f2e0037f-d017-46e1-a034-177801c83b23	f
902b311b-ba7d-46ce-acdb-6eb9e3136b2c	a966db78-54e2-4b5c-9339-7818843e8506	f
902b311b-ba7d-46ce-acdb-6eb9e3136b2c	27c23296-0cc2-4ac2-8c19-2a73253fc3d0	f
902b311b-ba7d-46ce-acdb-6eb9e3136b2c	6a58d7df-17f4-414a-86c8-6697407326c4	f
aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	f971b5a7-ae3c-46b0-8af1-142fe807bee3	t
aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	d7f05291-7b53-4e6f-a23b-daf00836d7b0	t
aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	991d255e-b06f-41b2-83c7-7d7071146643	t
aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	b1388f1c-be05-48bd-8894-5d95938b7029	t
aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	f2e0037f-d017-46e1-a034-177801c83b23	f
aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	a966db78-54e2-4b5c-9339-7818843e8506	f
aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	27c23296-0cc2-4ac2-8c19-2a73253fc3d0	f
aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	6a58d7df-17f4-414a-86c8-6697407326c4	f
d1055f6d-d48d-4be5-a2de-f748e592a2a3	f971b5a7-ae3c-46b0-8af1-142fe807bee3	t
d1055f6d-d48d-4be5-a2de-f748e592a2a3	d7f05291-7b53-4e6f-a23b-daf00836d7b0	t
d1055f6d-d48d-4be5-a2de-f748e592a2a3	991d255e-b06f-41b2-83c7-7d7071146643	t
d1055f6d-d48d-4be5-a2de-f748e592a2a3	b1388f1c-be05-48bd-8894-5d95938b7029	t
d1055f6d-d48d-4be5-a2de-f748e592a2a3	f2e0037f-d017-46e1-a034-177801c83b23	f
d1055f6d-d48d-4be5-a2de-f748e592a2a3	a966db78-54e2-4b5c-9339-7818843e8506	f
d1055f6d-d48d-4be5-a2de-f748e592a2a3	27c23296-0cc2-4ac2-8c19-2a73253fc3d0	f
d1055f6d-d48d-4be5-a2de-f748e592a2a3	6a58d7df-17f4-414a-86c8-6697407326c4	f
ac07db7f-2cc1-4841-876b-40b8516f39f9	debc63ab-26ff-4018-ae1c-f462aac09707	t
ac07db7f-2cc1-4841-876b-40b8516f39f9	f971b5a7-ae3c-46b0-8af1-142fe807bee3	t
ac07db7f-2cc1-4841-876b-40b8516f39f9	d7f05291-7b53-4e6f-a23b-daf00836d7b0	t
ac07db7f-2cc1-4841-876b-40b8516f39f9	991d255e-b06f-41b2-83c7-7d7071146643	t
ac07db7f-2cc1-4841-876b-40b8516f39f9	b1388f1c-be05-48bd-8894-5d95938b7029	t
ac07db7f-2cc1-4841-876b-40b8516f39f9	f2e0037f-d017-46e1-a034-177801c83b23	f
ac07db7f-2cc1-4841-876b-40b8516f39f9	a966db78-54e2-4b5c-9339-7818843e8506	f
ac07db7f-2cc1-4841-876b-40b8516f39f9	27c23296-0cc2-4ac2-8c19-2a73253fc3d0	f
ac07db7f-2cc1-4841-876b-40b8516f39f9	6a58d7df-17f4-414a-86c8-6697407326c4	f
52bd5914-a6e4-4757-87dd-effc52813817	8452362d-b836-468b-b0ab-76b4885f3632	t
79f4d5db-6766-48a6-a093-1a8d5b48c2ff	8452362d-b836-468b-b0ab-76b4885f3632	t
209db2ca-dd49-4b6d-b06a-f8029c07322d	8452362d-b836-468b-b0ab-76b4885f3632	t
5b51b2e4-dcda-44db-ac85-8b24fc91dbf4	8452362d-b836-468b-b0ab-76b4885f3632	t
b8d50ca6-d208-439e-9f34-31f53efdb740	8452362d-b836-468b-b0ab-76b4885f3632	t
94f39d5d-d7f4-419b-a7dc-32c526849238	8452362d-b836-468b-b0ab-76b4885f3632	t
52bd5914-a6e4-4757-87dd-effc52813817	cd23a4c9-cf82-4fa7-b0b9-a9ed75b5c668	t
52bd5914-a6e4-4757-87dd-effc52813817	8250b6ca-1b2a-4521-a2f5-06d48a852ec5	t
52bd5914-a6e4-4757-87dd-effc52813817	c5661577-386a-4a48-a981-e0207e71de5c	t
52bd5914-a6e4-4757-87dd-effc52813817	0a1f7157-db6a-437a-9a01-7f078f22a08e	t
52bd5914-a6e4-4757-87dd-effc52813817	1975efcb-e81b-4ed5-bc0c-c06192d9abca	f
52bd5914-a6e4-4757-87dd-effc52813817	8e2861df-d0c1-4db3-9905-54159988842e	f
52bd5914-a6e4-4757-87dd-effc52813817	b786462d-167d-4c4e-b790-3d580a2f19dc	f
52bd5914-a6e4-4757-87dd-effc52813817	b3082110-1d80-4c36-8f92-0639e7fe8aea	f
79f4d5db-6766-48a6-a093-1a8d5b48c2ff	cd23a4c9-cf82-4fa7-b0b9-a9ed75b5c668	t
79f4d5db-6766-48a6-a093-1a8d5b48c2ff	8250b6ca-1b2a-4521-a2f5-06d48a852ec5	t
79f4d5db-6766-48a6-a093-1a8d5b48c2ff	c5661577-386a-4a48-a981-e0207e71de5c	t
79f4d5db-6766-48a6-a093-1a8d5b48c2ff	0a1f7157-db6a-437a-9a01-7f078f22a08e	t
79f4d5db-6766-48a6-a093-1a8d5b48c2ff	1975efcb-e81b-4ed5-bc0c-c06192d9abca	f
79f4d5db-6766-48a6-a093-1a8d5b48c2ff	8e2861df-d0c1-4db3-9905-54159988842e	f
79f4d5db-6766-48a6-a093-1a8d5b48c2ff	b786462d-167d-4c4e-b790-3d580a2f19dc	f
79f4d5db-6766-48a6-a093-1a8d5b48c2ff	b3082110-1d80-4c36-8f92-0639e7fe8aea	f
209db2ca-dd49-4b6d-b06a-f8029c07322d	cd23a4c9-cf82-4fa7-b0b9-a9ed75b5c668	t
209db2ca-dd49-4b6d-b06a-f8029c07322d	8250b6ca-1b2a-4521-a2f5-06d48a852ec5	t
209db2ca-dd49-4b6d-b06a-f8029c07322d	c5661577-386a-4a48-a981-e0207e71de5c	t
209db2ca-dd49-4b6d-b06a-f8029c07322d	0a1f7157-db6a-437a-9a01-7f078f22a08e	t
209db2ca-dd49-4b6d-b06a-f8029c07322d	1975efcb-e81b-4ed5-bc0c-c06192d9abca	f
209db2ca-dd49-4b6d-b06a-f8029c07322d	8e2861df-d0c1-4db3-9905-54159988842e	f
209db2ca-dd49-4b6d-b06a-f8029c07322d	b786462d-167d-4c4e-b790-3d580a2f19dc	f
209db2ca-dd49-4b6d-b06a-f8029c07322d	b3082110-1d80-4c36-8f92-0639e7fe8aea	f
5b51b2e4-dcda-44db-ac85-8b24fc91dbf4	cd23a4c9-cf82-4fa7-b0b9-a9ed75b5c668	t
5b51b2e4-dcda-44db-ac85-8b24fc91dbf4	8250b6ca-1b2a-4521-a2f5-06d48a852ec5	t
5b51b2e4-dcda-44db-ac85-8b24fc91dbf4	c5661577-386a-4a48-a981-e0207e71de5c	t
5b51b2e4-dcda-44db-ac85-8b24fc91dbf4	0a1f7157-db6a-437a-9a01-7f078f22a08e	t
5b51b2e4-dcda-44db-ac85-8b24fc91dbf4	1975efcb-e81b-4ed5-bc0c-c06192d9abca	f
5b51b2e4-dcda-44db-ac85-8b24fc91dbf4	8e2861df-d0c1-4db3-9905-54159988842e	f
5b51b2e4-dcda-44db-ac85-8b24fc91dbf4	b786462d-167d-4c4e-b790-3d580a2f19dc	f
5b51b2e4-dcda-44db-ac85-8b24fc91dbf4	b3082110-1d80-4c36-8f92-0639e7fe8aea	f
b8d50ca6-d208-439e-9f34-31f53efdb740	cd23a4c9-cf82-4fa7-b0b9-a9ed75b5c668	t
b8d50ca6-d208-439e-9f34-31f53efdb740	8250b6ca-1b2a-4521-a2f5-06d48a852ec5	t
b8d50ca6-d208-439e-9f34-31f53efdb740	c5661577-386a-4a48-a981-e0207e71de5c	t
b8d50ca6-d208-439e-9f34-31f53efdb740	0a1f7157-db6a-437a-9a01-7f078f22a08e	t
b8d50ca6-d208-439e-9f34-31f53efdb740	1975efcb-e81b-4ed5-bc0c-c06192d9abca	f
b8d50ca6-d208-439e-9f34-31f53efdb740	8e2861df-d0c1-4db3-9905-54159988842e	f
b8d50ca6-d208-439e-9f34-31f53efdb740	b786462d-167d-4c4e-b790-3d580a2f19dc	f
b8d50ca6-d208-439e-9f34-31f53efdb740	b3082110-1d80-4c36-8f92-0639e7fe8aea	f
94f39d5d-d7f4-419b-a7dc-32c526849238	cd23a4c9-cf82-4fa7-b0b9-a9ed75b5c668	t
94f39d5d-d7f4-419b-a7dc-32c526849238	8250b6ca-1b2a-4521-a2f5-06d48a852ec5	t
94f39d5d-d7f4-419b-a7dc-32c526849238	c5661577-386a-4a48-a981-e0207e71de5c	t
94f39d5d-d7f4-419b-a7dc-32c526849238	0a1f7157-db6a-437a-9a01-7f078f22a08e	t
94f39d5d-d7f4-419b-a7dc-32c526849238	1975efcb-e81b-4ed5-bc0c-c06192d9abca	f
94f39d5d-d7f4-419b-a7dc-32c526849238	8e2861df-d0c1-4db3-9905-54159988842e	f
94f39d5d-d7f4-419b-a7dc-32c526849238	b786462d-167d-4c4e-b790-3d580a2f19dc	f
94f39d5d-d7f4-419b-a7dc-32c526849238	b3082110-1d80-4c36-8f92-0639e7fe8aea	f
95468c3a-ced2-4a92-84cb-64fe8c289298	8452362d-b836-468b-b0ab-76b4885f3632	t
95468c3a-ced2-4a92-84cb-64fe8c289298	cd23a4c9-cf82-4fa7-b0b9-a9ed75b5c668	t
95468c3a-ced2-4a92-84cb-64fe8c289298	8250b6ca-1b2a-4521-a2f5-06d48a852ec5	t
95468c3a-ced2-4a92-84cb-64fe8c289298	c5661577-386a-4a48-a981-e0207e71de5c	t
95468c3a-ced2-4a92-84cb-64fe8c289298	0a1f7157-db6a-437a-9a01-7f078f22a08e	t
95468c3a-ced2-4a92-84cb-64fe8c289298	1975efcb-e81b-4ed5-bc0c-c06192d9abca	f
95468c3a-ced2-4a92-84cb-64fe8c289298	8e2861df-d0c1-4db3-9905-54159988842e	f
95468c3a-ced2-4a92-84cb-64fe8c289298	b786462d-167d-4c4e-b790-3d580a2f19dc	f
95468c3a-ced2-4a92-84cb-64fe8c289298	b3082110-1d80-4c36-8f92-0639e7fe8aea	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
f2e0037f-d017-46e1-a034-177801c83b23	2c0bd327-20dc-4251-9484-44422e9dc412
b786462d-167d-4c4e-b790-3d580a2f19dc	a6a12309-c484-497a-907f-0467489253b8
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
18ecad36-812f-48a6-ac7e-9a5d4b1b2c6c	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
68ff2fac-c7b5-4eec-95e2-93c4c7d25b93	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
b2553b85-5b71-4a05-9182-5b81f8e03ee5	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
e48ba3f3-02f4-403f-8499-5989e2b3caef	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
a8397ba7-53b6-4b0b-81eb-7c7c090ea1ff	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
6bde1f0e-91ff-40ff-b59a-9812738ba623	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
7a97e17f-75d2-4eb9-85e3-a545acbe4b15	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
8a090f42-e7d8-482e-87bb-8ac8fd671436	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
f08fd40f-b429-4610-9df9-35ebd4daf290	fallback-HS256	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
f664c1d4-1bc3-4e0d-870c-46ddb2073ee6	fallback-RS256	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
51d148f4-b839-4b75-9915-74c57e362b95	rsa-generated	Questboard	rsa-generated	org.keycloak.keys.KeyProvider	Questboard	\N
e30fe470-63e3-4751-8706-16a3fddf4b3a	hmac-generated	Questboard	hmac-generated	org.keycloak.keys.KeyProvider	Questboard	\N
53ea9d95-f523-4ebd-be8c-3b4838cc629e	aes-generated	Questboard	aes-generated	org.keycloak.keys.KeyProvider	Questboard	\N
54a3cee7-09f5-4f12-ad2d-fed3d2cd8a13	Trusted Hosts	Questboard	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Questboard	anonymous
23260ef0-df5c-4d97-bcd3-72016b89f0c4	Consent Required	Questboard	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Questboard	anonymous
294ba017-e9cb-4d33-b59a-fcf44903c027	Full Scope Disabled	Questboard	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Questboard	anonymous
6424ae8f-c6ab-4d06-8b3d-10876904b9e4	Max Clients Limit	Questboard	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Questboard	anonymous
28429990-a3e2-43aa-a8a9-2d70631c2b1c	Allowed Protocol Mapper Types	Questboard	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Questboard	anonymous
3d5c5a09-8ec4-4576-aa28-8da1f151daea	Allowed Client Scopes	Questboard	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Questboard	anonymous
02db37a7-317b-46e9-98d9-d67dadd6e9b6	Allowed Protocol Mapper Types	Questboard	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Questboard	authenticated
c2ffb0bd-32f1-481e-8192-f865f45b4824	Allowed Client Scopes	Questboard	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Questboard	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
19fb9886-6b83-4c64-b868-0ce556fbf635	e48ba3f3-02f4-403f-8499-5989e2b3caef	max-clients	200
4032b1b6-597b-4100-8c95-0247eb6071fd	18ecad36-812f-48a6-ac7e-9a5d4b1b2c6c	client-uris-must-match	true
c1a67412-a9ca-444b-92ac-3ae8f5698947	18ecad36-812f-48a6-ac7e-9a5d4b1b2c6c	host-sending-registration-request-must-match	true
aaaf7a0c-d95a-44ac-82bb-f44b4ab7c17e	a8397ba7-53b6-4b0b-81eb-7c7c090ea1ff	allowed-protocol-mapper-types	oidc-address-mapper
e83609d1-93e4-4a6a-a4a8-9186aacedc61	a8397ba7-53b6-4b0b-81eb-7c7c090ea1ff	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
030a0ba5-4aef-4043-b42a-ce1aa212f5f4	a8397ba7-53b6-4b0b-81eb-7c7c090ea1ff	allowed-protocol-mapper-types	saml-user-attribute-mapper
f683a036-586d-4bb5-a9ba-d3bcb0f8ff01	a8397ba7-53b6-4b0b-81eb-7c7c090ea1ff	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
e847fbe0-2028-475f-95af-d03f832e101d	a8397ba7-53b6-4b0b-81eb-7c7c090ea1ff	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
08aba6ed-c5fa-4ac1-926f-1e72ae92cd71	a8397ba7-53b6-4b0b-81eb-7c7c090ea1ff	allowed-protocol-mapper-types	oidc-full-name-mapper
c6a761cd-97d3-4ab8-ab69-857c72cbd92a	a8397ba7-53b6-4b0b-81eb-7c7c090ea1ff	allowed-protocol-mapper-types	saml-role-list-mapper
a3676ba1-5e06-44a2-a8b1-32e941224fd1	a8397ba7-53b6-4b0b-81eb-7c7c090ea1ff	allowed-protocol-mapper-types	saml-user-property-mapper
ecb85b62-2f59-4745-a762-30f954568f85	8a090f42-e7d8-482e-87bb-8ac8fd671436	allow-default-scopes	true
272342d8-b773-43fa-b018-8cdc1e3c89c7	6bde1f0e-91ff-40ff-b59a-9812738ba623	allow-default-scopes	true
be151aa7-2acc-49f4-a13d-345bc5edcec1	7a97e17f-75d2-4eb9-85e3-a545acbe4b15	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
90de0a03-479b-45cb-90bb-25b705e2a647	7a97e17f-75d2-4eb9-85e3-a545acbe4b15	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
c18b8e10-68dd-4d78-9663-a4c09b4ab57b	7a97e17f-75d2-4eb9-85e3-a545acbe4b15	allowed-protocol-mapper-types	oidc-address-mapper
d8ab3675-873f-49ef-862e-d4df11e6c6ca	7a97e17f-75d2-4eb9-85e3-a545acbe4b15	allowed-protocol-mapper-types	oidc-full-name-mapper
d09a06cb-aa80-49b3-80a8-fee1b8e250ec	7a97e17f-75d2-4eb9-85e3-a545acbe4b15	allowed-protocol-mapper-types	saml-user-attribute-mapper
419fa826-db05-4bed-8a3b-d9abe5e9bce0	7a97e17f-75d2-4eb9-85e3-a545acbe4b15	allowed-protocol-mapper-types	saml-user-property-mapper
82b1a185-0e3c-4fcf-9df5-7def24abcd5f	7a97e17f-75d2-4eb9-85e3-a545acbe4b15	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
5c69c69a-7e47-42fb-9760-6c768eab8828	7a97e17f-75d2-4eb9-85e3-a545acbe4b15	allowed-protocol-mapper-types	saml-role-list-mapper
b4356b6b-4ea7-40e2-a222-d5fc6dae7cc0	f08fd40f-b429-4610-9df9-35ebd4daf290	algorithm	HS256
79f3f5d0-162c-4c41-a70f-9bb9d0b6883a	f08fd40f-b429-4610-9df9-35ebd4daf290	kid	4307f12c-28dc-450c-bcf0-02240328cb47
92b4e1e1-49c5-4cd4-b0bd-7ee256f5f941	f08fd40f-b429-4610-9df9-35ebd4daf290	secret	T3qY6PK-2xjVqiQ-Fon5RdvQfMqvV30s2YzGiIYpwY2vzu8PNTxJfViAbB-XQ1rRFm1ft5wfzFiRjw10b7FUSw
af27dd3c-4753-4c01-93e3-210769bd4d8c	f08fd40f-b429-4610-9df9-35ebd4daf290	priority	-100
fae2b689-93bb-4e38-bb86-280335898a8e	f664c1d4-1bc3-4e0d-870c-46ddb2073ee6	priority	-100
e75ebd6c-eb05-4f56-9f74-00e5557f3fb5	f664c1d4-1bc3-4e0d-870c-46ddb2073ee6	algorithm	RS256
92abb665-0c79-4211-bdf5-e16bfb4660d2	f664c1d4-1bc3-4e0d-870c-46ddb2073ee6	privateKey	MIIEpAIBAAKCAQEAse5GA8C6XrpifXQXY4Gns5WXEZ5rEz3GwMK5LvjtIrPgTGHAWZEakklHbS0aPLeNQgwNxOK90Oue7VClUea7JNC9Yx9mLmKG+klDqPBQ5Hvejv6pL09dVq/Dbh8lu/LWUnjHsm4D0P+tU/O9wrCpoCDTs4nhovpqFv277jiqUpRg1xYUyCUU5zbsCZYtxYWfzx+HgbKSAeZzw1/2ala3G75f8emCRBrvM9hNjO3fBhBkQQK0548IzXsKoP4KlGpCCp1VT5kI078L9TtYcdgSzAOax0oUXxwzcApTAjgiltShX6S9G/f6AlMEzp8Cq3Fr7Wy5os9rZZZsrxTaZk3jGQIDAQABAoIBADq5h4Ypj9k/7s21CRsgabcNwiRggrqBAx4PporoQWvYrkjHYnKtP3XUlaxk3Gn5srd/vvOiWj+f5H4yxb14R3/pHPigHltkzWPB1oDlf+1JLLVJO5GPwiCgNgIcaZnUlgP2NQKg6MWL/SreIV0mbXWaIAT7lurxdx5LdEE1lpFWNemZfza/djUDYzHgSDaPktjPlM9+74LS0oz+GaljXtpjH0I2uBAWIcXrFDrwHYPzeLNIFNNKz1gh+m3TQGQoidhmIgFfy8fnKvDB4whBQdVZo9rGivUQFYrFbVBAMH2NWd77v1mYynznDkhwYb3lFzvZ6Tm+RL6t/qZjRbk5lwECgYEA61+BjhgEiPXbdfu0aFylFg6jPxh1RscFR9sijtIe3Rqxfg48zHwDuHvb4k2/zWFP1x+iMb7MNdQcEXA+25yDTpfJpRNQjPB/fyotnQvpgKdmZsS0RGpTPJOzTlM6wJRtR70LeGl/RsQDrZzMatJewz2YFcF4W5XZKF0hegRjQpECgYEAwYYS3xJskOh2OvsFv+6GbiWsVtBaQUqFpNHpGug8rXVeetuslqUaVwdeLX1Jwif4tuaFpo31SGTYNW9cJGT9cC7GBouPILADaoTJ8Pas9Ex7YxASp8qdbS5ZDZBdmJLeX7bvu+M1Qs+DHkvCC4w0L+g5gzHl3LHnw5HpAeH1zAkCgYEAy8LXZkqWinbEsWPgr0QcynaLjlC/HjGm+ajURu3SODkmlOkAa0mk8u2O0l/afpMSyjohcI0rPiJM1i/kyru41K4Eq7qHzitZRJ4f9MfeMjk5Jhh9soiVXGjFHjZhM1yLKkKXDnvN6lZAlOib8pIB5WWKJrNhXW/hGddd5sKrp3ECgYA4d9m705FwOxR8o1CLL5t0OnPuJP+g+5DBhiqhmlBSQOQfr0fN8UEdUd4OIffKuoUdQWiQL+35gMuB1Aur5vf4qv1HXaOW4yUsCLEwKZpP8p0yS7dV1I5ZFGQRzCUzZu+SODv9tA+PfiOBTJPDcNatf/KAMKgk3JiG/WVjEj75mQKBgQDKk+jAjLd/QvvuTaGrb4NoP3AHALM8PcZCq5NQXxbNlr6FIdmTYBd5+liUIN8EBUQioxOHm+ZUWo2a6vPuHrmzuFbTr/NTsLc9YssSXkanLp3BJVn4kc0E8gYuaVUfryMMz6rrDDJ9nXN0hsD774VdjIY78la2wKWcUFiEcizAsA==
b20a9121-853e-45a4-ab05-504150b12475	f664c1d4-1bc3-4e0d-870c-46ddb2073ee6	certificate	MIICmzCCAYMCBgF4JL2wOTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjEwMzEyMDQ0MDE0WhcNMzEwMzEyMDQ0MTU0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCx7kYDwLpeumJ9dBdjgaezlZcRnmsTPcbAwrku+O0is+BMYcBZkRqSSUdtLRo8t41CDA3E4r3Q657tUKVR5rsk0L1jH2YuYob6SUOo8FDke96O/qkvT11Wr8NuHyW78tZSeMeybgPQ/61T873CsKmgINOzieGi+moW/bvuOKpSlGDXFhTIJRTnNuwJli3FhZ/PH4eBspIB5nPDX/ZqVrcbvl/x6YJEGu8z2E2M7d8GEGRBArTnjwjNewqg/gqUakIKnVVPmQjTvwv1O1hx2BLMA5rHShRfHDNwClMCOCKW1KFfpL0b9/oCUwTOnwKrcWvtbLmiz2tllmyvFNpmTeMZAgMBAAEwDQYJKoZIhvcNAQELBQADggEBABt5WA+zWH2lioF5exWIlTvh0eN3VrwjuNE3hxavjU9I/ukX8EPlFRrqUnUyAT7gVafLZw/ZVaIXIBwyp6yiLi7gQfjBYJbUxLK2ovknmVtTyzWEP+tyMcxmsFK4NoXfTpus64FSHIDPLhDJzFUxXbmLFz3gRBbj86MPj+V9Vkr0xblrRCjAn4vuRw7cHThnVsLqT2AmMOSIT8AGcTFlAxWycShZotxoPjQ64tMLzTGVnhd8JLSxGbIaDZAxQBOj8P+GeS5yE+xuFOztR+K/Pr2HAosNLRNTR8mG9jPVndEDTXwGbhQlQfC9i7l7QzAHCK2RXwXVeo3HKXj2XLDfh/o=
1edea627-91b3-42be-af3b-b1916f9e01ee	53ea9d95-f523-4ebd-be8c-3b4838cc629e	secret	eHEUjnCcAu5xMwLsQsQxDA
30073105-c23e-4ee2-92aa-861cf326b90b	53ea9d95-f523-4ebd-be8c-3b4838cc629e	kid	abc5b92e-c11b-4c2c-96d5-bb1c3d575304
411ead23-4482-4ea6-a003-790598ece269	53ea9d95-f523-4ebd-be8c-3b4838cc629e	priority	100
94b590f5-c195-4d02-ae37-28903ba31a25	e30fe470-63e3-4751-8706-16a3fddf4b3a	algorithm	HS256
fd8a7432-1168-4fe8-8dc8-5810ab48b29b	e30fe470-63e3-4751-8706-16a3fddf4b3a	kid	e66f75da-2ca5-4abb-83b4-d986390a8928
510e86bc-738e-4dc8-b146-f507fe536cdc	e30fe470-63e3-4751-8706-16a3fddf4b3a	priority	100
dad36bb8-3912-4a12-b38b-e474b289224e	e30fe470-63e3-4751-8706-16a3fddf4b3a	secret	TAB98Z7_K7yjBR-cs9BjWrTpD2A9zfqiMuqi_ETloA3AR4jkp7GxLcy0MiYcZ5-69Mnmm0xU45WzQ1v8LSOFLw
b998e4ef-4039-479a-9636-115641ecf3d7	51d148f4-b839-4b75-9915-74c57e362b95	priority	100
0ed6a361-0093-4eff-93ec-b7d37f58edeb	51d148f4-b839-4b75-9915-74c57e362b95	privateKey	MIIEowIBAAKCAQEAq2qDlMXMWqhl+xeDQwdsnFiCVMjksJA9Nn44Qyls0ZVm3z4EQQzDJhaPeOrJcbMgFXycm/dGgEfdWEQgO2lxnwM10VbIDGjBzbWhmNnO2hYEpaAkqQyaKvjJ4bx6OwpFFW/f+et1bvZEFJRl4OsMJ1DUG2P+9EnhjgjQDl22csdxUpIiB1xRD8Q/eu1fT1j7WIznklszY2bitrYn/iqCQut4wSGoz+aClmk97CS5f8pptr+RE07D76bhlwoNAV8xk+XhFWCbR5NVYxWpnuyxxUmGfNfT6HLZnMgpO7UcQkl2InWMQVeqPzEjocHEag5RjYJC6V+QvHO1mwQn00o3+wIDAQABAoIBACTn09iOFYdXRk2fLFWcHZgzviu+7O3OwD8hQb/EBXfCMNnTolrXApUKum0QL7rZFAlMQPObc4Re9JryX/Yqp5nSuR2PD5cMXt2JQ3eDPXPa1blLF1mGKxMhaWW+jJp1hZYt9gz60tfHEbVUlfKs6Hr2fhQ/nT6/QV6xKwpMxuFDEPi9L829G6dTs8hOeCCKEKDHASvrteoMbM3nfMunsXa8If7C+MoPeGf/oN8T/2DF0b5Xyg8PqntaGjxSoy4Z4fyp4uGNWIhoNZT5nXRedaQvabqEAnC4Y82NAhCdEmICOkfe1aaV9NuZDLUm5iG0TVssUChO0kBCxjhrqHjvnzECgYEA4rVR2ocgamVxjgavnswRmDlRvjA9snYQwA6cyccv2ilBMtAp16quUzamWb+tdp1guh0hRG5E8A7GsK22ve1wgURr+LJlFxYfjd0NXlwE81c7WFbD0hhTLgFTaCj8aS3IBrrzXTvvMIugSWu49uN8jGvRD3IJHwWO6nSndk3L8B0CgYEAwZBUjbK6XrFNOugQBfuZzvxnJEAGwU2rpZJbuRddaF+rNBJ6oybiSW/xwegWL+SIMYCNkGl/XgnLzj2/c371Lq+QjwYMkcTMLE4zyyJ3gpUB/VhNnMdTzeYeXQniHtS0A1eFtk6a0IrtRKKcNfuoUiZXxHR9VT8OxKIHL8l9/PcCgYEAn2fA2zgCGe2kT6nx2GVCxdcf2+vNpesQUgq0QciVo/84AcOOeD9h/c7CXv7AuFNmTNboqlYikOzC1j3+7ULDxZDXnnHJVNdQbo6MtNlc/cFLUA0J+XLzIbj67ZVMDaSMLfdL4TWgNHEozhc5YheIXq/8urCDK1XcLIzDpxKCoB0CgYACQCVbiGp2U2Vse+pDx4sgRvsEBuKNONP4Ft2OJ2Fkp0gcUOKwJvGWnQCYmpQ3dlbHDJGYzkE23LJL8ZfaRe2f31a08wMOZtVg5n/fqsTs9cKSKYatffvRdw1/U3AXn62AJHJfjkZqilL761AZqJVqbxuyIxCZ/yOy0Zd3zMX0PQKBgG0Do2Mb9/tXpkxTCkLlI+bn5XAwlxHEmqgkJG/v2crzQH3fwvVIf2CFtMBXLXykMHLOjla0o/XP+9s4SrOiP2xlm95gPTbk7N2zvQDMAI3gYG5EyxFYezpSPm+AspJqZLkBOdMAFCaQ8/34F4KkgXvtx7wCe1se29AskQbobvMe
392413a7-451c-43cf-8fa4-e537f560b298	51d148f4-b839-4b75-9915-74c57e362b95	certificate	MIICozCCAYsCBgF4JL4VCjANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDDApRdWVzdGJvYXJkMB4XDTIxMDMxMjA0NDA0MFoXDTMxMDMxMjA0NDIyMFowFTETMBEGA1UEAwwKUXVlc3Rib2FyZDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKtqg5TFzFqoZfsXg0MHbJxYglTI5LCQPTZ+OEMpbNGVZt8+BEEMwyYWj3jqyXGzIBV8nJv3RoBH3VhEIDtpcZ8DNdFWyAxowc21oZjZztoWBKWgJKkMmir4yeG8ejsKRRVv3/nrdW72RBSUZeDrDCdQ1Btj/vRJ4Y4I0A5dtnLHcVKSIgdcUQ/EP3rtX09Y+1iM55JbM2Nm4ra2J/4qgkLreMEhqM/mgpZpPewkuX/Kaba/kRNOw++m4ZcKDQFfMZPl4RVgm0eTVWMVqZ7sscVJhnzX0+hy2ZzIKTu1HEJJdiJ1jEFXqj8xI6HBxGoOUY2CQulfkLxztZsEJ9NKN/sCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAIC6aMRK0o+JaqWhPGgBQ3ApzOXbG8ISSDczd1clUv5e54mKw4RYgI64vSf3ElYHbVDonZ5Z6mPKQEBrceSfDgIAUDbOLshN2D5zVCNEeol7XGW0y2DGUh3qCLJEIu5F6SwZQQan8tLHKRdH9OD6+tGn9LasdlgL59si+S5ZDSXM+N4kagHBmhtyPcIO9gH/L4Y8YTVnN5fYHG02lmjAPA8n92518o+smkyDEWOB/mwQFA916Rd7aSR4pxL5kxtvOE3Xmdbcc4BzqUFB3QFOmQ1vLGL2/0rnaShRnlfNUZJJXiYhINaoSPMQR5sTEzolX/6UWcSKcPWb7zQmhgOhH/w==
744da6b6-adf9-4213-ac19-291341ce1704	c2ffb0bd-32f1-481e-8192-f865f45b4824	allow-default-scopes	true
f3beae14-0225-4893-9750-bf2f9cb75e32	02db37a7-317b-46e9-98d9-d67dadd6e9b6	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
34fc96de-8d8d-4b4c-b6f8-cc04eb70f1d4	02db37a7-317b-46e9-98d9-d67dadd6e9b6	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
1c815153-47e5-4542-a0ff-6d2619db21b2	02db37a7-317b-46e9-98d9-d67dadd6e9b6	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
4de3bdef-1014-4923-8472-6375906b80c0	02db37a7-317b-46e9-98d9-d67dadd6e9b6	allowed-protocol-mapper-types	saml-user-attribute-mapper
be88e47f-2bd0-4afc-a7d9-4796c066623b	02db37a7-317b-46e9-98d9-d67dadd6e9b6	allowed-protocol-mapper-types	oidc-full-name-mapper
8392cdc5-7f2a-426d-94ba-0d6c4914cfb3	02db37a7-317b-46e9-98d9-d67dadd6e9b6	allowed-protocol-mapper-types	saml-role-list-mapper
73ded5c2-a127-4af0-95c7-171ad39f033d	02db37a7-317b-46e9-98d9-d67dadd6e9b6	allowed-protocol-mapper-types	saml-user-property-mapper
45bca3fa-502a-4ea1-a21a-7d31c4902503	02db37a7-317b-46e9-98d9-d67dadd6e9b6	allowed-protocol-mapper-types	oidc-address-mapper
73d0c8de-62b6-4664-9963-177022c8bd81	54a3cee7-09f5-4f12-ad2d-fed3d2cd8a13	host-sending-registration-request-must-match	true
b1edc0d9-b667-47fc-9c1d-336933644adc	54a3cee7-09f5-4f12-ad2d-fed3d2cd8a13	client-uris-must-match	true
3e16bd82-040c-401e-9a6b-ca733c3e8f9a	6424ae8f-c6ab-4d06-8b3d-10876904b9e4	max-clients	200
509e43b8-3bf8-4682-844b-3ec25fd74b70	28429990-a3e2-43aa-a8a9-2d70631c2b1c	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
582f1d89-5c0a-429a-8ffd-ae2d2f6edc53	28429990-a3e2-43aa-a8a9-2d70631c2b1c	allowed-protocol-mapper-types	saml-user-property-mapper
e19e372b-978e-4f7a-818c-3451ccd45dde	28429990-a3e2-43aa-a8a9-2d70631c2b1c	allowed-protocol-mapper-types	saml-role-list-mapper
0802cd0a-6c0f-4fd9-9a7c-543a090afb32	28429990-a3e2-43aa-a8a9-2d70631c2b1c	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
3041721b-4fcb-4288-a9c1-a673c17eb008	28429990-a3e2-43aa-a8a9-2d70631c2b1c	allowed-protocol-mapper-types	oidc-address-mapper
c0cbae82-f353-449a-b99d-1078305a5c7b	28429990-a3e2-43aa-a8a9-2d70631c2b1c	allowed-protocol-mapper-types	saml-user-attribute-mapper
eb203f4b-ed21-4e35-b553-9354ae8a1dac	28429990-a3e2-43aa-a8a9-2d70631c2b1c	allowed-protocol-mapper-types	oidc-full-name-mapper
542c6110-9416-4717-8410-a2ca6ecbd46c	28429990-a3e2-43aa-a8a9-2d70631c2b1c	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
14e7f5c3-70ed-4a51-8140-efcaa9554200	3d5c5a09-8ec4-4576-aa28-8da1f151daea	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	99bfd989-7fe3-457b-a4c7-6e215d9e490a
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	d3dfb31d-3645-46d8-84d3-16a239869b9e
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	fb1d8f2b-b47f-44d8-bdfd-f859f67cb7e0
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	19bfc427-d136-4dc5-9bc0-cc21eae3f7be
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	6360fce4-48fd-4db3-997c-0dbc55e9ebf7
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	cd5a8d4f-d8b7-4c2e-9cbc-aa73f67e977a
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	489f6d4a-8256-46ff-b534-79d942227625
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	d2dba1dc-6064-4e6f-8697-af74bca5852b
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	cbf3b03e-dd46-496f-95b6-a48f599fae09
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	71b2e1aa-3be1-4590-aebd-6c8bf4bc44bc
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	95e9cf28-d27b-46d3-9655-9257a5535bb3
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	4f594170-2ce7-43af-85b9-411e5f3187ac
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	6af27144-7aed-4370-af47-32f5cd1ed13f
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	34307863-356b-4189-bf75-77dce569cd6c
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	f24d30be-42fe-4abc-9341-b824116ed5ae
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	dceb9897-5846-4ab6-84bc-8b4f65e0317e
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	c638ccfd-3d1d-43a3-9930-e0afd3125819
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	53763b0b-d633-4ec0-b908-68524a562867
6360fce4-48fd-4db3-997c-0dbc55e9ebf7	dceb9897-5846-4ab6-84bc-8b4f65e0317e
19bfc427-d136-4dc5-9bc0-cc21eae3f7be	53763b0b-d633-4ec0-b908-68524a562867
19bfc427-d136-4dc5-9bc0-cc21eae3f7be	f24d30be-42fe-4abc-9341-b824116ed5ae
f4b1ad07-5b38-4249-8e82-73052a099da7	ae68f0c1-1197-4e7c-a205-e28209a089ba
bcdc9be7-3063-483c-bc95-64cfb6a94391	a9788289-9fb3-47f6-a292-99c0a4cf6382
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	ad88018b-ef92-432c-b86e-64b1b1ad4c79
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	49cdd3e0-f69a-4fca-a925-4774d0fb6fa1
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	cb1b5cb2-2ca8-4bc2-846e-97568b829e38
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	61cd3624-a54a-44ac-a72c-a330d706dfcf
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	ff33ba52-81d3-40e9-934c-1236fa273bbe
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	f5556af7-ac31-4364-b65f-dca812af4065
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	9056f1f5-74e9-49cc-a7cf-c34da8b9e978
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	ddfcc463-a053-42da-8182-7bbf8357b3cc
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	cdcc8d40-5ceb-4159-86f4-24a1cc7efa9d
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	c2e61ce2-6889-40f1-850d-4d715a171cba
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	3d100540-3fc6-44ba-ba41-11d3025bd437
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	a104636e-f3a1-48b5-bb25-894c3e3a017b
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	c43fab8f-508b-400e-8331-1a39b073df27
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	754669fb-9ccd-4543-95b2-407e571ce009
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	736a40a9-4871-4b1a-adb0-9517f7889c0d
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	c9e6ee08-c89a-4e86-9bd5-3a6a4584d827
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	2fdede4e-ee1f-4cb2-802b-20ab1e731cee
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	7d6f1f9f-dd0a-4a57-b79d-bfc8da32dc5c
ff33ba52-81d3-40e9-934c-1236fa273bbe	c9e6ee08-c89a-4e86-9bd5-3a6a4584d827
61cd3624-a54a-44ac-a72c-a330d706dfcf	736a40a9-4871-4b1a-adb0-9517f7889c0d
61cd3624-a54a-44ac-a72c-a330d706dfcf	7d6f1f9f-dd0a-4a57-b79d-bfc8da32dc5c
7076af5a-3971-4f57-b413-ab896b892f83	73a0f8a9-1835-4f87-8379-c723dd90161a
7076af5a-3971-4f57-b413-ab896b892f83	8e7e2072-a7e5-4024-8b0c-e95a79f36a48
7076af5a-3971-4f57-b413-ab896b892f83	2c1d1649-d428-431b-a76f-fa4fc7a74197
7076af5a-3971-4f57-b413-ab896b892f83	65a9dbca-8d99-4081-907f-93be1ac6d3d8
7076af5a-3971-4f57-b413-ab896b892f83	1fb30f79-5ea7-4382-9be7-6fdebdbe85c2
7076af5a-3971-4f57-b413-ab896b892f83	2d9d58b2-ad94-40b9-b9c7-cc8c6c152e21
7076af5a-3971-4f57-b413-ab896b892f83	da3079dd-89c7-4660-982e-4eaa9b9d9713
7076af5a-3971-4f57-b413-ab896b892f83	bfcbd550-8d7a-40dd-84ca-20741ae98072
7076af5a-3971-4f57-b413-ab896b892f83	7facf9b2-fa5d-43e4-b0cd-22f96b5f4c14
7076af5a-3971-4f57-b413-ab896b892f83	118cccb0-4cfb-4f50-9fe1-0a9219ac114f
7076af5a-3971-4f57-b413-ab896b892f83	09944bb1-3607-40fd-97b0-de90a866df1d
7076af5a-3971-4f57-b413-ab896b892f83	b3e7405d-9030-4b38-9315-79998bce78fe
7076af5a-3971-4f57-b413-ab896b892f83	a5554466-707a-4626-9c4a-7866532eaa85
7076af5a-3971-4f57-b413-ab896b892f83	76e49676-b916-4592-977d-f13d7397a6b1
7076af5a-3971-4f57-b413-ab896b892f83	d921bb19-b773-4451-8f8c-e357079a216e
7076af5a-3971-4f57-b413-ab896b892f83	ee67d5ab-7eb7-4548-aaaf-1ea19b96c2fd
7076af5a-3971-4f57-b413-ab896b892f83	4b07e0fb-a472-41b5-a435-94a89a2fbb75
65a9dbca-8d99-4081-907f-93be1ac6d3d8	d921bb19-b773-4451-8f8c-e357079a216e
2c1d1649-d428-431b-a76f-fa4fc7a74197	4b07e0fb-a472-41b5-a435-94a89a2fbb75
2c1d1649-d428-431b-a76f-fa4fc7a74197	76e49676-b916-4592-977d-f13d7397a6b1
923a0957-09f1-47bf-b886-c2fa0814c72a	737b1c7f-35b0-4851-9613-f15a22da6391
8f1c536d-12ea-4fec-9e40-19249fef6883	5a347940-d692-48e1-a065-7788e708c10c
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	e539cd54-7bdc-4da1-bf69-40359aee3c53
7076af5a-3971-4f57-b413-ab896b892f83	99cf60c5-d93c-43d2-8ee3-e9ec889fd612
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
7954d258-7383-4abe-947e-e6daae1c8533	\N	password	4b150326-5715-4cdf-a759-d228d0f293df	1615523685644	\N	{"value":"YpvBE7RFSLSUeFcCewtdkbwrP1P4BS8ICzKqPWHnDRjyfuHmDatD9ZB1teTfRhrLzVWL6ctdD+AdUXXRLYo5iA==","salt":"aQJd6ezfThpUBEBRbYwdZg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
c9d82981-40cb-42dc-99ec-46cd9aa4ecdd	\N	password	79bd681b-e3fc-4249-9229-d3047a5df2e3	1615542930694	\N	{"value":"qzSgbhwaWt1EmP9MZiZLW3vqckPgXjtzsvyvEN0VPCmANviyjtBFSI1+Gl3bJxQY8elzuc2Wl1EzLPTONrZSfA==","salt":"ly08l2pGoB5UyXjG4Vs5wQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2021-03-12 04:34:41.605083	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	5523681417
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2021-03-12 04:34:41.61272	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	5523681417
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2021-03-12 04:34:41.636831	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	5523681417
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2021-03-12 04:34:41.639581	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	5523681417
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2021-03-12 04:34:41.688191	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	5523681417
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2021-03-12 04:34:41.691118	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	5523681417
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2021-03-12 04:34:41.737459	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	5523681417
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2021-03-12 04:34:41.740474	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	5523681417
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2021-03-12 04:34:41.744555	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	5523681417
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2021-03-12 04:34:41.784093	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	5523681417
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2021-03-12 04:34:41.814926	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	5523681417
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2021-03-12 04:34:41.817032	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	5523681417
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2021-03-12 04:34:41.826899	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	5523681417
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-03-12 04:34:41.83752	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	5523681417
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-03-12 04:34:41.839169	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	5523681417
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-03-12 04:34:41.840752	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	5523681417
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-03-12 04:34:41.842465	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	5523681417
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2021-03-12 04:34:41.872314	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	5523681417
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2021-03-12 04:34:41.897282	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	5523681417
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2021-03-12 04:34:41.900714	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	5523681417
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-03-12 04:34:42.100996	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	5523681417
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2021-03-12 04:34:41.90285	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	5523681417
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2021-03-12 04:34:41.905108	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	5523681417
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2021-03-12 04:34:41.920107	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	5523681417
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2021-03-12 04:34:41.923817	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	5523681417
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2021-03-12 04:34:41.925276	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	5523681417
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2021-03-12 04:34:41.937634	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	5523681417
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2021-03-12 04:34:41.979551	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	5523681417
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2021-03-12 04:34:41.982725	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	5523681417
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2021-03-12 04:34:42.010098	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	5523681417
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2021-03-12 04:34:42.016982	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	5523681417
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2021-03-12 04:34:42.026479	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	5523681417
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2021-03-12 04:34:42.029314	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	5523681417
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-03-12 04:34:42.032234	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	5523681417
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-03-12 04:34:42.033515	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	5523681417
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-03-12 04:34:42.044771	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	5523681417
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2021-03-12 04:34:42.047583	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	5523681417
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-03-12 04:34:42.050213	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	5523681417
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2021-03-12 04:34:42.052265	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	5523681417
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2021-03-12 04:34:42.054008	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	5523681417
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-03-12 04:34:42.055099	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	5523681417
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-03-12 04:34:42.056204	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	5523681417
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2021-03-12 04:34:42.058982	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	5523681417
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-03-12 04:34:42.096461	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	5523681417
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2021-03-12 04:34:42.099085	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	5523681417
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-03-12 04:34:42.103383	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	5523681417
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-03-12 04:34:42.104425	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	5523681417
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-03-12 04:34:42.119802	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	5523681417
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-03-12 04:34:42.121983	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	5523681417
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2021-03-12 04:34:42.134596	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	5523681417
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2021-03-12 04:34:42.143884	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	5523681417
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2021-03-12 04:34:42.145792	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	5523681417
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2021-03-12 04:34:42.147413	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	5523681417
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2021-03-12 04:34:42.14935	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	5523681417
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-03-12 04:34:42.152553	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	5523681417
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-03-12 04:34:42.155726	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	5523681417
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-03-12 04:34:42.164289	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	5523681417
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-03-12 04:34:42.206367	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	5523681417
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2021-03-12 04:34:42.217107	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	5523681417
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2021-03-12 04:34:42.220097	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	5523681417
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-03-12 04:34:42.224165	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	5523681417
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-03-12 04:34:42.226292	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	5523681417
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2021-03-12 04:34:42.227828	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	5523681417
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2021-03-12 04:34:42.22924	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	5523681417
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2021-03-12 04:34:42.230579	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	5523681417
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2021-03-12 04:34:42.235185	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	5523681417
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2021-03-12 04:34:42.237392	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	5523681417
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2021-03-12 04:34:42.239496	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	5523681417
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2021-03-12 04:34:42.243732	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	5523681417
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2021-03-12 04:34:42.246088	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	5523681417
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2021-03-12 04:34:42.247815	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	5523681417
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-03-12 04:34:42.250575	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	5523681417
8.0.0-updating-credential-data-not-oracle	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-03-12 04:34:42.253521	73	EXECUTED	7:03b3f4b264c3c68ba082250a80b74216	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	5523681417
8.0.0-updating-credential-data-oracle	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-03-12 04:34:42.254601	74	MARK_RAN	7:64c5728f5ca1f5aa4392217701c4fe23	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	5523681417
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-03-12 04:34:42.261941	75	EXECUTED	7:b48da8c11a3d83ddd6b7d0c8c2219345	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	5523681417
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-03-12 04:34:42.264556	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	5523681417
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-03-12 04:34:42.266169	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	5523681417
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-03-12 04:34:42.267116	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	5523681417
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-03-12 04:34:42.274846	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	5523681417
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-03-12 04:34:42.276204	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	5523681417
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-03-12 04:34:42.278548	81	EXECUTED	7:45d9b25fc3b455d522d8dcc10a0f4c80	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	3.5.4	\N	\N	5523681417
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-03-12 04:34:42.279531	82	MARK_RAN	7:890ae73712bc187a66c2813a724d037f	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	5523681417
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-03-12 04:34:42.281662	83	EXECUTED	7:0a211980d27fafe3ff50d19a3a29b538	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	5523681417
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-03-12 04:34:42.282844	84	MARK_RAN	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	5523681417
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-03-12 04:34:42.284936	85	EXECUTED	7:01c49302201bdf815b0a18d1f98a55dc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	5523681417
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2021-03-12 04:34:42.287489	86	EXECUTED	7:3dace6b144c11f53f1ad2c0361279b86	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	3.5.4	\N	\N	5523681417
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-03-12 04:34:42.291418	87	EXECUTED	7:578d0b92077eaf2ab95ad0ec087aa903	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	3.5.4	\N	\N	5523681417
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-03-12 04:34:42.29486	88	EXECUTED	7:c95abe90d962c57a09ecaee57972835d	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	3.5.4	\N	\N	5523681417
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	f2e0037f-d017-46e1-a034-177801c83b23	f
master	debc63ab-26ff-4018-ae1c-f462aac09707	t
master	b1388f1c-be05-48bd-8894-5d95938b7029	t
master	d7f05291-7b53-4e6f-a23b-daf00836d7b0	t
master	6a58d7df-17f4-414a-86c8-6697407326c4	f
master	a966db78-54e2-4b5c-9339-7818843e8506	f
master	991d255e-b06f-41b2-83c7-7d7071146643	t
master	f971b5a7-ae3c-46b0-8af1-142fe807bee3	t
master	27c23296-0cc2-4ac2-8c19-2a73253fc3d0	f
Questboard	b786462d-167d-4c4e-b790-3d580a2f19dc	f
Questboard	8452362d-b836-468b-b0ab-76b4885f3632	t
Questboard	c5661577-386a-4a48-a981-e0207e71de5c	t
Questboard	8250b6ca-1b2a-4521-a2f5-06d48a852ec5	t
Questboard	8e2861df-d0c1-4db3-9905-54159988842e	f
Questboard	1975efcb-e81b-4ed5-bc0c-c06192d9abca	f
Questboard	cd23a4c9-cf82-4fa7-b0b9-a9ed75b5c668	t
Questboard	0a1f7157-db6a-437a-9a01-7f078f22a08e	t
Questboard	b3082110-1d80-4c36-8f92-0639e7fe8aea	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	master	f	${role_admin}	admin	master	\N	master
99bfd989-7fe3-457b-a4c7-6e215d9e490a	master	f	${role_create-realm}	create-realm	master	\N	master
d3dfb31d-3645-46d8-84d3-16a239869b9e	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	t	${role_create-client}	create-client	master	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	\N
fb1d8f2b-b47f-44d8-bdfd-f859f67cb7e0	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	t	${role_view-realm}	view-realm	master	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	\N
19bfc427-d136-4dc5-9bc0-cc21eae3f7be	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	t	${role_view-users}	view-users	master	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	\N
6360fce4-48fd-4db3-997c-0dbc55e9ebf7	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	t	${role_view-clients}	view-clients	master	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	\N
cd5a8d4f-d8b7-4c2e-9cbc-aa73f67e977a	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	t	${role_view-events}	view-events	master	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	\N
489f6d4a-8256-46ff-b534-79d942227625	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	t	${role_view-identity-providers}	view-identity-providers	master	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	\N
d2dba1dc-6064-4e6f-8697-af74bca5852b	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	t	${role_view-authorization}	view-authorization	master	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	\N
cbf3b03e-dd46-496f-95b6-a48f599fae09	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	t	${role_manage-realm}	manage-realm	master	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	\N
71b2e1aa-3be1-4590-aebd-6c8bf4bc44bc	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	t	${role_manage-users}	manage-users	master	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	\N
95e9cf28-d27b-46d3-9655-9257a5535bb3	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	t	${role_manage-clients}	manage-clients	master	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	\N
4f594170-2ce7-43af-85b9-411e5f3187ac	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	t	${role_manage-events}	manage-events	master	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	\N
6af27144-7aed-4370-af47-32f5cd1ed13f	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	t	${role_manage-identity-providers}	manage-identity-providers	master	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	\N
34307863-356b-4189-bf75-77dce569cd6c	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	t	${role_manage-authorization}	manage-authorization	master	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	\N
f24d30be-42fe-4abc-9341-b824116ed5ae	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	t	${role_query-users}	query-users	master	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	\N
dceb9897-5846-4ab6-84bc-8b4f65e0317e	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	t	${role_query-clients}	query-clients	master	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	\N
c638ccfd-3d1d-43a3-9930-e0afd3125819	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	t	${role_query-realms}	query-realms	master	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	\N
53763b0b-d633-4ec0-b908-68524a562867	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	t	${role_query-groups}	query-groups	master	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	\N
5e09a80d-c6b5-42dd-8e13-48f529df7d9e	08c97ad9-d906-4644-93bd-ea0584cad180	t	${role_view-profile}	view-profile	master	08c97ad9-d906-4644-93bd-ea0584cad180	\N
f4b1ad07-5b38-4249-8e82-73052a099da7	08c97ad9-d906-4644-93bd-ea0584cad180	t	${role_manage-account}	manage-account	master	08c97ad9-d906-4644-93bd-ea0584cad180	\N
ae68f0c1-1197-4e7c-a205-e28209a089ba	08c97ad9-d906-4644-93bd-ea0584cad180	t	${role_manage-account-links}	manage-account-links	master	08c97ad9-d906-4644-93bd-ea0584cad180	\N
1f1573c8-f804-4a7b-b347-98dea0054803	08c97ad9-d906-4644-93bd-ea0584cad180	t	${role_view-applications}	view-applications	master	08c97ad9-d906-4644-93bd-ea0584cad180	\N
a9788289-9fb3-47f6-a292-99c0a4cf6382	08c97ad9-d906-4644-93bd-ea0584cad180	t	${role_view-consent}	view-consent	master	08c97ad9-d906-4644-93bd-ea0584cad180	\N
bcdc9be7-3063-483c-bc95-64cfb6a94391	08c97ad9-d906-4644-93bd-ea0584cad180	t	${role_manage-consent}	manage-consent	master	08c97ad9-d906-4644-93bd-ea0584cad180	\N
1f075e03-3e41-4049-a971-a71c32ab8dbd	08c97ad9-d906-4644-93bd-ea0584cad180	t	${role_delete-account}	delete-account	master	08c97ad9-d906-4644-93bd-ea0584cad180	\N
59c4afd3-f0e9-42b5-8df4-758cdb0adfd8	902b311b-ba7d-46ce-acdb-6eb9e3136b2c	t	${role_read-token}	read-token	master	902b311b-ba7d-46ce-acdb-6eb9e3136b2c	\N
ad88018b-ef92-432c-b86e-64b1b1ad4c79	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	t	${role_impersonation}	impersonation	master	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	\N
2c0bd327-20dc-4251-9484-44422e9dc412	master	f	${role_offline-access}	offline_access	master	\N	master
a8b38048-1674-4e2a-8e71-19e30075002a	master	f	${role_uma_authorization}	uma_authorization	master	\N	master
49cdd3e0-f69a-4fca-a925-4774d0fb6fa1	ac07db7f-2cc1-4841-876b-40b8516f39f9	t	${role_create-client}	create-client	master	ac07db7f-2cc1-4841-876b-40b8516f39f9	\N
cb1b5cb2-2ca8-4bc2-846e-97568b829e38	ac07db7f-2cc1-4841-876b-40b8516f39f9	t	${role_view-realm}	view-realm	master	ac07db7f-2cc1-4841-876b-40b8516f39f9	\N
61cd3624-a54a-44ac-a72c-a330d706dfcf	ac07db7f-2cc1-4841-876b-40b8516f39f9	t	${role_view-users}	view-users	master	ac07db7f-2cc1-4841-876b-40b8516f39f9	\N
ff33ba52-81d3-40e9-934c-1236fa273bbe	ac07db7f-2cc1-4841-876b-40b8516f39f9	t	${role_view-clients}	view-clients	master	ac07db7f-2cc1-4841-876b-40b8516f39f9	\N
f5556af7-ac31-4364-b65f-dca812af4065	ac07db7f-2cc1-4841-876b-40b8516f39f9	t	${role_view-events}	view-events	master	ac07db7f-2cc1-4841-876b-40b8516f39f9	\N
9056f1f5-74e9-49cc-a7cf-c34da8b9e978	ac07db7f-2cc1-4841-876b-40b8516f39f9	t	${role_view-identity-providers}	view-identity-providers	master	ac07db7f-2cc1-4841-876b-40b8516f39f9	\N
ddfcc463-a053-42da-8182-7bbf8357b3cc	ac07db7f-2cc1-4841-876b-40b8516f39f9	t	${role_view-authorization}	view-authorization	master	ac07db7f-2cc1-4841-876b-40b8516f39f9	\N
cdcc8d40-5ceb-4159-86f4-24a1cc7efa9d	ac07db7f-2cc1-4841-876b-40b8516f39f9	t	${role_manage-realm}	manage-realm	master	ac07db7f-2cc1-4841-876b-40b8516f39f9	\N
c2e61ce2-6889-40f1-850d-4d715a171cba	ac07db7f-2cc1-4841-876b-40b8516f39f9	t	${role_manage-users}	manage-users	master	ac07db7f-2cc1-4841-876b-40b8516f39f9	\N
3d100540-3fc6-44ba-ba41-11d3025bd437	ac07db7f-2cc1-4841-876b-40b8516f39f9	t	${role_manage-clients}	manage-clients	master	ac07db7f-2cc1-4841-876b-40b8516f39f9	\N
a104636e-f3a1-48b5-bb25-894c3e3a017b	ac07db7f-2cc1-4841-876b-40b8516f39f9	t	${role_manage-events}	manage-events	master	ac07db7f-2cc1-4841-876b-40b8516f39f9	\N
c43fab8f-508b-400e-8331-1a39b073df27	ac07db7f-2cc1-4841-876b-40b8516f39f9	t	${role_manage-identity-providers}	manage-identity-providers	master	ac07db7f-2cc1-4841-876b-40b8516f39f9	\N
754669fb-9ccd-4543-95b2-407e571ce009	ac07db7f-2cc1-4841-876b-40b8516f39f9	t	${role_manage-authorization}	manage-authorization	master	ac07db7f-2cc1-4841-876b-40b8516f39f9	\N
736a40a9-4871-4b1a-adb0-9517f7889c0d	ac07db7f-2cc1-4841-876b-40b8516f39f9	t	${role_query-users}	query-users	master	ac07db7f-2cc1-4841-876b-40b8516f39f9	\N
c9e6ee08-c89a-4e86-9bd5-3a6a4584d827	ac07db7f-2cc1-4841-876b-40b8516f39f9	t	${role_query-clients}	query-clients	master	ac07db7f-2cc1-4841-876b-40b8516f39f9	\N
2fdede4e-ee1f-4cb2-802b-20ab1e731cee	ac07db7f-2cc1-4841-876b-40b8516f39f9	t	${role_query-realms}	query-realms	master	ac07db7f-2cc1-4841-876b-40b8516f39f9	\N
7d6f1f9f-dd0a-4a57-b79d-bfc8da32dc5c	ac07db7f-2cc1-4841-876b-40b8516f39f9	t	${role_query-groups}	query-groups	master	ac07db7f-2cc1-4841-876b-40b8516f39f9	\N
7076af5a-3971-4f57-b413-ab896b892f83	b8d50ca6-d208-439e-9f34-31f53efdb740	t	${role_realm-admin}	realm-admin	Questboard	b8d50ca6-d208-439e-9f34-31f53efdb740	\N
73a0f8a9-1835-4f87-8379-c723dd90161a	b8d50ca6-d208-439e-9f34-31f53efdb740	t	${role_create-client}	create-client	Questboard	b8d50ca6-d208-439e-9f34-31f53efdb740	\N
8e7e2072-a7e5-4024-8b0c-e95a79f36a48	b8d50ca6-d208-439e-9f34-31f53efdb740	t	${role_view-realm}	view-realm	Questboard	b8d50ca6-d208-439e-9f34-31f53efdb740	\N
2c1d1649-d428-431b-a76f-fa4fc7a74197	b8d50ca6-d208-439e-9f34-31f53efdb740	t	${role_view-users}	view-users	Questboard	b8d50ca6-d208-439e-9f34-31f53efdb740	\N
65a9dbca-8d99-4081-907f-93be1ac6d3d8	b8d50ca6-d208-439e-9f34-31f53efdb740	t	${role_view-clients}	view-clients	Questboard	b8d50ca6-d208-439e-9f34-31f53efdb740	\N
1fb30f79-5ea7-4382-9be7-6fdebdbe85c2	b8d50ca6-d208-439e-9f34-31f53efdb740	t	${role_view-events}	view-events	Questboard	b8d50ca6-d208-439e-9f34-31f53efdb740	\N
2d9d58b2-ad94-40b9-b9c7-cc8c6c152e21	b8d50ca6-d208-439e-9f34-31f53efdb740	t	${role_view-identity-providers}	view-identity-providers	Questboard	b8d50ca6-d208-439e-9f34-31f53efdb740	\N
da3079dd-89c7-4660-982e-4eaa9b9d9713	b8d50ca6-d208-439e-9f34-31f53efdb740	t	${role_view-authorization}	view-authorization	Questboard	b8d50ca6-d208-439e-9f34-31f53efdb740	\N
bfcbd550-8d7a-40dd-84ca-20741ae98072	b8d50ca6-d208-439e-9f34-31f53efdb740	t	${role_manage-realm}	manage-realm	Questboard	b8d50ca6-d208-439e-9f34-31f53efdb740	\N
7facf9b2-fa5d-43e4-b0cd-22f96b5f4c14	b8d50ca6-d208-439e-9f34-31f53efdb740	t	${role_manage-users}	manage-users	Questboard	b8d50ca6-d208-439e-9f34-31f53efdb740	\N
118cccb0-4cfb-4f50-9fe1-0a9219ac114f	b8d50ca6-d208-439e-9f34-31f53efdb740	t	${role_manage-clients}	manage-clients	Questboard	b8d50ca6-d208-439e-9f34-31f53efdb740	\N
09944bb1-3607-40fd-97b0-de90a866df1d	b8d50ca6-d208-439e-9f34-31f53efdb740	t	${role_manage-events}	manage-events	Questboard	b8d50ca6-d208-439e-9f34-31f53efdb740	\N
b3e7405d-9030-4b38-9315-79998bce78fe	b8d50ca6-d208-439e-9f34-31f53efdb740	t	${role_manage-identity-providers}	manage-identity-providers	Questboard	b8d50ca6-d208-439e-9f34-31f53efdb740	\N
a5554466-707a-4626-9c4a-7866532eaa85	b8d50ca6-d208-439e-9f34-31f53efdb740	t	${role_manage-authorization}	manage-authorization	Questboard	b8d50ca6-d208-439e-9f34-31f53efdb740	\N
76e49676-b916-4592-977d-f13d7397a6b1	b8d50ca6-d208-439e-9f34-31f53efdb740	t	${role_query-users}	query-users	Questboard	b8d50ca6-d208-439e-9f34-31f53efdb740	\N
d921bb19-b773-4451-8f8c-e357079a216e	b8d50ca6-d208-439e-9f34-31f53efdb740	t	${role_query-clients}	query-clients	Questboard	b8d50ca6-d208-439e-9f34-31f53efdb740	\N
ee67d5ab-7eb7-4548-aaaf-1ea19b96c2fd	b8d50ca6-d208-439e-9f34-31f53efdb740	t	${role_query-realms}	query-realms	Questboard	b8d50ca6-d208-439e-9f34-31f53efdb740	\N
4b07e0fb-a472-41b5-a435-94a89a2fbb75	b8d50ca6-d208-439e-9f34-31f53efdb740	t	${role_query-groups}	query-groups	Questboard	b8d50ca6-d208-439e-9f34-31f53efdb740	\N
c49ec061-2d19-4bd7-b738-3c79e7cb0f16	52bd5914-a6e4-4757-87dd-effc52813817	t	${role_view-profile}	view-profile	Questboard	52bd5914-a6e4-4757-87dd-effc52813817	\N
923a0957-09f1-47bf-b886-c2fa0814c72a	52bd5914-a6e4-4757-87dd-effc52813817	t	${role_manage-account}	manage-account	Questboard	52bd5914-a6e4-4757-87dd-effc52813817	\N
737b1c7f-35b0-4851-9613-f15a22da6391	52bd5914-a6e4-4757-87dd-effc52813817	t	${role_manage-account-links}	manage-account-links	Questboard	52bd5914-a6e4-4757-87dd-effc52813817	\N
01f0992d-8251-4844-869e-2ad0b836f9cd	52bd5914-a6e4-4757-87dd-effc52813817	t	${role_view-applications}	view-applications	Questboard	52bd5914-a6e4-4757-87dd-effc52813817	\N
5a347940-d692-48e1-a065-7788e708c10c	52bd5914-a6e4-4757-87dd-effc52813817	t	${role_view-consent}	view-consent	Questboard	52bd5914-a6e4-4757-87dd-effc52813817	\N
8f1c536d-12ea-4fec-9e40-19249fef6883	52bd5914-a6e4-4757-87dd-effc52813817	t	${role_manage-consent}	manage-consent	Questboard	52bd5914-a6e4-4757-87dd-effc52813817	\N
ee0fb961-8d16-4d49-9050-c62cf52a04eb	52bd5914-a6e4-4757-87dd-effc52813817	t	${role_delete-account}	delete-account	Questboard	52bd5914-a6e4-4757-87dd-effc52813817	\N
e539cd54-7bdc-4da1-bf69-40359aee3c53	ac07db7f-2cc1-4841-876b-40b8516f39f9	t	${role_impersonation}	impersonation	master	ac07db7f-2cc1-4841-876b-40b8516f39f9	\N
99cf60c5-d93c-43d2-8ee3-e9ec889fd612	b8d50ca6-d208-439e-9f34-31f53efdb740	t	${role_impersonation}	impersonation	Questboard	b8d50ca6-d208-439e-9f34-31f53efdb740	\N
4457e86a-7a73-4034-8d5b-fffde215589d	5b51b2e4-dcda-44db-ac85-8b24fc91dbf4	t	${role_read-token}	read-token	Questboard	5b51b2e4-dcda-44db-ac85-8b24fc91dbf4	\N
a6a12309-c484-497a-907f-0467489253b8	Questboard	f	${role_offline-access}	offline_access	Questboard	\N	Questboard
6f91c7ad-8161-41f6-846e-5b34291faaf6	Questboard	f	${role_uma_authorization}	uma_authorization	Questboard	\N	Questboard
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
c3o13	12.0.4	1615523684
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
ad9175f1-7e6b-4158-85c2-98189716fcb3	audience resolve	openid-connect	oidc-audience-resolve-mapper	abab6a4a-5863-456c-8348-10e029a86820	\N
c79aa790-f896-4dce-a7b9-ef93f4c77b7b	locale	openid-connect	oidc-usermodel-attribute-mapper	d1055f6d-d48d-4be5-a2de-f748e592a2a3	\N
a290f8d1-2ff5-42ae-9854-2d8935a285f5	role list	saml	saml-role-list-mapper	\N	debc63ab-26ff-4018-ae1c-f462aac09707
f5823836-5f74-4b60-bacb-109047f4fda3	full name	openid-connect	oidc-full-name-mapper	\N	b1388f1c-be05-48bd-8894-5d95938b7029
bb8cdd58-86bc-4973-8fa8-a259aa09b906	family name	openid-connect	oidc-usermodel-property-mapper	\N	b1388f1c-be05-48bd-8894-5d95938b7029
3ba473cc-c552-4aaa-a584-9299114d0497	given name	openid-connect	oidc-usermodel-property-mapper	\N	b1388f1c-be05-48bd-8894-5d95938b7029
3156b6a8-d094-42f5-91ee-48442291896e	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	b1388f1c-be05-48bd-8894-5d95938b7029
cd2d2dbb-e17c-4897-9417-487c63ba5440	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	b1388f1c-be05-48bd-8894-5d95938b7029
807daa15-9378-4dfb-bcb9-89fe580e645a	username	openid-connect	oidc-usermodel-property-mapper	\N	b1388f1c-be05-48bd-8894-5d95938b7029
5a84fb21-ffd1-4cf9-9754-0567d213b946	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	b1388f1c-be05-48bd-8894-5d95938b7029
1c128130-2576-4be9-a17a-90487d647a6c	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	b1388f1c-be05-48bd-8894-5d95938b7029
d4af70ed-3200-4b04-a3f4-fbfcd7b61b6b	website	openid-connect	oidc-usermodel-attribute-mapper	\N	b1388f1c-be05-48bd-8894-5d95938b7029
29515513-5b19-482c-800e-df96c3f3469b	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	b1388f1c-be05-48bd-8894-5d95938b7029
9cf7345b-f9ec-46f5-bf02-0d5279da6b11	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	b1388f1c-be05-48bd-8894-5d95938b7029
89d3e453-ca76-4492-9d84-99adb68b62f0	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	b1388f1c-be05-48bd-8894-5d95938b7029
f7d83d0f-b44c-4a2c-b059-9c867a0f787e	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	b1388f1c-be05-48bd-8894-5d95938b7029
2a9dfc0a-0989-4b1c-a4ed-7fe5e6d900c0	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	b1388f1c-be05-48bd-8894-5d95938b7029
e0a8b5f3-3ba2-432b-8b5e-5f1e3298888f	email	openid-connect	oidc-usermodel-property-mapper	\N	d7f05291-7b53-4e6f-a23b-daf00836d7b0
1c39fa91-3e94-4170-af87-923554f443c9	email verified	openid-connect	oidc-usermodel-property-mapper	\N	d7f05291-7b53-4e6f-a23b-daf00836d7b0
810a8837-ad77-4a19-b571-68266944b5d1	address	openid-connect	oidc-address-mapper	\N	6a58d7df-17f4-414a-86c8-6697407326c4
a81f0d1b-2927-49f8-b761-36bd8fd4a871	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	a966db78-54e2-4b5c-9339-7818843e8506
2bedb3f0-07e8-4480-8c50-42fce9288f37	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	a966db78-54e2-4b5c-9339-7818843e8506
3dfc3311-d1d6-474e-bb84-046ab83cf832	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	991d255e-b06f-41b2-83c7-7d7071146643
cfda81a0-9ba7-4563-8c35-0121d7a69548	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	991d255e-b06f-41b2-83c7-7d7071146643
336a63e5-4be8-4e6a-9c29-498102b62843	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	991d255e-b06f-41b2-83c7-7d7071146643
b6707517-9b52-40dd-a3fb-bb1cff0ed88f	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	f971b5a7-ae3c-46b0-8af1-142fe807bee3
3df0b26c-3157-43fd-bb1c-2cc7f3003b84	upn	openid-connect	oidc-usermodel-property-mapper	\N	27c23296-0cc2-4ac2-8c19-2a73253fc3d0
7369e539-aca3-431b-9356-e5dea9044bb4	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	27c23296-0cc2-4ac2-8c19-2a73253fc3d0
e53f19e4-abe5-4700-bb92-8525c53db6ae	audience resolve	openid-connect	oidc-audience-resolve-mapper	79f4d5db-6766-48a6-a093-1a8d5b48c2ff	\N
e8899f5c-cafd-43a1-b1fa-5f428c20dd9d	role list	saml	saml-role-list-mapper	\N	8452362d-b836-468b-b0ab-76b4885f3632
ee520e1f-0a20-4db9-b4d5-f025f07bcce1	full name	openid-connect	oidc-full-name-mapper	\N	c5661577-386a-4a48-a981-e0207e71de5c
12ba3056-42ac-4f37-a971-77d83469339d	family name	openid-connect	oidc-usermodel-property-mapper	\N	c5661577-386a-4a48-a981-e0207e71de5c
fe94c7cd-0c30-406c-902a-2c75fabe290c	given name	openid-connect	oidc-usermodel-property-mapper	\N	c5661577-386a-4a48-a981-e0207e71de5c
63a45c08-ab98-45f3-9435-38d070bc109b	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	c5661577-386a-4a48-a981-e0207e71de5c
6c492d76-8298-4946-b870-58ee27feb38c	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	c5661577-386a-4a48-a981-e0207e71de5c
8ffc5aac-91bd-4177-be8d-3ae4261f6199	username	openid-connect	oidc-usermodel-property-mapper	\N	c5661577-386a-4a48-a981-e0207e71de5c
80d882b6-3c03-4028-a781-70109803a58f	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	c5661577-386a-4a48-a981-e0207e71de5c
f0029b32-0705-404f-9273-22009d03c865	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	c5661577-386a-4a48-a981-e0207e71de5c
dc9c3168-c959-4921-8121-82f63e1f3ee6	website	openid-connect	oidc-usermodel-attribute-mapper	\N	c5661577-386a-4a48-a981-e0207e71de5c
4b88bc4a-56e4-4d2b-9d3e-6598167d6d9d	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	c5661577-386a-4a48-a981-e0207e71de5c
52a1da40-163d-48fa-94c8-e079fdcff872	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	c5661577-386a-4a48-a981-e0207e71de5c
4a6214cd-5624-49cd-b9d8-2d3bbdd49234	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	c5661577-386a-4a48-a981-e0207e71de5c
e5ff1360-0af4-43c1-8395-5170fab55d3f	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	c5661577-386a-4a48-a981-e0207e71de5c
0ca30bfc-68d2-4105-8ff5-342730ed8e04	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	c5661577-386a-4a48-a981-e0207e71de5c
c0536b5c-2631-4f39-9832-aca9d8263987	email	openid-connect	oidc-usermodel-property-mapper	\N	8250b6ca-1b2a-4521-a2f5-06d48a852ec5
bbc8bb95-e7b8-4461-92ed-6e345fd535bb	email verified	openid-connect	oidc-usermodel-property-mapper	\N	8250b6ca-1b2a-4521-a2f5-06d48a852ec5
9977ace3-6b29-4cf5-b522-b4f509ccf448	address	openid-connect	oidc-address-mapper	\N	8e2861df-d0c1-4db3-9905-54159988842e
0208e233-d6fb-4229-82a1-0fcdcf21f179	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	1975efcb-e81b-4ed5-bc0c-c06192d9abca
f4b11139-52b0-4267-b9a8-bd2dfaab06d7	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	1975efcb-e81b-4ed5-bc0c-c06192d9abca
3496904c-b684-4fad-8948-44944c88154b	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	cd23a4c9-cf82-4fa7-b0b9-a9ed75b5c668
e269e484-563d-4b8c-936e-e261bb6b79d4	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	cd23a4c9-cf82-4fa7-b0b9-a9ed75b5c668
9a435ef3-7ce3-4cf7-a18c-137cf6676ffc	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	cd23a4c9-cf82-4fa7-b0b9-a9ed75b5c668
a3562813-73c5-48ee-9686-39b4a3721836	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	0a1f7157-db6a-437a-9a01-7f078f22a08e
441edd4e-82fb-4a85-98f3-534fef8713ee	upn	openid-connect	oidc-usermodel-property-mapper	\N	b3082110-1d80-4c36-8f92-0639e7fe8aea
55989ce9-0c69-4301-aa50-decee2e1dd34	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	b3082110-1d80-4c36-8f92-0639e7fe8aea
3d6eff80-84a2-454d-85ae-f0c520ae9fc0	locale	openid-connect	oidc-usermodel-attribute-mapper	94f39d5d-d7f4-419b-a7dc-32c526849238	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
c79aa790-f896-4dce-a7b9-ef93f4c77b7b	true	userinfo.token.claim
c79aa790-f896-4dce-a7b9-ef93f4c77b7b	locale	user.attribute
c79aa790-f896-4dce-a7b9-ef93f4c77b7b	true	id.token.claim
c79aa790-f896-4dce-a7b9-ef93f4c77b7b	true	access.token.claim
c79aa790-f896-4dce-a7b9-ef93f4c77b7b	locale	claim.name
c79aa790-f896-4dce-a7b9-ef93f4c77b7b	String	jsonType.label
a290f8d1-2ff5-42ae-9854-2d8935a285f5	false	single
a290f8d1-2ff5-42ae-9854-2d8935a285f5	Basic	attribute.nameformat
a290f8d1-2ff5-42ae-9854-2d8935a285f5	Role	attribute.name
f5823836-5f74-4b60-bacb-109047f4fda3	true	userinfo.token.claim
f5823836-5f74-4b60-bacb-109047f4fda3	true	id.token.claim
f5823836-5f74-4b60-bacb-109047f4fda3	true	access.token.claim
bb8cdd58-86bc-4973-8fa8-a259aa09b906	true	userinfo.token.claim
bb8cdd58-86bc-4973-8fa8-a259aa09b906	lastName	user.attribute
bb8cdd58-86bc-4973-8fa8-a259aa09b906	true	id.token.claim
bb8cdd58-86bc-4973-8fa8-a259aa09b906	true	access.token.claim
bb8cdd58-86bc-4973-8fa8-a259aa09b906	family_name	claim.name
bb8cdd58-86bc-4973-8fa8-a259aa09b906	String	jsonType.label
3ba473cc-c552-4aaa-a584-9299114d0497	true	userinfo.token.claim
3ba473cc-c552-4aaa-a584-9299114d0497	firstName	user.attribute
3ba473cc-c552-4aaa-a584-9299114d0497	true	id.token.claim
3ba473cc-c552-4aaa-a584-9299114d0497	true	access.token.claim
3ba473cc-c552-4aaa-a584-9299114d0497	given_name	claim.name
3ba473cc-c552-4aaa-a584-9299114d0497	String	jsonType.label
3156b6a8-d094-42f5-91ee-48442291896e	true	userinfo.token.claim
3156b6a8-d094-42f5-91ee-48442291896e	middleName	user.attribute
3156b6a8-d094-42f5-91ee-48442291896e	true	id.token.claim
3156b6a8-d094-42f5-91ee-48442291896e	true	access.token.claim
3156b6a8-d094-42f5-91ee-48442291896e	middle_name	claim.name
3156b6a8-d094-42f5-91ee-48442291896e	String	jsonType.label
cd2d2dbb-e17c-4897-9417-487c63ba5440	true	userinfo.token.claim
cd2d2dbb-e17c-4897-9417-487c63ba5440	nickname	user.attribute
cd2d2dbb-e17c-4897-9417-487c63ba5440	true	id.token.claim
cd2d2dbb-e17c-4897-9417-487c63ba5440	true	access.token.claim
cd2d2dbb-e17c-4897-9417-487c63ba5440	nickname	claim.name
cd2d2dbb-e17c-4897-9417-487c63ba5440	String	jsonType.label
807daa15-9378-4dfb-bcb9-89fe580e645a	true	userinfo.token.claim
807daa15-9378-4dfb-bcb9-89fe580e645a	username	user.attribute
807daa15-9378-4dfb-bcb9-89fe580e645a	true	id.token.claim
807daa15-9378-4dfb-bcb9-89fe580e645a	true	access.token.claim
807daa15-9378-4dfb-bcb9-89fe580e645a	preferred_username	claim.name
807daa15-9378-4dfb-bcb9-89fe580e645a	String	jsonType.label
5a84fb21-ffd1-4cf9-9754-0567d213b946	true	userinfo.token.claim
5a84fb21-ffd1-4cf9-9754-0567d213b946	profile	user.attribute
5a84fb21-ffd1-4cf9-9754-0567d213b946	true	id.token.claim
5a84fb21-ffd1-4cf9-9754-0567d213b946	true	access.token.claim
5a84fb21-ffd1-4cf9-9754-0567d213b946	profile	claim.name
5a84fb21-ffd1-4cf9-9754-0567d213b946	String	jsonType.label
1c128130-2576-4be9-a17a-90487d647a6c	true	userinfo.token.claim
1c128130-2576-4be9-a17a-90487d647a6c	picture	user.attribute
1c128130-2576-4be9-a17a-90487d647a6c	true	id.token.claim
1c128130-2576-4be9-a17a-90487d647a6c	true	access.token.claim
1c128130-2576-4be9-a17a-90487d647a6c	picture	claim.name
1c128130-2576-4be9-a17a-90487d647a6c	String	jsonType.label
d4af70ed-3200-4b04-a3f4-fbfcd7b61b6b	true	userinfo.token.claim
d4af70ed-3200-4b04-a3f4-fbfcd7b61b6b	website	user.attribute
d4af70ed-3200-4b04-a3f4-fbfcd7b61b6b	true	id.token.claim
d4af70ed-3200-4b04-a3f4-fbfcd7b61b6b	true	access.token.claim
d4af70ed-3200-4b04-a3f4-fbfcd7b61b6b	website	claim.name
d4af70ed-3200-4b04-a3f4-fbfcd7b61b6b	String	jsonType.label
29515513-5b19-482c-800e-df96c3f3469b	true	userinfo.token.claim
29515513-5b19-482c-800e-df96c3f3469b	gender	user.attribute
29515513-5b19-482c-800e-df96c3f3469b	true	id.token.claim
29515513-5b19-482c-800e-df96c3f3469b	true	access.token.claim
29515513-5b19-482c-800e-df96c3f3469b	gender	claim.name
29515513-5b19-482c-800e-df96c3f3469b	String	jsonType.label
9cf7345b-f9ec-46f5-bf02-0d5279da6b11	true	userinfo.token.claim
9cf7345b-f9ec-46f5-bf02-0d5279da6b11	birthdate	user.attribute
9cf7345b-f9ec-46f5-bf02-0d5279da6b11	true	id.token.claim
9cf7345b-f9ec-46f5-bf02-0d5279da6b11	true	access.token.claim
9cf7345b-f9ec-46f5-bf02-0d5279da6b11	birthdate	claim.name
9cf7345b-f9ec-46f5-bf02-0d5279da6b11	String	jsonType.label
89d3e453-ca76-4492-9d84-99adb68b62f0	true	userinfo.token.claim
89d3e453-ca76-4492-9d84-99adb68b62f0	zoneinfo	user.attribute
89d3e453-ca76-4492-9d84-99adb68b62f0	true	id.token.claim
89d3e453-ca76-4492-9d84-99adb68b62f0	true	access.token.claim
89d3e453-ca76-4492-9d84-99adb68b62f0	zoneinfo	claim.name
89d3e453-ca76-4492-9d84-99adb68b62f0	String	jsonType.label
f7d83d0f-b44c-4a2c-b059-9c867a0f787e	true	userinfo.token.claim
f7d83d0f-b44c-4a2c-b059-9c867a0f787e	locale	user.attribute
f7d83d0f-b44c-4a2c-b059-9c867a0f787e	true	id.token.claim
f7d83d0f-b44c-4a2c-b059-9c867a0f787e	true	access.token.claim
f7d83d0f-b44c-4a2c-b059-9c867a0f787e	locale	claim.name
f7d83d0f-b44c-4a2c-b059-9c867a0f787e	String	jsonType.label
2a9dfc0a-0989-4b1c-a4ed-7fe5e6d900c0	true	userinfo.token.claim
2a9dfc0a-0989-4b1c-a4ed-7fe5e6d900c0	updatedAt	user.attribute
2a9dfc0a-0989-4b1c-a4ed-7fe5e6d900c0	true	id.token.claim
2a9dfc0a-0989-4b1c-a4ed-7fe5e6d900c0	true	access.token.claim
2a9dfc0a-0989-4b1c-a4ed-7fe5e6d900c0	updated_at	claim.name
2a9dfc0a-0989-4b1c-a4ed-7fe5e6d900c0	String	jsonType.label
e0a8b5f3-3ba2-432b-8b5e-5f1e3298888f	true	userinfo.token.claim
e0a8b5f3-3ba2-432b-8b5e-5f1e3298888f	email	user.attribute
e0a8b5f3-3ba2-432b-8b5e-5f1e3298888f	true	id.token.claim
e0a8b5f3-3ba2-432b-8b5e-5f1e3298888f	true	access.token.claim
e0a8b5f3-3ba2-432b-8b5e-5f1e3298888f	email	claim.name
e0a8b5f3-3ba2-432b-8b5e-5f1e3298888f	String	jsonType.label
1c39fa91-3e94-4170-af87-923554f443c9	true	userinfo.token.claim
1c39fa91-3e94-4170-af87-923554f443c9	emailVerified	user.attribute
1c39fa91-3e94-4170-af87-923554f443c9	true	id.token.claim
1c39fa91-3e94-4170-af87-923554f443c9	true	access.token.claim
1c39fa91-3e94-4170-af87-923554f443c9	email_verified	claim.name
1c39fa91-3e94-4170-af87-923554f443c9	boolean	jsonType.label
810a8837-ad77-4a19-b571-68266944b5d1	formatted	user.attribute.formatted
810a8837-ad77-4a19-b571-68266944b5d1	country	user.attribute.country
810a8837-ad77-4a19-b571-68266944b5d1	postal_code	user.attribute.postal_code
810a8837-ad77-4a19-b571-68266944b5d1	true	userinfo.token.claim
810a8837-ad77-4a19-b571-68266944b5d1	street	user.attribute.street
810a8837-ad77-4a19-b571-68266944b5d1	true	id.token.claim
810a8837-ad77-4a19-b571-68266944b5d1	region	user.attribute.region
810a8837-ad77-4a19-b571-68266944b5d1	true	access.token.claim
810a8837-ad77-4a19-b571-68266944b5d1	locality	user.attribute.locality
a81f0d1b-2927-49f8-b761-36bd8fd4a871	true	userinfo.token.claim
a81f0d1b-2927-49f8-b761-36bd8fd4a871	phoneNumber	user.attribute
a81f0d1b-2927-49f8-b761-36bd8fd4a871	true	id.token.claim
a81f0d1b-2927-49f8-b761-36bd8fd4a871	true	access.token.claim
a81f0d1b-2927-49f8-b761-36bd8fd4a871	phone_number	claim.name
a81f0d1b-2927-49f8-b761-36bd8fd4a871	String	jsonType.label
2bedb3f0-07e8-4480-8c50-42fce9288f37	true	userinfo.token.claim
2bedb3f0-07e8-4480-8c50-42fce9288f37	phoneNumberVerified	user.attribute
2bedb3f0-07e8-4480-8c50-42fce9288f37	true	id.token.claim
2bedb3f0-07e8-4480-8c50-42fce9288f37	true	access.token.claim
2bedb3f0-07e8-4480-8c50-42fce9288f37	phone_number_verified	claim.name
2bedb3f0-07e8-4480-8c50-42fce9288f37	boolean	jsonType.label
3dfc3311-d1d6-474e-bb84-046ab83cf832	true	multivalued
3dfc3311-d1d6-474e-bb84-046ab83cf832	foo	user.attribute
3dfc3311-d1d6-474e-bb84-046ab83cf832	true	access.token.claim
3dfc3311-d1d6-474e-bb84-046ab83cf832	realm_access.roles	claim.name
3dfc3311-d1d6-474e-bb84-046ab83cf832	String	jsonType.label
cfda81a0-9ba7-4563-8c35-0121d7a69548	true	multivalued
cfda81a0-9ba7-4563-8c35-0121d7a69548	foo	user.attribute
cfda81a0-9ba7-4563-8c35-0121d7a69548	true	access.token.claim
cfda81a0-9ba7-4563-8c35-0121d7a69548	resource_access.${client_id}.roles	claim.name
cfda81a0-9ba7-4563-8c35-0121d7a69548	String	jsonType.label
3df0b26c-3157-43fd-bb1c-2cc7f3003b84	true	userinfo.token.claim
3df0b26c-3157-43fd-bb1c-2cc7f3003b84	username	user.attribute
3df0b26c-3157-43fd-bb1c-2cc7f3003b84	true	id.token.claim
3df0b26c-3157-43fd-bb1c-2cc7f3003b84	true	access.token.claim
3df0b26c-3157-43fd-bb1c-2cc7f3003b84	upn	claim.name
3df0b26c-3157-43fd-bb1c-2cc7f3003b84	String	jsonType.label
7369e539-aca3-431b-9356-e5dea9044bb4	true	multivalued
7369e539-aca3-431b-9356-e5dea9044bb4	foo	user.attribute
7369e539-aca3-431b-9356-e5dea9044bb4	true	id.token.claim
7369e539-aca3-431b-9356-e5dea9044bb4	true	access.token.claim
7369e539-aca3-431b-9356-e5dea9044bb4	groups	claim.name
7369e539-aca3-431b-9356-e5dea9044bb4	String	jsonType.label
e8899f5c-cafd-43a1-b1fa-5f428c20dd9d	false	single
e8899f5c-cafd-43a1-b1fa-5f428c20dd9d	Basic	attribute.nameformat
e8899f5c-cafd-43a1-b1fa-5f428c20dd9d	Role	attribute.name
ee520e1f-0a20-4db9-b4d5-f025f07bcce1	true	userinfo.token.claim
ee520e1f-0a20-4db9-b4d5-f025f07bcce1	true	id.token.claim
ee520e1f-0a20-4db9-b4d5-f025f07bcce1	true	access.token.claim
12ba3056-42ac-4f37-a971-77d83469339d	true	userinfo.token.claim
12ba3056-42ac-4f37-a971-77d83469339d	lastName	user.attribute
12ba3056-42ac-4f37-a971-77d83469339d	true	id.token.claim
12ba3056-42ac-4f37-a971-77d83469339d	true	access.token.claim
12ba3056-42ac-4f37-a971-77d83469339d	family_name	claim.name
12ba3056-42ac-4f37-a971-77d83469339d	String	jsonType.label
fe94c7cd-0c30-406c-902a-2c75fabe290c	true	userinfo.token.claim
fe94c7cd-0c30-406c-902a-2c75fabe290c	firstName	user.attribute
fe94c7cd-0c30-406c-902a-2c75fabe290c	true	id.token.claim
fe94c7cd-0c30-406c-902a-2c75fabe290c	true	access.token.claim
fe94c7cd-0c30-406c-902a-2c75fabe290c	given_name	claim.name
fe94c7cd-0c30-406c-902a-2c75fabe290c	String	jsonType.label
63a45c08-ab98-45f3-9435-38d070bc109b	true	userinfo.token.claim
63a45c08-ab98-45f3-9435-38d070bc109b	middleName	user.attribute
63a45c08-ab98-45f3-9435-38d070bc109b	true	id.token.claim
63a45c08-ab98-45f3-9435-38d070bc109b	true	access.token.claim
63a45c08-ab98-45f3-9435-38d070bc109b	middle_name	claim.name
63a45c08-ab98-45f3-9435-38d070bc109b	String	jsonType.label
6c492d76-8298-4946-b870-58ee27feb38c	true	userinfo.token.claim
6c492d76-8298-4946-b870-58ee27feb38c	nickname	user.attribute
6c492d76-8298-4946-b870-58ee27feb38c	true	id.token.claim
6c492d76-8298-4946-b870-58ee27feb38c	true	access.token.claim
6c492d76-8298-4946-b870-58ee27feb38c	nickname	claim.name
6c492d76-8298-4946-b870-58ee27feb38c	String	jsonType.label
8ffc5aac-91bd-4177-be8d-3ae4261f6199	true	userinfo.token.claim
8ffc5aac-91bd-4177-be8d-3ae4261f6199	username	user.attribute
8ffc5aac-91bd-4177-be8d-3ae4261f6199	true	id.token.claim
8ffc5aac-91bd-4177-be8d-3ae4261f6199	true	access.token.claim
8ffc5aac-91bd-4177-be8d-3ae4261f6199	preferred_username	claim.name
8ffc5aac-91bd-4177-be8d-3ae4261f6199	String	jsonType.label
80d882b6-3c03-4028-a781-70109803a58f	true	userinfo.token.claim
80d882b6-3c03-4028-a781-70109803a58f	profile	user.attribute
80d882b6-3c03-4028-a781-70109803a58f	true	id.token.claim
80d882b6-3c03-4028-a781-70109803a58f	true	access.token.claim
80d882b6-3c03-4028-a781-70109803a58f	profile	claim.name
80d882b6-3c03-4028-a781-70109803a58f	String	jsonType.label
f0029b32-0705-404f-9273-22009d03c865	true	userinfo.token.claim
f0029b32-0705-404f-9273-22009d03c865	picture	user.attribute
f0029b32-0705-404f-9273-22009d03c865	true	id.token.claim
f0029b32-0705-404f-9273-22009d03c865	true	access.token.claim
f0029b32-0705-404f-9273-22009d03c865	picture	claim.name
f0029b32-0705-404f-9273-22009d03c865	String	jsonType.label
dc9c3168-c959-4921-8121-82f63e1f3ee6	true	userinfo.token.claim
dc9c3168-c959-4921-8121-82f63e1f3ee6	website	user.attribute
dc9c3168-c959-4921-8121-82f63e1f3ee6	true	id.token.claim
dc9c3168-c959-4921-8121-82f63e1f3ee6	true	access.token.claim
dc9c3168-c959-4921-8121-82f63e1f3ee6	website	claim.name
dc9c3168-c959-4921-8121-82f63e1f3ee6	String	jsonType.label
4b88bc4a-56e4-4d2b-9d3e-6598167d6d9d	true	userinfo.token.claim
4b88bc4a-56e4-4d2b-9d3e-6598167d6d9d	gender	user.attribute
4b88bc4a-56e4-4d2b-9d3e-6598167d6d9d	true	id.token.claim
4b88bc4a-56e4-4d2b-9d3e-6598167d6d9d	true	access.token.claim
4b88bc4a-56e4-4d2b-9d3e-6598167d6d9d	gender	claim.name
4b88bc4a-56e4-4d2b-9d3e-6598167d6d9d	String	jsonType.label
52a1da40-163d-48fa-94c8-e079fdcff872	true	userinfo.token.claim
52a1da40-163d-48fa-94c8-e079fdcff872	birthdate	user.attribute
52a1da40-163d-48fa-94c8-e079fdcff872	true	id.token.claim
52a1da40-163d-48fa-94c8-e079fdcff872	true	access.token.claim
52a1da40-163d-48fa-94c8-e079fdcff872	birthdate	claim.name
52a1da40-163d-48fa-94c8-e079fdcff872	String	jsonType.label
4a6214cd-5624-49cd-b9d8-2d3bbdd49234	true	userinfo.token.claim
4a6214cd-5624-49cd-b9d8-2d3bbdd49234	zoneinfo	user.attribute
4a6214cd-5624-49cd-b9d8-2d3bbdd49234	true	id.token.claim
4a6214cd-5624-49cd-b9d8-2d3bbdd49234	true	access.token.claim
4a6214cd-5624-49cd-b9d8-2d3bbdd49234	zoneinfo	claim.name
4a6214cd-5624-49cd-b9d8-2d3bbdd49234	String	jsonType.label
e5ff1360-0af4-43c1-8395-5170fab55d3f	true	userinfo.token.claim
e5ff1360-0af4-43c1-8395-5170fab55d3f	locale	user.attribute
e5ff1360-0af4-43c1-8395-5170fab55d3f	true	id.token.claim
e5ff1360-0af4-43c1-8395-5170fab55d3f	true	access.token.claim
e5ff1360-0af4-43c1-8395-5170fab55d3f	locale	claim.name
e5ff1360-0af4-43c1-8395-5170fab55d3f	String	jsonType.label
0ca30bfc-68d2-4105-8ff5-342730ed8e04	true	userinfo.token.claim
0ca30bfc-68d2-4105-8ff5-342730ed8e04	updatedAt	user.attribute
0ca30bfc-68d2-4105-8ff5-342730ed8e04	true	id.token.claim
0ca30bfc-68d2-4105-8ff5-342730ed8e04	true	access.token.claim
0ca30bfc-68d2-4105-8ff5-342730ed8e04	updated_at	claim.name
0ca30bfc-68d2-4105-8ff5-342730ed8e04	String	jsonType.label
c0536b5c-2631-4f39-9832-aca9d8263987	true	userinfo.token.claim
c0536b5c-2631-4f39-9832-aca9d8263987	email	user.attribute
c0536b5c-2631-4f39-9832-aca9d8263987	true	id.token.claim
c0536b5c-2631-4f39-9832-aca9d8263987	true	access.token.claim
c0536b5c-2631-4f39-9832-aca9d8263987	email	claim.name
c0536b5c-2631-4f39-9832-aca9d8263987	String	jsonType.label
bbc8bb95-e7b8-4461-92ed-6e345fd535bb	true	userinfo.token.claim
bbc8bb95-e7b8-4461-92ed-6e345fd535bb	emailVerified	user.attribute
bbc8bb95-e7b8-4461-92ed-6e345fd535bb	true	id.token.claim
bbc8bb95-e7b8-4461-92ed-6e345fd535bb	true	access.token.claim
bbc8bb95-e7b8-4461-92ed-6e345fd535bb	email_verified	claim.name
bbc8bb95-e7b8-4461-92ed-6e345fd535bb	boolean	jsonType.label
9977ace3-6b29-4cf5-b522-b4f509ccf448	formatted	user.attribute.formatted
9977ace3-6b29-4cf5-b522-b4f509ccf448	country	user.attribute.country
9977ace3-6b29-4cf5-b522-b4f509ccf448	postal_code	user.attribute.postal_code
9977ace3-6b29-4cf5-b522-b4f509ccf448	true	userinfo.token.claim
9977ace3-6b29-4cf5-b522-b4f509ccf448	street	user.attribute.street
9977ace3-6b29-4cf5-b522-b4f509ccf448	true	id.token.claim
9977ace3-6b29-4cf5-b522-b4f509ccf448	region	user.attribute.region
9977ace3-6b29-4cf5-b522-b4f509ccf448	true	access.token.claim
9977ace3-6b29-4cf5-b522-b4f509ccf448	locality	user.attribute.locality
0208e233-d6fb-4229-82a1-0fcdcf21f179	true	userinfo.token.claim
0208e233-d6fb-4229-82a1-0fcdcf21f179	phoneNumber	user.attribute
0208e233-d6fb-4229-82a1-0fcdcf21f179	true	id.token.claim
0208e233-d6fb-4229-82a1-0fcdcf21f179	true	access.token.claim
0208e233-d6fb-4229-82a1-0fcdcf21f179	phone_number	claim.name
0208e233-d6fb-4229-82a1-0fcdcf21f179	String	jsonType.label
f4b11139-52b0-4267-b9a8-bd2dfaab06d7	true	userinfo.token.claim
f4b11139-52b0-4267-b9a8-bd2dfaab06d7	phoneNumberVerified	user.attribute
f4b11139-52b0-4267-b9a8-bd2dfaab06d7	true	id.token.claim
f4b11139-52b0-4267-b9a8-bd2dfaab06d7	true	access.token.claim
f4b11139-52b0-4267-b9a8-bd2dfaab06d7	phone_number_verified	claim.name
f4b11139-52b0-4267-b9a8-bd2dfaab06d7	boolean	jsonType.label
3496904c-b684-4fad-8948-44944c88154b	true	multivalued
3496904c-b684-4fad-8948-44944c88154b	foo	user.attribute
3496904c-b684-4fad-8948-44944c88154b	true	access.token.claim
3496904c-b684-4fad-8948-44944c88154b	realm_access.roles	claim.name
3496904c-b684-4fad-8948-44944c88154b	String	jsonType.label
e269e484-563d-4b8c-936e-e261bb6b79d4	true	multivalued
e269e484-563d-4b8c-936e-e261bb6b79d4	foo	user.attribute
e269e484-563d-4b8c-936e-e261bb6b79d4	true	access.token.claim
e269e484-563d-4b8c-936e-e261bb6b79d4	resource_access.${client_id}.roles	claim.name
e269e484-563d-4b8c-936e-e261bb6b79d4	String	jsonType.label
441edd4e-82fb-4a85-98f3-534fef8713ee	true	userinfo.token.claim
441edd4e-82fb-4a85-98f3-534fef8713ee	username	user.attribute
441edd4e-82fb-4a85-98f3-534fef8713ee	true	id.token.claim
441edd4e-82fb-4a85-98f3-534fef8713ee	true	access.token.claim
441edd4e-82fb-4a85-98f3-534fef8713ee	upn	claim.name
441edd4e-82fb-4a85-98f3-534fef8713ee	String	jsonType.label
55989ce9-0c69-4301-aa50-decee2e1dd34	true	multivalued
55989ce9-0c69-4301-aa50-decee2e1dd34	foo	user.attribute
55989ce9-0c69-4301-aa50-decee2e1dd34	true	id.token.claim
55989ce9-0c69-4301-aa50-decee2e1dd34	true	access.token.claim
55989ce9-0c69-4301-aa50-decee2e1dd34	groups	claim.name
55989ce9-0c69-4301-aa50-decee2e1dd34	String	jsonType.label
3d6eff80-84a2-454d-85ae-f0c520ae9fc0	true	userinfo.token.claim
3d6eff80-84a2-454d-85ae-f0c520ae9fc0	locale	user.attribute
3d6eff80-84a2-454d-85ae-f0c520ae9fc0	true	id.token.claim
3d6eff80-84a2-454d-85ae-f0c520ae9fc0	true	access.token.claim
3d6eff80-84a2-454d-85ae-f0c520ae9fc0	locale	claim.name
3d6eff80-84a2-454d-85ae-f0c520ae9fc0	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me) FROM stdin;
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	aa3c5886-d7dc-420c-9d07-4ce5eb20caf8	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	fdad8163-b72d-4d95-98dc-8b34d8981926	44812a01-cfe5-4377-bc50-d80f6a79d07e	5906f44e-1e13-463e-a1c4-f3d32235996e	fa2de638-411a-4a68-8973-e0b521e7274c	161cfb4d-5e6f-4036-9160-e01ec28f7825	2592000	f	900	t	f	89129de5-51ca-4651-8d52-18ec6a510398	0	f	0	0
Questboard	60	300	300	\N	\N	\N	t	f	0	\N	Questboard	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	ac07db7f-2cc1-4841-876b-40b8516f39f9	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	5ccee21d-5830-4d81-b3bc-0813915154ce	3474f741-cae1-4457-a200-ec235b3c79e5	27df431e-3093-4a42-94d9-2142eeb472b7	23c8b7cf-7406-4094-9ff0-03951ddc1fe8	f4d06149-75af-41ff-821f-f3be8c2fc6c3	2592000	f	900	t	f	1f8742dc-142e-4cc4-8629-0a7d323588de	0	f	0	0
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, value, realm_id) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly		master
_browser_header.xContentTypeOptions	nosniff	master
_browser_header.xRobotsTag	none	master
_browser_header.xFrameOptions	SAMEORIGIN	master
_browser_header.contentSecurityPolicy	frame-src 'self'; frame-ancestors 'self'; object-src 'none';	master
_browser_header.xXSSProtection	1; mode=block	master
_browser_header.strictTransportSecurity	max-age=31536000; includeSubDomains	master
bruteForceProtected	false	master
permanentLockout	false	master
maxFailureWaitSeconds	900	master
minimumQuickLoginWaitSeconds	60	master
waitIncrementSeconds	60	master
quickLoginCheckMilliSeconds	1000	master
maxDeltaTimeSeconds	43200	master
failureFactor	30	master
displayName	Keycloak	master
displayNameHtml	<div class="kc-logo-text"><span>Keycloak</span></div>	master
offlineSessionMaxLifespanEnabled	false	master
offlineSessionMaxLifespan	5184000	master
displayName	Questboard	Questboard
bruteForceProtected	false	Questboard
permanentLockout	false	Questboard
maxFailureWaitSeconds	900	Questboard
minimumQuickLoginWaitSeconds	60	Questboard
waitIncrementSeconds	60	Questboard
quickLoginCheckMilliSeconds	1000	Questboard
maxDeltaTimeSeconds	43200	Questboard
failureFactor	30	Questboard
actionTokenGeneratedByAdminLifespan	43200	Questboard
actionTokenGeneratedByUserLifespan	300	Questboard
offlineSessionMaxLifespanEnabled	false	Questboard
offlineSessionMaxLifespan	5184000	Questboard
clientSessionIdleTimeout	0	Questboard
clientSessionMaxLifespan	0	Questboard
clientOfflineSessionIdleTimeout	0	Questboard
clientOfflineSessionMaxLifespan	0	Questboard
webAuthnPolicyRpEntityName	keycloak	Questboard
webAuthnPolicySignatureAlgorithms	ES256	Questboard
webAuthnPolicyRpId		Questboard
webAuthnPolicyAttestationConveyancePreference	not specified	Questboard
webAuthnPolicyAuthenticatorAttachment	not specified	Questboard
webAuthnPolicyRequireResidentKey	not specified	Questboard
webAuthnPolicyUserVerificationRequirement	not specified	Questboard
webAuthnPolicyCreateTimeout	0	Questboard
webAuthnPolicyAvoidSameAuthenticatorRegister	false	Questboard
webAuthnPolicyRpEntityNamePasswordless	keycloak	Questboard
webAuthnPolicySignatureAlgorithmsPasswordless	ES256	Questboard
webAuthnPolicyRpIdPasswordless		Questboard
webAuthnPolicyAttestationConveyancePreferencePasswordless	not specified	Questboard
webAuthnPolicyAuthenticatorAttachmentPasswordless	not specified	Questboard
webAuthnPolicyRequireResidentKeyPasswordless	not specified	Questboard
webAuthnPolicyUserVerificationRequirementPasswordless	not specified	Questboard
webAuthnPolicyCreateTimeoutPasswordless	0	Questboard
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	false	Questboard
_browser_header.contentSecurityPolicyReportOnly		Questboard
_browser_header.xContentTypeOptions	nosniff	Questboard
_browser_header.xRobotsTag	none	Questboard
_browser_header.xFrameOptions	SAMEORIGIN	Questboard
_browser_header.contentSecurityPolicy	frame-src 'self'; frame-ancestors 'self'; object-src 'none';	Questboard
_browser_header.xXSSProtection	1; mode=block	Questboard
_browser_header.strictTransportSecurity	max-age=31536000; includeSubDomains	Questboard
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_default_roles; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_roles (realm_id, role_id) FROM stdin;
master	2c0bd327-20dc-4251-9484-44422e9dc412
master	a8b38048-1674-4e2a-8e71-19e30075002a
Questboard	a6a12309-c484-497a-907f-0467489253b8
Questboard	6f91c7ad-8161-41f6-846e-5b34291faaf6
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
Questboard	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
password	password	t	t	Questboard
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
08c97ad9-d906-4644-93bd-ea0584cad180	/realms/master/account/*
abab6a4a-5863-456c-8348-10e029a86820	/realms/master/account/*
d1055f6d-d48d-4be5-a2de-f748e592a2a3	/admin/master/console/*
52bd5914-a6e4-4757-87dd-effc52813817	/realms/Questboard/account/*
79f4d5db-6766-48a6-a093-1a8d5b48c2ff	/realms/Questboard/account/*
94f39d5d-d7f4-419b-a7dc-32c526849238	/admin/Questboard/console/*
95468c3a-ced2-4a92-84cb-64fe8c289298	http://127.0.0.1:7070/auth/callback
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
3fda4390-1e0c-406f-a329-a8827d8b9ceb	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
65bfeccb-da64-409d-8c21-9b0fc437ad1f	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
d6d10ee6-190f-4eba-88e1-77ace12912c4	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
879ec99a-4d41-4a00-a0f9-76057e42214f	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
b1b1b224-9d63-46c3-bd67-7070247659f9	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
6c773de0-49e2-4e02-94f2-4d2a75960308	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
e2c86cc5-c5dc-4879-9a30-6d15e4ce50b3	delete_account	Delete Account	master	f	f	delete_account	60
581f34c3-80dc-4fb5-a3c1-dd6be15c96ce	VERIFY_EMAIL	Verify Email	Questboard	t	f	VERIFY_EMAIL	50
30f5307f-099c-4349-ae24-707df42f6056	UPDATE_PROFILE	Update Profile	Questboard	t	f	UPDATE_PROFILE	40
11f90623-cb45-47c6-b57e-8235b892be6f	CONFIGURE_TOTP	Configure OTP	Questboard	t	f	CONFIGURE_TOTP	10
e0ec7213-6152-420a-9dc2-7e8eb46031b6	UPDATE_PASSWORD	Update Password	Questboard	t	f	UPDATE_PASSWORD	30
29d619d2-260b-4341-95b6-54b779527860	terms_and_conditions	Terms and Conditions	Questboard	f	f	terms_and_conditions	20
7f2d5f9d-9bb1-4e71-9eb0-986e1edfca68	update_user_locale	Update User Locale	Questboard	t	f	update_user_locale	1000
7788c0da-0f1b-4aed-baf6-232b1866042d	delete_account	Delete Account	Questboard	f	f	delete_account	60
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
abab6a4a-5863-456c-8348-10e029a86820	f4b1ad07-5b38-4249-8e82-73052a099da7
79f4d5db-6766-48a6-a093-1a8d5b48c2ff	923a0957-09f1-47bf-b886-c2fa0814c72a
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
4b150326-5715-4cdf-a759-d228d0f293df	\N	cecd7dfe-fcb3-4ceb-87fe-e7691d9242fb	f	t	\N	\N	\N	master	admin	1615523685516	\N	0
79bd681b-e3fc-4249-9229-d3047a5df2e3	yongjia@email.com	yongjia@email.com	f	t	\N	yongjia	chan	Questboard	yongjia	1615542836943	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
a8b38048-1674-4e2a-8e71-19e30075002a	4b150326-5715-4cdf-a759-d228d0f293df
2c0bd327-20dc-4251-9484-44422e9dc412	4b150326-5715-4cdf-a759-d228d0f293df
5e09a80d-c6b5-42dd-8e13-48f529df7d9e	4b150326-5715-4cdf-a759-d228d0f293df
f4b1ad07-5b38-4249-8e82-73052a099da7	4b150326-5715-4cdf-a759-d228d0f293df
b2fcbad4-37ab-4cf6-bab2-0c4bbbb44af6	4b150326-5715-4cdf-a759-d228d0f293df
a6a12309-c484-497a-907f-0467489253b8	79bd681b-e3fc-4249-9229-d3047a5df2e3
6f91c7ad-8161-41f6-846e-5b34291faaf6	79bd681b-e3fc-4249-9229-d3047a5df2e3
923a0957-09f1-47bf-b886-c2fa0814c72a	79bd681b-e3fc-4249-9229-d3047a5df2e3
c49ec061-2d19-4bd7-b738-3c79e7cb0f16	79bd681b-e3fc-4249-9229-d3047a5df2e3
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
d1055f6d-d48d-4be5-a2de-f748e592a2a3	+
94f39d5d-d7f4-419b-a7dc-32c526849238	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: client_default_roles constr_client_default_roles; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT constr_client_default_roles PRIMARY KEY (client_id, role_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: realm_default_roles constraint_realm_default_roles; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT constraint_realm_default_roles PRIMARY KEY (realm_id, role_id);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client_default_roles uk_8aelwnibji49avxsrtuf6xjow; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT uk_8aelwnibji49avxsrtuf6xjow UNIQUE (role_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: realm_default_roles uk_h4wpd7w4hsoolni3h0sw7btje; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT uk_h4wpd7w4hsoolni3h0sw7btje UNIQUE (role_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_def_roles_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_def_roles_client ON public.client_default_roles USING btree (client_id);


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_def_roles_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_roles_realm ON public.realm_default_roles USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_client fk_c_cli_scope_client; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_client FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_scope_client fk_c_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_roles fk_evudb1ppw84oxfax2drs03icc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT fk_evudb1ppw84oxfax2drs03icc FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: keycloak_group fk_group_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT fk_group_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_default_roles fk_nuilts7klwqw2h8m2b5joytky; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT fk_nuilts7klwqw2h8m2b5joytky FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client fk_p56ctinxxb9gsk57fo49f9tac; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT fk_p56ctinxxb9gsk57fo49f9tac FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope fk_realm_cli_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT fk_realm_cli_scope FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2 (Debian 13.2-1.pgdg100+1)
-- Dumped by pg_dump version 13.2 (Debian 13.2-1.pgdg100+1)

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: keycloak
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO keycloak;

\connect postgres

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: keycloak
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

